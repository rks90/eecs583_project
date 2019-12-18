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
#include "llvm/Analysis/LoopPass.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/GlobalVariable.h"
#include <set>
#include "llvm/IR/Constants.h"
#include "llvm/IR/User.h"
//#include "llvm/Analysis/ScalarEvolution.h"

#include <regex>
#include <string>
#include <unordered_map>

using namespace llvm;
using namespace std;
const char *AnnotationString = "kernel";

namespace {
	struct g2s : public FunctionPass {
		static char ID;
		//LLVMContext cont;
		g2s() : FunctionPass(ID) {}
		std::set<Function*> annotFuncs;
		void getAnnotatedFunctions(Module *M){
			for (Module::global_iterator I = M->global_begin(),E = M->global_end();I != E;++I) {
				if (I->getName() == "llvm.global.annotations") {
					ConstantArray *CA = dyn_cast<ConstantArray>(I->getOperand(0));
					for(auto OI = CA->op_begin(); OI != CA->op_end(); ++OI){
						ConstantStruct *CS = dyn_cast<ConstantStruct>(OI->get());
						Function *FUNC = dyn_cast<Function>(CS->getOperand(0)->getOperand(0));
						GlobalVariable *AnnotationGL = dyn_cast<GlobalVariable>(CS->getOperand(1)->getOperand(0));
						StringRef annotation = dyn_cast<ConstantDataArray>(AnnotationGL->getInitializer())->getAsCString();
						errs() << "Annotation: " << FUNC->getName() << " " << annotation << "\n";
						if(annotation.compare(AnnotationString)==0){
							annotFuncs.insert(FUNC);
							errs() << "Found annotated function " << FUNC->getName()<<"\n";
						}
					}
				}
			}
		}
		void* getGEPIndexIns(Instruction* i, string ind_var, bool change = false) {
			bool swapIndices = change;
			Value* v;
			Value* to_replace0;
			Value* to_replace1;
			if (i->getOpcode() == Instruction::GetElementPtr) {
				for (Use &U : dyn_cast<GetElementPtrInst>(i)->indices()) {
					v = U.get();
					errs() << "Value: " << v->getName() << "\n";
					if (!isa_and_nonnull<Constant>(v)) {
						i = dyn_cast<Instruction>(v);
						errs() << "Ins: " << *i << "\n";
						getGEPIndexIns(i,ind_var,swapIndices);
					}
				}
			} else {
				for (Use &U : i->operands()) {
					v = U.get();
					errs() << "Value: " << v->getName() << "\n";
					if (!isa_and_nonnull<Constant>(v)) {
						i = dyn_cast<Instruction>(v);
						errs() << "Ins: " << *i << "\n";
						//Modify indicies here
						if (i->isBinaryOp() && swapIndices) {
							errs() << "Swapping Indices From: " << *i << "\n";
							if (!(i->getOperand(0)->hasName())) {
							 	to_replace0 = i->getOperand(0);
							 	for (Use &U1: i->getOperand(1)->uses()) {
									Value* vtmp = U1.get();
									if (!isa_and_nonnull<Constant>(v)) {
										Instruction* itmp = dyn_cast<Instruction>(vtmp);
										errs() << "Swapping Indices to: " << *itmp << "\n";
										if (itmp->getOperand(0)->hasName()) {
							 				to_replace1 = itmp->getOperand(0);
											itmp->setOperand(0,to_replace0);
										} else if (itmp->getOperand(1)->hasName()) {
							 				to_replace1 = itmp->getOperand(1);
											itmp->setOperand(1,to_replace0);
										}
										itmp->moveBefore(i);
										i->setOperand(0,to_replace1);
										swapIndices = false;
									}
								}
							} else if (!(i->getOperand(1)->hasName())) {
							 	to_replace0 = i->getOperand(1);
							 	for (Use &U1: i->getOperand(1)->uses()) {
									Value* vtmp = U1.get();
									if (!isa_and_nonnull<Constant>(v)) {
										Instruction* itmp = dyn_cast<Instruction>(vtmp);
										errs() << "Swapping Indices to: " << *itmp << "\n";
										if (itmp->getOperand(0)->hasName()) {
							 				to_replace1 = itmp->getOperand(0);
											itmp->setOperand(0,to_replace0);
										} else if (itmp->getOperand(1)->hasName()) {
							 				to_replace1 = itmp->getOperand(1);
											itmp->setOperand(1,to_replace0);
										}
										itmp->moveBefore(i);
										i->setOperand(1,to_replace1);
										swapIndices = false;
									}
								}
							}
						swapIndices = false;
					} else if (i->getOpcode() == Instruction::Load) {
						if (i->getOperand(0)->getName() != ind_var) {
							Instruction* ci;
							if (i->getOperand(0)->getName() == "x") {
								errs() << "Replacing Load with threadId: " << *i << "\n"; 
								ci = sreg_x_ci->clone();
								ReplaceInstWithInst(i,ci);
								i=ci;
							} else if (i->getOperand(0)->getName() == "y") {
								errs() << "Replacing Load with threadId: " << *i << "\n"; 
								ci = sreg_y_ci->clone();
								ReplaceInstWithInst(i,ci);
								i=ci;
							}
							errs() << "Replacing Load with threadId New: " << *i << "\n"; 
						}
					}
					getGEPIndexIns(i,ind_var,swapIndices);
				}
			}
		}
		return nullptr;
	}

