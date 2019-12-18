#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Analysis/MemoryLocation.h"
#include <unordered_map>
#include <string>
#include "llvm/Analysis/BranchProbabilityInfo.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/BlockFrequencyInfo.h"
#include "llvm/Analysis/BranchProbabilityInfo.h"
#include <sstream>
#include <iostream>
#include <iomanip>
#include <fstream>

using namespace llvm;

namespace {
    
    bool GetGlobalNameFromInstr(std::string input, std::string* output) {
        int st = 0, nd = 0;
        while (input[st++] != '@') { if (st >= input.length()) return false; }
        nd = st;
        while (input[nd++] != ' ') { if (nd >= input.length()) return false; }
        *output = input.substr(st, nd - st - 1);
        return true;
    }

    struct CTMemPass : public ModulePass {
        static char ID;
        CTMemPass() : ModulePass(ID) {}

        bool runOnModule(Module &M) override {
            bool if_any_modifications = false;
            
            std::vector<std::string> valid_gvs;
            std::unordered_map<std::string, int> reference_counts;
            
            errs() << "Global variables:\n";
            for (auto &g : M.getGlobalList()) {
                if (g.getAddressSpace() != 1) continue;
                std::string g_string;
                llvm::raw_string_ostream ss(g_string);
                ss << g;
                g_string = ss.str();
                if (g_string.find("blockId") != std::string::npos) continue;
                if (g_string.find("gridDim") != std::string::npos) continue;
                if (g_string.find("threadId") != std::string::npos) continue;
                if (g_string.find("blockDim") != std::string::npos) continue;
                int nd = 1;
                while (g_string[nd++] != ' ') { ; }
                std::string global_name = g_string.substr(1, nd - 2);
                valid_gvs.push_back(global_name);
                reference_counts[global_name] = 0;
            }
        
            for (auto &F : M.functions()) {
                
                // Begin function analysis code
                int num_instructions = 0;
                for (Function::iterator bb = F.begin(); bb != F.end(); bb++) {
                    for (BasicBlock::iterator i = bb->begin(); i != bb->end(); i++) {
                        num_instructions++;
                        
                        std::string n = i->getOpcodeName();
                        if (/*n == "load" || n == "store"*/ true) {
                            std::string i_string;
                            llvm::raw_string_ostream ss(i_string);
                            ss << *i;
                            i_string = ss.str();
                            std::string global_name;
                            if (GetGlobalNameFromInstr(i_string, &global_name)) {
                                reference_counts[global_name]++;
                                errs() << "  MEM  |  " << *i << "\n";
                            }
                        }
                        
                    }
                }
                
            }
            
            std::string current_best_variable = "";
            int current_most_uses = -1;
            for (auto &o : valid_gvs) {
                errs() << "  " << o << "\t" << reference_counts[o] << "\n";
                if (reference_counts[o] > current_most_uses) {
                    current_most_uses = reference_counts[o];
                    current_best_variable = o;
                }
            }
            std::ofstream f_out("addrspace.change");
            f_out << current_best_variable << "\n";
            
            return if_any_modifications;
            
        }

    };
}

char CTMemPass::ID = 0;
static RegisterPass<CTMemPass> X("CTMemPass", "GPU Constant/Texture memory pass", false, false);

