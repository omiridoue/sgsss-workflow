# Introduction and Setup

## GitHub Codespaces 


For the practical we will access: 

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/nextflow-io/training?quickstart=1&ref=master)


```
nextflow info
```

Reorganise files in your workspace 

```
mkdir templates
mv * templates/
```

```
git clone --branch workflow-scripts --single-branch https://github.com/omiridoue/sgsss-workflow.git

```

## Local Machine 

```
conda create --name nf-env bioconda::nextflow

```

Activate the conda environment.

```
conda activate nf-env

```

Install graphviz if you would like to render reports and a timeline for the workflow.

```
sudo apt install graphviz

```


You can also download code for the specific branch.

```bash

cd templates

git clone -b repo-boilerplate --single-branch https://github.com/omiridoue/sgsss-workflow.git

```

Output a folder tree for all nested files.

```
tree -a
```

```
Project folder
└── 📁workflow                <- Main workflow directory
  └── 📁apptainer          <- Container definitions for Apptainer (formerly Singularity)
  └── 📁bin                 <- Executable scripts used in the workflow, ex. in R these would be functions 
  └── 📁conf               <- Configuration files for different execution environments
  └── 📁data               <- Input data files for the workflow
  └── 📁docker             <- Docker container definition and dependencies
  └── 📁docs               <- Documentation, reports, and visualizations
  └── 📁modules            <- Nextflow modules for different analysis steps
  └── 📁params             <- Parameter files for the workflow
  └── 📁templates          <- Template scripts used in the workflow
  └── .dockerignore        <- Files to exclude from Docker builds
  └── .gitignore           <- Files to exclude from Git version control
  └── main.nf              <- Main Nextflow workflow definition
  └── nextflow.config      <- Main Nextflow configuration
  └── params.config        <- Parameter configuration
  └── README.md            <- Project documentation
```
