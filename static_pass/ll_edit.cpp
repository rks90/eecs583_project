#include <iostream>
#include <string>
#include <vector>
#include <fstream>

/* Example global declarations:
> @n = dso_local addrspace(1) externally_initialized global [1000 x float] zeroinitializer, align 4
> @nn = dso_local addrspace(1) externally_initialized global double 0.000000e+00, align 8

> @n = dso_local addrspace(3) global [1000 x float] undef, align 4
> @nn = dso_local addrspace(3) global double undef, align 8

< @n = dso_local addrspace(4) externally_initialized global [1000 x float] zeroinitializer, align 4
< @nn = dso_local addrspace(4) externally_initialized global double 0.000000e+00, align 8
*/

int main(int argc, char** args) {
        
    std::string line;
    std::vector<std::string> if_mod;
    
    std::ifstream mods_file("addrspace.change");
    while (std::getline(mods_file, line)) {
        if_mod.push_back(line);
    }
    
    while (std::getline(std::cin, line)) {
        
        if (line.length() >= 22 && line[0] == '@') {
        
            // Check that this variable is included in the list first!
            std::string word;
            int w = 1;
            while (line[w] != ' ') word.push_back(line[w++]);
            bool if_found = false;
            for (auto &k : if_mod) if (k == word) if_found = true;
            if (!if_found) goto continue_out_of_if;
            
            
            // Replace "addrspace(1)" with "addrspace(3)".
            for (int i = 0; i < line.length() - 12; i++) {
                if (line.substr(i, 12) == "addrspace(1)")
                    line[i + 10] = '3';
            }
            
            // Remove "externally_initialized".
            for (int i = 0; i < line.length() - 22; i++) {
                if (line.substr(i, 22) == "externally_initialized") {
                    line = line.substr(0, i - 1) + line.substr(i + 22);
                    break;
                }
            }
            
            // Replace word before the comma with "undef".
            for (int i = 0; i < line.length(); i++) {
                if (line[i] == ',') {
                    int start = i;
                    while (line[start - 1] != ' ') start--;
                    line = line.substr(0, start) + "undef" + line.substr(i);
                    break;
                }
            }
            
            continue_out_of_if:
                int lol = 101;
            
        }
        
        else {
        
            bool if_modify = false;
            for (auto &o : if_mod) {
                if ((line.find("@" + o) != std::string::npos) && (line.length() >= 12)) {
                
                    // Replace "addrspace(1)" with "addrspace(3)".
                    for (int i = 0; i < line.length() - 12; i++) {
                        if (line.substr(i, 12) == "addrspace(1)")
                            line[i + 10] = '3';
                    }
                    
                    break;
                    
                }
            }
            
        }
        
        /*(if (if_first_line)
            if_first_line = false;
        else
            std::cout << std::endl;*/
            
        std::cout << line << std::endl;
        
    }

}