		void getAnalysisUsage(AnalysisUsage &AU) const override {
			AU.addPreserved<LoopInfoWrapperPass>();
			getLoopAnalysisUsage(AU);
			//AU.addPreserved<ScalarEvolutionWrapperPass>();
		}
		GlobalVariable* shared_array;
		GlobalVariable* shared_array_2;
		GlobalVariable* print_str;
		ArrayType* ArrTy;
		ArrayType* ArrTy2;
		Function* barrier;
		Function* sreg_x;
		Function* sreg_y;
		CallInst* sreg_x_ci;
		CallInst* sreg_y_ci;
		FunctionCallee print;
		FunctionType* FT;
		virtual bool doInitialization(Module &M) override {
			LLVMContext& context = M.getContext();
			//Create a new a shared memory variable
			ArrTy = ArrayType::get(IntegerType::get(context,32), 1024);
			ArrTy2 = ArrayType::get(IntegerType::get(context,8), 19);
			shared_array = new GlobalVariable(M, ArrTy, false, GlobalValue::ExternalWeakLinkage, nullptr,"shared_array", nullptr, GlobalValue::NotThreadLocal, unsigned(3), false);
			shared_array_2 = new GlobalVariable(M, ArrTy, false, GlobalValue::ExternalWeakLinkage, nullptr,"shared_array_2");
			//print_str = new GlobalVariable(M, ArrTy2, true, GlobalValue::InternalLinkage, ConstantDataArray::getString(context, "Hooray! Pass used\n",true),"print_str");
			FT = FunctionType::get(Type::getVoidTy(context),false);
			barrier = Function::Create(FT, Function::ExternalLinkage, "llvm.nvvm.barrier0", M);
			sreg_x = M.getFunction("llvm.nvvm.read.ptx.sreg.tid.x");
			sreg_y = M.getFunction("llvm.nvvm.read.ptx.sreg.tid.y");
			sreg_x_ci = CallInst::Create(sreg_x, "");
			sreg_y_ci = CallInst::Create(sreg_y, "");
			//print = M.getOrInsertFunction("vprintf",IntegerType::getInt32Ty(context), PointerType::get(Type::getInt8Ty(context), 0),PointerType::get(Type::getInt8Ty(context), 0));
			getAnnotatedFunctions(&M);
			return false;
		}
		virtual bool runOnFunction(Function &F) {
			//TODO:Run only on Kernel function
			regex func_rstr(".*copy.*|.*transpose.*");
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
				//ScalarEvolution& SE = getAnalysis<ScalarEvolutionWrapperPass>().getSE();
				Loop* L_clone;
				ValueToValueMapTy VMap;
				//Clone loop
				for (Loop *L : LI) {
					BasicBlock* header =L->getHeader();
					SmallVector<BasicBlock *,16> SVB;
					L_clone = cloneLoopWithPreheader(header, entry, L, VMap, "_clone", &LI, DT, SVB);
				}
				//Delete PreHeader and Fixup Cloned Inst uses
				BasicBlock* to_delete;
				unordered_map<string, BasicBlock*> bb_map;
				vector<Value*> dont_map;
				GetElementPtrInst* gep_clone1;
				GetElementPtrInst* gep_clone2;
				bool isFirst = true;
				bool isSecond = false;
				for (Function::iterator bb = F.begin(), e = F.end(); bb != e; ++bb) {
					//Remove the preheader
					regex bb_rstr("entry_clone");
					regex bb_rstr2(".*_clone");
					regex bb_rstr3("for.body_clone");
					regex bb_rstr4("for.body");
					string bb_name = bb->getName();
					bb_map.insert(make_pair(bb_name, &(*bb)));
					if (regex_match(bb_name,bb_rstr3)) {
						for (BasicBlock::iterator i = bb->begin(), e = bb->end(); i != e; ++i) {
							Instruction *Insn = &(*i);
							if ((Insn->getOpcode() == Instruction::GetElementPtr) && !isSecond) {
								isSecond = true;
							} else if ((Insn->getOpcode() == Instruction::GetElementPtr) && isSecond) {
								gep_clone1 = dyn_cast<GetElementPtrInst>(Insn);		
								for (unsigned index = 0, num_ops = gep_clone1->getNumOperands(); index != num_ops; ++index) {
									errs() << "GEP Operands: " << index << " " << gep_clone1->getOperand(index)->getName() << "\n";
								}
								isSecond = false;
								break;
							}
						}
					} else if (regex_match(bb_name,bb_rstr4)) {
						for (BasicBlock::iterator i = bb->begin(), e = bb->end(); i != e; ++i) {
							Instruction *Insn = &(*i);
							if ((Insn->getOpcode() == Instruction::GetElementPtr) && isFirst) {
								gep_clone2 = dyn_cast<GetElementPtrInst>(Insn);		
								for (unsigned index = 0, num_ops = gep_clone2->getNumOperands(); index != num_ops; ++index) {
									errs() << "GEP Operands: " << index << " " << gep_clone2->getOperand(index)->getName() << "\n";
								}
								isFirst = false;
								break;
							}
						}
					}
					if (regex_match(bb_name,bb_rstr)) {
						to_delete = &(*bb);
						for (BasicBlock::iterator i = bb->begin(), e = bb->end(); i != e; ++i) {
							Instruction *Insn = &(*i);
							Value *Op = dyn_cast<Value>(Insn);
							//errs() << "Adding Operand to dont_map: " << Op->getName() << "\n";
							dont_map.push_back(Op);
						}
					} else if (regex_match(bb_name,bb_rstr2)) {
						for (BasicBlock::iterator i = bb->begin(), e = bb->end(); i != e; ++i) {
							Instruction *Insn = &(*i);
							for (unsigned index = 0, num_ops = Insn->getNumOperands(); index != num_ops; ++index) {
								Value *Op = Insn->getOperand(index);
								ValueToValueMapTy::iterator OpItr = VMap.find(Op);
								//errs() << "ReMapping Operand: " << Op->getName() << "\n";
								if (OpItr != VMap.end()) {
									Value* new_V = OpItr->second;
									if (find(dont_map.begin(),dont_map.end(),new_V) == dont_map.end()) {
										Insn->setOperand(index, new_V);
									}
								}
							}
						}
					}
				}
				dont_map.erase(dont_map.begin());
				to_delete->eraseFromParent();
				
				//Create new for.end basic block
				BasicBlock* for_end_clone = BasicBlock::Create(F.getContext(), "for.end_clone", &F, bb_map["for.cond"]); 
				bb_map.insert(make_pair("for.end_clone", for_end_clone));
				//Create br 
				BranchInst::Create(bb_map["for.cond"],for_end_clone);
				Instruction* ind_v_store;
				string ind_var;
				//Fixup cloned loop branches
				for (Function::iterator bb = F.begin(), e = F.end(); bb != e; ++bb) {
					regex rstr(".*_clone|entry");
					regex rstr2(".*for.cond_clone");
					regex rstr3(".*for.end_clone");
					regex rstr4("entry");
					string bb_name = bb->getName();
					if (regex_match(bb_name,rstr) && (bb_name != "for.end_clone")) {
						Instruction* I = bb->getTerminator();
						BranchInst* BI = dyn_cast<BranchInst>(I);
						for (int ii = 0; ii < BI->getNumSuccessors(); ii++) {
							BasicBlock* succ_bb = BI->getSuccessor(ii);
							string succ_bb_name = succ_bb->getName();
							string new_succ_bb_name = succ_bb_name;
							new_succ_bb_name.append("_clone");
							if (!(regex_match(succ_bb_name,rstr))) {
								errs() << "Changing Successor of " << bb_name << " from " << succ_bb_name << " to " << new_succ_bb_name << "\n";
								if (bb_map.find(new_succ_bb_name) != bb_map.end()) {
									BI->setSuccessor(ii,bb_map[new_succ_bb_name]);
								}
							}
						}
					}
					if (regex_match(bb_name,rstr2)) {
						//Reset clone loop induction variable
						//This doesn't seem to work as there is no phi node
						//PHINode* ind_var = L_clone->getInductionVariable(SE);
						//errs() << "Ind Var: " <<  ind_var << "\n";
						//Loop on for.cond_clone block to determine induction variable
						Instruction* I = bb->getTerminator();
						BranchInst* BI = dyn_cast<BranchInst>(I);
						Value* v = BI->getCondition();
						ind_var = v->getName();
						Instruction* i = dyn_cast<Instruction>(v);
						while(i->getOpcode() != Instruction::Alloca) {
							errs() << "Ins1: " << *i << "\n";
							for (Use &U : i->operands()) {
								v = U.get();
								errs() <<  "Value: " << v << " " << v->getName() << "\n";
								if (!isa<Constant>(v)) {
									i = dyn_cast<Instruction>(v);
									errs() << "Ins: " << *i << "\n";
								}
							}
						}
						for (User *U : i->users()) {
							i = dyn_cast<Instruction>(U);
							errs() << "Ins: " << *i << "\n";
							if ((i->getOpcode() == Instruction::Store) && (i->getParent()->getName() == "entry")) {
								break;
							}
						}
						ind_v_store = i->clone();
					}
					if (regex_match(bb_name,rstr3)) {
						ind_v_store->insertBefore(bb->getTerminator());
						//Insert barrier
						CallInst::Create(barrier, "",bb->getTerminator());
					}
					if (regex_match(bb_name,rstr4)) {
						//Add print statement
						//Value* indexList[2] = {ConstantInt::get(IntegerType::get(F.getContext(),64), 0), ConstantInt::get(IntegerType::get(F.getContext(),64), 0)};
						//GetElementPtrInst* print_str_gep = GetElementPtrInst::CreateInBounds(ArrTy2, print_str, ArrayRef<Value*>(indexList,2),"",bb->getTerminator());
						//Value* null = ConstantPointerNull::get(PointerType::get(Type::getInt8Ty(F.getContext()), 0));
						//Value* print_args[2] = {dyn_cast<Value>(print_str_gep), null};
						//CallInst::Create(print, ArrayRef<Value*>(print_args,2),"",bb->getTerminator());
					}
				}
				//Change GEP instruction in cloned to the shared memory variable
				Instruction* gep_clone1_inst = dyn_cast<Instruction>(gep_clone1);
				Instruction* gep_clone2_inst = dyn_cast<Instruction>(gep_clone2);
				AddrSpaceCastInst* shared_array_cast_1 = new AddrSpaceCastInst(shared_array, shared_array_2->getType(), "", gep_clone1_inst);
				AddrSpaceCastInst* shared_array_cast_2 = new AddrSpaceCastInst(shared_array, shared_array_2->getType(), "", gep_clone2_inst);
				Value* indexList1[2] = {ConstantInt::get(gep_clone1->getOperand(1)->getType(), 0), gep_clone1->getOperand(1)};
				Value* indexList2[2] = {ConstantInt::get(gep_clone2->getOperand(1)->getType(), 0), gep_clone2->getOperand(1)};
				GetElementPtrInst* shared_gep_store = GetElementPtrInst::CreateInBounds(ArrTy, shared_array_cast_1, ArrayRef<Value*>(indexList1,2));
				GetElementPtrInst* shared_gep_load = GetElementPtrInst::CreateInBounds(ArrTy, shared_array_cast_2, ArrayRef<Value*>(indexList2,2));
				errs() << "New GEP: " <<  *shared_gep_store << "\n";
				errs() << "New GEP: " <<  *shared_gep_load << "\n";
				errs() << "New GEP Source Type: " << shared_gep_store->getSourceElementType()->getTypeID() << "\n";
				errs() << "New GEP Source Type: " << shared_gep_load->getSourceElementType()->getTypeID() << "\n";
				errs() << "Old GEP Source Type: " << gep_clone1->getSourceElementType()->getTypeID() << "\n";
				errs() << "Old GEP Source Type: " << gep_clone2->getSourceElementType()->getTypeID() << "\n";
				//errs() << "New GEP Result Type: " << shared_gep_store->getResultElementType()->getTypeID() << "\n";
				//errs() << "New GEP Result Type: " << shared_gep_load->getResultElementType()->getTypeID() << "\n";
				//errs() << "Old GEP Result Type: " << gep_clone1->getResultElementType()->getTypeID() << "\n";
				//errs() << "Old GEP Result Type: " << gep_clone2->getResultElementType()->getTypeID() << "\n";
				//errs() << "New GEP Pointer Type: " << shared_gep_store->getPointerOperandType()->getTypeID() << "\n";
				//errs() << "New GEP Pointer Type: " << shared_gep_load->getPointerOperandType()->getTypeID() << "\n";
				//errs() << "Old GEP Pointer Type: " << gep_clone1->getPointerOperandType()->getTypeID() << "\n";
				//errs() << "Old GEP Pointer Type: " << gep_clone2->getPointerOperandType()->getTypeID() << "\n";
				//Change GEP instruction in original loop to new shared memory variable
				BasicBlock::iterator ii1(gep_clone1);
				errs() << "GEP Clone1 " << shared_gep_store->getPointerOperand()->getName() << "\n";
				ReplaceInstWithInst(gep_clone1->getParent()->getInstList(), ii1, shared_gep_store);
				errs() << "GEP Clone1 " << shared_gep_store->getPointerOperand()->getName() << "\n";
				BasicBlock::iterator ii2(gep_clone2);
				ReplaceInstWithInst(gep_clone2->getParent()->getInstList(), ii2, shared_gep_load);
				//Replace new GEP indices
				errs() << "GEP Clone1 " << shared_gep_store->getPointerOperand()->getName() << "\n";
				getGEPIndexIns(dyn_cast<Instruction>(shared_gep_store), ind_var, true);
				getGEPIndexIns(dyn_cast<Instruction>(shared_gep_load), ind_var, false);
				//Following causes segfault workaround: first insert and then remove
				sreg_x_ci->insertBefore(shared_gep_load);
				sreg_y_ci->insertBefore(shared_gep_load);
				sreg_x_ci->eraseFromParent();
				sreg_y_ci->eraseFromParent();
				/*
				Instruction* I = gep_clone1;
				errs() << "Current Instr: ";
				errs() << *I << "\n";
				//Iterate over users of the Instr
				Value*v=dyn_cast<Value>(I);
				errs()<<"CurrentOperand:";
				errs()<<v->getName()<<"\n";
				errs() << "Type: " << v->getType()->getTypeID() << "\n";
				for (auto u = v->user_begin(); u!= v->user_end(); u++) {
					Instruction *ui = dyn_cast<Instruction>((*u));
					if (ui != nullptr) {
						errs() << "Users: ";
						errs() << *ui << "\n";
					}
				}
				*/

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
