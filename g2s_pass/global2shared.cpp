#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/ADT/APFloat.h"
#include "llvm/Transforms/Utils/LoopUtils.h"
#include "llvm/IR/Instructions.h"

#include <regex>
#include <string>
#include <unordered_map>

using namespace llvm;
using namespace std;

namespace {
	struct g2s : public FunctionPass {
		static char ID;
		g2s() : FunctionPass(ID) {}
		void getAnalysisUsage(AnalysisUsage &AU) const override {
			AU.addPreserved<LoopInfoWrapperPass>();
			getLoopAnalysisUsage(AU);
		}
		virtual bool runOnFunction(Function &F) {
			//TODO:Run only on Kernel function
			regex func_rstr(".*copy.*");
			string func_name = F.getName();
			if (regex_match(func_name,func_rstr)) {
				errs() << "Function " << func_name << "\n";
				//GetEntryBlock
				BasicBlock* entry = &(F.getEntryBlock());
				//Get DomTree
				DominatorTree* DT = new DominatorTree();         
				DT->recalculate(F);
				//Get Loop info
				LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>().getLoopInfo();
				//Clone loop
				for (Loop *L : LI) {
					BasicBlock* header =L->getHeader();
					ValueToValueMapTy VMap;
					SmallVector<BasicBlock *,10> SVB;
					cloneLoopWithPreheader(header, entry, L, VMap, "_clone", &LI, DT, SVB);
				}
				//Delete PreHeader
				BasicBlock* to_delete;
				unordered_map<string, BasicBlock*> bb_map;
				for (Function::iterator bb = F.begin(), e = F.end(); bb != e; ++bb) {
					//Remove the preheader
					regex bb_rstr("entry_clone");
					string bb_name = bb->getName();
					if (regex_match(bb_name,bb_rstr)) {
						to_delete = &(*bb);
					} else {
						bb_map.insert(make_pair(bb_name, &(*bb)));
					}
				}
				to_delete->eraseFromParent();
				//Create new for.end basic block
				BasicBlock* for_end_clone = BasicBlock::Create(F.getContext(), "for.end_clone", &F, bb_map["for.cond"]); 
				bb_map.insert(make_pair("for.end_clone", for_end_clone));
				//Create br 
				BranchInst::Create(bb_map["for.cond"],for_end_clone);
				//Fixup cloned loop branches
				for (Function::iterator bb = F.begin(), e = F.end(); bb != e; ++bb) {
					regex rstr(".*_clone");
					//regex rstr(".*_clone|entry");
					string bb_name = bb->getName();
					if (regex_match(bb_name,rstr) && (bb_name != "for.end_clone")) {
						Instruction* I = bb->getTerminator();
						BranchInst* BI = dyn_cast<BranchInst>(I);
						for (int ii = 0; ii < BI->getNumSuccessors(); ii++) {
							BasicBlock* succ_bb = BI->getSuccessor(ii);
							string succ_bb_name = succ_bb->getName();
							string new_succ_bb_name = succ_bb_name;
							new_succ_bb_name.append("_clone");
							errs() << "Changing Successor of " << bb_name << " from " << succ_bb_name << " to " << new_succ_bb_name << "\n";
							if (bb_map.find(new_succ_bb_name) != bb_map.end()) {
								BI->setSuccessor(ii,bb_map[new_succ_bb_name]);
							}
						}
					}
				}
				
				
				/*
				//Iterate over BBs
				for (Function::iterator bb = F.begin(), e = F.end(); bb != e; ++bb) {
					//Print BB names
					//TODO: Check if the BB accesses global memory
					regex bb_rstr("for.*");
					string bb_name = bb->getName();
					BasicBlock* prev_bb;
					if (regex_match(bb_name,bb_rstr)) {
						errs() << "BB: " << bb_name << "\n";
						ValueToValueMapTy VMap;
						BasicBlock * cbb = CloneBasicBlock(const_cast<const BasicBlock*>(&(*bb)), VMap,"clone");
						cbb = SplitEdge(prev_bb,prev_bb->getSingleSuccessor());
						prev_bb = cbb;
					} else {
						prev_bb = &(*bb);
					}
					//for (BasicBlock::iterator i = bb->begin(), e = bb->end(); i != e; ++i) {
					//}
				}
				*/
			}
			return false;
		}
	};
}
char g2s::ID = 0;
static RegisterPass<g2s> X("g2s", "Copy Global to Shared");
