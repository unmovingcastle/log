# Using TChain to combine files

I used the following script to plot some 2 dimensional histograms.

```` {dropdown} TChain Script
```
void dir(){

/* ---------- setup -------------*/

  int energy=21;

  TString histogram = "Passed Events";
  std::string x_name = "x";
  std::string y_name = "y";
  TString histogram_title = "Weighted (e=" +std::to_string(energy) +") "
                            +"Neutrino XY-direction Histogram;"
                            +x_name+";"
                            +y_name;

  // initialize histogram
  TH2F * h = new TH2F(histogram, histogram_title,  
                      100, 0, 1, 100,0,1);



/* ---------- begin -------------*/

  // initialize TChain and loop through all 100 subdirectories, adding root files to chain.
  TChain chain("passTree");
  for(int i=1; i<=100; i++){

    TString file_name = 
      "../2023-11-09_nnt_100.0_energy_"+ std::to_string(energy) + "/run"
      + std::to_string(i) 
      + "/IceFinal_"
      +std::to_string(i)+"_passTree1.root";

    chain.Add(file_name); 
  }
  
  RDataFrame df(chain);


  // lambda expression that fills the histogram with entries in the chain
  auto fill_histogram = [&h] (const TVector3 &v, 
                              const double &w1, const double &w2, const double &w3){

    // total weight = path weight / (position weight * direction weight)
    double weight = w1/(w2*w3);

    h->Fill(v.X(),v.Y(),weight); 
  };


  df.Foreach(fill_histogram, {"event.neutrino.path.direction", 
                              "event.neutrino.path.weight",
                              "event.loop.positionWeight",
                              "event.loop.directionWeight"});

/* ---------- Drawing -------------*/

  Double_t width = 900;
  Double_t height = 900;
  auto c = new TCanvas("c", "c", width, height);
  /* c->SetWindowSize(width + (width - c->GetWw()), height + (height - c->GetWh())); */
  c->SetWindowSize(width,height);

  gStyle->SetPalette(55);     // enables rainbow palette (up to red)
  gStyle->SetOptStat("ne");   // display only histogram name and number of entries
  h->Draw("colz");

}
```
````

```{figure} ./img/XY_unweighted.png
---
name: xy_unweighted
---
Unweighted plot of direction (x and y compoents)
```
```{figure} ./img/xz.png
---
name: xz
---
Weighted plot of direction (x and z compoents)
```
```{figure} ./img/XY.jpg
---
name: xy
---
Weighted plot of direction (x and y compoents)
```

