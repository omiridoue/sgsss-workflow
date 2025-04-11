## Workflow Boilerplate Structure 

```
Workflow repository placeholder folders
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
