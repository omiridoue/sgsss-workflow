# Full demo: Building your Own Workflow 

The demo workflow involves simulation based analysis. Specifically, the following repository is a demonstration of implementing stochastic actor based models in the Simulation Investigation Empirical Analysis (SIENA) framework on separate school data with the simulation only framework. For further information see the suite of packages within [socnet](https://github.com/stocnet).
## Synthetic Data

The data involves low fidelity synthetic data. This means that the data is generated using functions, and only resembles real-world data in a very basic way. This type of synthetic can be useful for teaching and learning, or helping develop code. Generative AI was used to construct the data generating functions for this synthetic data. Please ensure any further use of this data includes this section. The code used to generate data can be shared upon request, drop a line to (PGR) Eleni Omiridou.

The synthetic data was generated using GitHub Co-Pilot AI and Python. The purpose for generating low fidelity was for code development and demonstration of code. The topic area of the data relates to my project looking at health and education research in schools. You can request the code scripts for the data generation functions with an email to [2333157O@student.gla.ac.uk](mailto:2333157O@student.gla.ac.uk). The data is of low fidelity in the following respect:

- no correspondence to school level characteristics like school size 
- school IDs have no correspondence to schools
- variable names do not match, reflect or convey any known existing dataset 

>  My project uses social network methods to study the evolution of friendships and smoking over time. Social network data can be structured in many forms, the example here involves friendship adjacency matrices. The 'friedship generator' questions refer to the questionnaire section where students are asked to name, nominate, peers as friends. 

In terms of fidelity to the friendship generator the synthetic dataset matches common data collection decisions:  

- actors are allowed up to 6 outgoing ties per time point
- three waves of friendship data 

## Set up - GitHub Codespaces

### Step 1: Open GitHub Codespaces

Click on the button below to launch a new codespace. If you are not already logged into GitHub in your browser then you may be prompted to do so.
Then click the option to create a new codespace. You can opt for all the default options or choose to change ex. machine type.

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/nextflow-io/training?quickstart=1&ref=master)

`Note: Steps 2 - 4 require you to copy and paste the code directly into your Terminal! Press Enter to run the code each time.`

### Step 2: Organise Template Files

```
mkdir templates
mv * templates/
```

`You will find the following message, this is ok the command will have worked as expected - mv: cannot move 'templates' to a subdirectory of itself, 'templates/templates'`

### Step 3: Read in Material Using Git

```
git clone --branch ready-set-workflow --single-branch https://github.com/omiridoue/sgsss-workflow.git

```

### Step 4: Change Directory

```
cd sgsss-workflow
```

### Local profile 

To run the pipeline on your local machine type the following command in the terminal: 

```bash
nextflow run main.nf -profile local
```

### Slurm profile (computer cluster)

To run the pipeline on a computer cluster you should first check specifics with your local administrator and check out the section on [portability](https://github.com/omiridoue/sgsss-workflow/tree/workflow-scripts). 

`Hint: If your computer cluster has miniforge / conda installed then you can use this download your nextflow environment, you can assign any meaningful name by changing --name nf-env, for example --name nextflow. The following commands will likely differ on your cluster setup so the instructions the following commands are unlikely to work out of the box.`

Run only once to set-up the code environment. 

```bash
module load apps/miniforge

conda create --name nf-env bioconda::nextflow
```

Run only once to download the code from GitHub. Ensure you first navigate to your shared scratch foloder before downloading the material `Hint: cd /mnt/scratch/users/<username>`

```bash
git clone --branch ready-set-workflow --single-branch https://github.com/omiridoue/sgsss-workflow.git
```

Run every time you log onto a new session in your computer cluster:

```bash
module load apps/miniforge
module load apps/apptainer

conda activate nf-env
```

We will swap our local profile to slurm, by specifying `-profile slurm` instead. As we are working with Slurm we can submit a batch job with the following command normally you would run this command from the `login` node.

```bash
sbatch -A none -J "demo" --time=10:00:00 --wrap 'nextflow run /mnt/scratch/users/<username>/sgsss-workflow/main.nf  -profile slurm'
```

For the command to work, replace `<username>` with your username, and generally make sure the file path to the `main.nf` file is correct.

## Citations 

> Graeme R. Grimes, Evan Floden, Paolo Di Tommaso, Phil Ewels and Maxime Garcia Introduction to Workflows with Nextflow and nf-core. https://github.com/carpentries-incubator/workflows-nextflow 2021.

> Ruth M. Ripley, Tom A. B. Snijders, Zsofia Boda, Andras Voros, and Paulina Preciado (2024). Manual for Siena version 4.0. R package version 1.4.13. https://www.cran.r-project.org/web/packages/RSiena/.

> Steglich, C., Snijders, T.A.B., Pearson, M., 2010. Dynamic Networks and Behavior: Separating Selection from Influence. Sociological Methodology 40, 329–393. https://doi.org/10.1111/j.1467-9531.2010.01225.x

>The lesson material was adapted with permission from seqera labs [nextflow-tutorial](https://github.com/seqeralabs/nextflow-tutorial)


