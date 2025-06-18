# Siena Pipeline for ASSIST Schools

## Brief Summary

The following repository is a demonstration of implementing stochastic actor based models in the Simulation Investigation Empirical Analysis (SIENA) framework on separate school data with the Method of Moments algorithm. The data is synthetically generated data of low fidelity to the ASSIST trial. The synthetic data was generated using GitHub Co-Pilot AI and Python. The purpose for generating low fidelity was for code development and demonstration of code. Email [2333157O@student.gla.ac.uk](mailto:2333157O@student.gla.ac.uk) if you would like to see the scripts on how this data was generated. The data is of low fidelity in the following respect:

- no correspondence to school level characteristics like school size 
- school IDs have no correspondence to ASSIST schools
- variable names do not match the ones in the original trial data

The friendship adjacency matrices are generated randomly. In terms of fidelity to the friendship generator the model dataset matches the original trial only in the following respect.  

- actors are allowed up to 6 outgoing ties per time point
- three waves of friendship data 

To run the pipeline you will need to type the following command in the terminal (this works with a bash or java terminal): 

```bash
nextflow run main.nf -profile local
```
