# Siena Pipeline for ASSIST Schools

## Brief Summary

The following repository is a demonstration of implementing stochastic actor based models in the Simulation Investigation Empirical Analysis (SIENA) framework on separate school data with the Method of Moments algorithm. The data is synthetically generated data of low fidelity to the ASSIST trial. The synthetic data was generated using GitHub Co-Pilot AI and Python. The purpose for generating low fidelity was for code development and demonstration of code. Email [2333157O@student.gla.ac.uk](mailto:2333157O@student.gla.ac.uk) if you would like to see the scripts on how this data was generated. The data is of low fidelity in the following respect:

- no correspondence to school level characteristics like school size 
- school IDs have no correspondence to ASSIST schools
- variable names do not match the ones in the original trial data

The friendship adjacency matrices are generated randomly. In terms of fidelity to the friendship generator the model dataset matches the original trial only in the following respect.  

- actors are allowed up to 6 outgoing ties per time point
- three waves of friendship data 

## Run the Pipeline on GitPod

### Step 1: Click the Button Below to Launch Workspace for this Repo

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#github.com/omiridoue/synthetic-rsiena-pipeline)

> This is a pre-built virtual environment. Once you've created the workspace re-launching it won't require much work as any installation will be cached. It just means we'll all be working with the same set-up. Just let it do its thing in the background, make sure you don't close the browser and maintain a stable Internet connection. You won't need to download anything to your computer. I have set up this remote workspace in order to allow you to take a look at the code, you can edit this directly and then commit any changes to the repository. Note you can set up everything locally but it will require you to set up a subsystem for Linux and install nextflow, apptainer and a java distribution. This will take time and effort - which you can skip if you're happy to use the online environment. 

You have 50 hours free work time per month! This is quite generous and means you can make use of it for collaborative projects in the future. 

### Step 2: Sign in with your GitHub Credentials

![alt text](docs/gitpod101.png)

### Step 3: Run the Pipeline

To run the pipeline you will need to type the following command in the terminal (this works with a bash or java terminal): 

```bash
nextflow run main.nf -profile local
```
