# Using TTreeReader vs RDataFrame

I eventually went back to using {ref}`TTreeReader <subsec:ttreereader>` because
of a problem with using `RDataFrame`. In the following script, I comment out
the `Foreach` function call, whicih is the part that seems to be causing the problem.
::::{dropdown} RDataFrame Foreach
``` c++
double count_passed_events_v2(TString file_prefix, int num_jobs){

  // initialize TChain and loop through all subdirectories, adding root files to chain.
  TChain chain("passTree");

  for(int i=1; i<=num_jobs; i++){

    TString file_name ("");
    file_name.Form(file_prefix + "/run%d/IceFinal_%d_passTree1.root", i ,i);

    chain.Add(file_name); 
  }

  RDataFrame df(chain);
  
  double weighted_passed_count=0.;
  // lambda expression that computes the weighted count 
  auto count = [&weighted_passed_count] (const double &w1, const double &w2, const double &w3){
    weighted_passed_count += w1/(w2*w3);
  };
  
  // df.Foreach(count, {"event.neutrino.path.weight",
  //                     "event.loop.positionWeight",
  //                     "event.loop.directionWeight"});
  return weighted_passed_count;

}
```
::::
As soon as this is uncommented, the
script can only be run once. That is, it will work fine the first time when I
type `root effar.C` where `effar.C` calls `count_passed_events_v2`, but in the
ROOT interactive mode, if I try to execute the script again using `.x effar.C`, this
script leads to a segmentation fault. It seems like the seg-fault has to do
with the lambda expression, but I am not sure.

```{admonition} TODO
:class: dropdown
Ask about this on ROOT Forum.
```

Below is the full script in which, instead of `RDataFrame`, I used `TTreeReader`,
which does not seg-fault.

::::{dropdown} TTreeReader reader.Next()
``` c++
double count_passed_events(TString file_prefix, int num_jobs){

  // initialize TChain and loop through all subdirectories, adding root files to chain.
  TChain *my_chain = new TChain("passTree");

  for(int i=1; i<=num_jobs; i++){

    TString file_name ("");
    file_name.Form(file_prefix + "/run%d/IceFinal_%d_passTree1.root", i ,i);

    my_chain->Add(file_name); 
  }
  
  TTreeReader reader(my_chain);

  TTreeReaderValue<double_t> w1(reader, "event.neutrino.path.weight");
  TTreeReaderValue<double_t> w2(reader, "event.loop.positionWeight");
  TTreeReaderValue<double_t> w3(reader, "event.loop.directionWeight");

  double weighted_passed_event_count;
  while (reader.Next()) {
    weighted_passed_event_count += *w1/(*w2 * *w3); 
  }

  delete my_chain;
  return weighted_passed_event_count;
}

void effar(){
  
  const double ice_volume = 26859227.0607;
  const double prefactor = ice_volume * 4 * M_PI;
  const int e21_interaction_length = 141324./1e3;
  const int e20_interaction_length = 267669./1e3;
  const int e19_interaction_length = 528717./1e3;
  const int e18_interaction_length = 1.10053e+06/1e3;

  int num_jobs;
  int nnt;
  int energy;
  TString file_path("");

  nnt = 100;
  energy = 21;
  file_path.Form("../2023-12-21_nnt_%d_energy_%d",nnt, energy);
  num_jobs = count_files(file_path);
  double vol21 = prefactor * count_passed_events(file_path, num_jobs) / (nnt * num_jobs);
  
  nnt = 100;
  energy = 20;
  file_path.Form("../2023-12-21_nnt_%d_energy_%d",nnt, energy);
  num_jobs = count_files(file_path);
  double vol20 = prefactor * count_passed_events(file_path, num_jobs) / (nnt * num_jobs);

  nnt = 400;
  energy = 19;
  file_path.Form("../2023-12-21_nnt_%d_energy_%d",nnt, energy);
  num_jobs = count_files(file_path);
  double vol19 = prefactor * count_passed_events(file_path, num_jobs) / (nnt * num_jobs);

  nnt = 1000;
  energy = 18;
  file_path.Form("../2023-12-21_nnt_%d_energy_%d",nnt, energy);
  num_jobs = count_files(file_path);
  double vol18 = prefactor * count_passed_events(file_path, num_jobs) / (nnt * num_jobs);


  // --------------   Data  --------------  //
  double effar[4] = {vol21/(e21_interaction_length), vol20/(e20_interaction_length),
                     vol19/(e19_interaction_length), vol18/(e18_interaction_length) };
  double e[4] = {1e21, 1e20, 1e19, 1e18};
  
  double effar_old[8] = {0.0030019, 0.2665, 4.45, 18.89, 41.3415, 77.749,122.65, 169.992};
  double e_old[8] = {3.17e+17, 2.01e+18, 4.21e+18, 2.009e+19, 4.205e+19, 2.017e+20, 4.19e+20, 1.013e+21};

  // --------------  Drawing --------------  //
  
  TCanvas * c = new TCanvas("","",1400,900);
  c->SetLogy();
  c->SetLogx();

  auto mg = new TMultiGraph();
  mg->SetTitle("Effective Area Comparison");

  TGraph *gr = new TGraph(8, e_old, effar_old);
  gr->SetMarkerStyle(kFullCircle);
  gr->SetMarkerColorAlpha(kBlue,0.35);
  mg->Add(gr);

  TGraph *gr_2 = new TGraph(4, e, effar);
  gr_2->SetMarkerStyle(kFullCross);
  gr_2->SetMarkerSize(1.5);
  gr_2->SetMarkerColorAlpha(46,0.35);
  mg->Add(gr_2);
  

  mg->GetXaxis()->SetTitle("energy [eV]");
  mg->GetXaxis()->SetTitleOffset(1.1);
  mg->GetYaxis()->SetTitle("effective area [km^{2} sr]");
  mg->Draw("ALP");

  TLegend * leg = new TLegend(0.2,0.75,0.4,0.9);
  leg->AddEntry(gr, "previous data");
  leg->AddEntry(gr_2, "data from my test run");
  leg->Draw();

  TString of_name = "../img/effective_area_plot.png";
  c->SaveAs(of_name);
}
```
::::


It might be just in my head, but I think using `TTreeReader` is slightly faster.
```{admonition} TODO
:class: dropdown
Time this.
```
