# Auxiliary Tools

| Teaching  | 15 | Exercises  | 10 | 
| --------------- | -------------- | -------------- |-------------- |

### Browsing Docker Hub

- The container image is updated regularly, the latest version should be available alongside previous versions.
- The container image associated with a well established company, community, or other group that is well-known.
- There is a Dockerfile or other listing of what has been installed to the container image.
- The container image page has documentation on how to use the container image.

If a container image is never updated, created by a random person, and does not have a lot of metadata, it is probably worth skipping over. Even if such a container image is secure, it is not reproducible and not a dependable way to run research computations.


### Docker Recipe File

Much like a cookbook, you can pull out recipes and alter to own taste. This is how you normally get started building your own image, you can start with a base repository, and layer requirements.

``` docker

FROM bioconductor/bioconductor_docker:devel-R-4.4.1

RUN R -e "install.packages(c('Matrix', 'lattice', 'parallel', 'MASS', 'methods', 'xtable', 'network', 'vioplot', 'sna', 'codetools', 'dplyr', 'metafor', 'argparse', 'stringr', 'mixmeta'), repos = c(CRAN = 'https://cloud.r-project.org'))"

COPY rsiena_1.4.19.tar.gz .

RUN R -e "install.packages('rsiena_1.4.19.tar.gz', repos = NULL, type = 'source')"

```

### Workflow

``` nextflow.config

docker.enabled = true

```


Many container platforms are available, but Apptainer is designed for ease-of-use on shared systems and in high performance computing (HPC) environments. Nextflow can build an immutable image based off a Docker recipe file.


### Building an Apptainer Image

``` bash
singularity pull docker://omiridoue-siena_r:0.8

```

### Workflow Definition

Within our workflow, we can declare a process container, and ensure we enable apptainer. 


We can declare a different config file for different compute environments, or profiles. These profiles are stored under the conf sub-folder. 


``` nextflow.config
process.container = 'apptainer/omiridoue-siena_r-0.8.img'

apptainer.cacheDir = "apptainer"
apptainer.enabled = true

apptainer.autoMounts = true

```


### Declare 

```
profiles {
  awsbatch {
    includeConfig 'conf/awsbatch.config'
  }
  local {
    includeConfig 'conf/local.config'
    process.container = 'omiridoue/siena_r:0.8'
  }
  sge {
    includeConfig 'conf/sge.config'
  }
  slurm {
    includeConfig 'conf/slurm.config'
    process.executor = 'slurm'
    process.container = 'omiridoue/siena_r:0.8'
  }
  ci {
    includeConfig 'conf/ci.config'
  }
}
```