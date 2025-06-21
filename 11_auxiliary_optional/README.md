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

For the following image we use a base image from bioconductor, R 4.4.1 and install relevant packages. We also install the RSiena package 1.4.19 from source code. The docker container is then stored onto the online docker hub. 

``` docker

FROM bioconductor/bioconductor_docker:devel-R-4.4.1

RUN R -e "install.packages(c('Matrix', 'lattice', 'parallel', 'MASS', 'methods', 'xtable', 'network', 'vioplot', 'sna', 'codetools', 'dplyr', 'metafor', 'argparse', 'stringr', 'mixmeta'), repos = c(CRAN = 'https://cloud.r-project.org'))"

COPY rsiena_1.4.19.tar.gz .

RUN R -e "install.packages('rsiena_1.4.19.tar.gz', repos = NULL, type = 'source')"

```

### Using Docker with Local Profile

In the nextflow.config file you will need to toggle docker.enabled to true, within the scope of our local profile.

``` nextflow.config

profiles {
  local {
    includeConfig 'conf/local.config'
    docker.enabled = true
    process.container = 'omiridoue/siena_r:0.8'
  }
  slurm {
    includeConfig 'conf/slurm.config'
    apptainer.enabled = true
    apptainer.cacheDir = "apptainer"
    apptainer.enabled = true
    apptainer.autoMounts = true

    process.executor = 'slurm'
    process.container = 'apptainer/omiridoue-siena_r-0.8.img'
  }
}

```

Many container platforms are available, but Apptainer is designed for ease-of-use on shared systems and in high performance computing (HPC) environments. Nextflow can build an immutable image based off a Docker recipe file.

### Building an Apptainer Image

Once we have a docker image it is straightforward to convert this to an apptainer (former singularity) container with the following command:

``` bash
singularity pull docker://omiridoue-siena_r:0.8

```

### Using Apptainer for HPC Profile

Within our workflow, we can declare a process container, and ensure we enable apptainer. 


We can declare a different config file for different compute environments, or profiles. These profiles are stored under the conf sub-folder. 

