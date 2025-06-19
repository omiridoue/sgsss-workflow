# Section 07: Workflow

## Brief Summary

The following repository is a demonstration of implementing stochastic actor based models in the Simulation Investigation Empirical Analysis (SIENA) framework on separate school data with the Method of Moments algorithm. The synthetic data was generated using GitHub Co-Pilot AI and Python. The purpose for generating low fidelity was for code development and demonstration of code. The topic area of the data relates to my project looking at health and education research in schools. You can request the code scripts for the data generation functions with an email to [2333157O@student.gla.ac.uk](mailto:2333157O@student.gla.ac.uk). The data is of low fidelity in the following respect:

- no correspondence to school level characteristics like school size 
- school IDs have no correspondence to schools
- variable names do not match 

>  My project uses social network methods to study the evolution of friendships and smoking over time. Social network data can be structured in many forms, the example here involves friendship adjacency matrices. The 'friedship generator' questions refer to the questionnaire section where students are asked to name, nominate, peers as friends. 

In terms of fidelity to the friendship generator the synthetic dataset matches common data collection decisions:  

- actors are allowed up to 6 outgoing ties per time point
- three waves of friendship data 

To run the pipeline you will need to type the following command in the terminal (this works with a bash or java terminal): 

```bash
nextflow run main.nf -profile local
```
