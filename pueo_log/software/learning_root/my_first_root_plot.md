# My First Root Plot


```{figure} ./img/my_flavor.png
---
name: my_flavor_plot
---
my neutrino flavor plot for run 1 out of 100.
```

I wrote a root-macro script to generate [](my_flavor_plot),
which is to be compared with the [](tbrowser_flavor).


```{figure} ./img/tbrowser_flavor.png
---
name: tbrowser_flavor
---
neutrino flavor plot for run 1 out of 100, generated using TBrowser.
```

---
The script (`plotter.cpp`) is as follows:
```{code-block} c++
#include <TCanvas.h>
#include <TFile.h>
#include <TH1F.h>
#include <TTree.h>
#include <iostream>
using namespace std;

// The lines above are not needed to run the macro but are included here so that my neovim
// Lsp can find the types such as TH1F. Note: also note that a compile_flags.txt file that has
// the proper include path, for example mine is -I/usr/include/root, is required for the Lsp
// to find the header files.

   //method name has to match file name
void plotter() {

  // ptr for pointer
  TFile *file_ptr = new TFile("2023-11-09_nnt_100.0_energy_21/run1/IceFinal_1_allTree.root","read");
  TCanvas *c1_ptr = new TCanvas();

            // file_ptr->Get("allTree") returns the address of allTree
            // but this needs to be casted to the correct type, which is done by
            // the  (TTree*)  part.
  TTree *tree_ptr = (TTree*)file_ptr->Get("allTree");
  // Alternatively, this first TTree *tree_ptr could have been auto *tree_ptr,
  // in which case we wouldn't need the casting.

  int flavor; // neutrino flavor

  // assigning the variable flavor above to the corresponding var. stored inside the root file
  // in this case the variable's name is eventSummary.neutrino.flavor
  tree_ptr->SetBranchAddress("eventSummary.neutrino.flavor",&flavor);

  // this particular root file contains 100 neutrinoes, so num_entries should be 100.
  int num_entries = tree_ptr->GetEntries();

                                                            // 4 bins, x start:0, x end: 4
  TH1F *hist_ptr = new TH1F("my_histogram", "histogram_title", 4, 0 ,4);

  for (int i=0; i<num_entries; i++){
    tree_ptr->GetEntry(i);
    hist_ptr->Fill(flavor);
  }

  hist_ptr->Draw();
  


  

}
```
