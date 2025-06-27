![SGSSS Logo](fig/SGSSS_Stacked.png)

# Building your own Computational Pipeline for Social Scientists


<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/"><img alt="Creative Commons License" src="fig/cc_by-nc-nd.svg" /></a>


## Introduction

Computational social science (CSS), which brings computational approaches to social science questions, has been shown to be a powerful tool.

[Nextflow](https://www.nextflow.io/) is workflow management software which
enables the writing of scalable and reproducible scientific workflows. It
can integrate various software package and environment management systems
such as Docker, Singularity, and Conda. It allows for existing pipelines
written in common scripting languages, such as R and Python, to
be seamlessly coupled together. It simplifies the implementation and running of workflows on
cloud or high-performance computing (HPC) infrastructure. 

This training material was based off the training developed and maintained by [Seqera](https://seqera.io) and released under an open-source license ([CC BY-NC-ND](https://creativecommons.org/licenses/by-nc-nd/4.0/)) for the benefit of the community. You are welcome to reuse these materials according to the terms of the license. The training includes material from the [carpentries incubator](https://carpentries-incubator.github.io/workflows-nextflow/) and [The Turing Way](http://doi.org/10.5281/zenodo.3233853). 

Follow the link to Nextflow documentation below:

<p align="center">
  <a href="https://nextflow.io/">
    <picture>
        <source media="(prefers-color-scheme: dark)" width="350" srcset="https://github.com/seqeralabs/logos/blob/master/nextflow/nextflow_logo_color_darkbg.png?raw=true">
        <img alt="Nextflow Logo" width="350" src="https://github.com/seqeralabs/logos/blob/master/nextflow/nextflow_logo_color.png?raw=true">
    </picture>
  </a>
</p>

## Synthetic Data 

The data involves low fidelity synthetic data. This means that the data is generated using functions, and only resembles real-world data in a very basic way. This type of synthetic can be useful for teaching and learning, or helping develop code. Generative AI was used to construct the data generating functions for this synthetic data. Please ensure any further use of this data includes this section. The code used to generate data can be shared upon request, drop a line to [(PGR) Eleni Omiridou](mailto:2333157o@student.gla.ac.uk).

The example application is from my research project working with school based secondary data on adolescent health behaviours. It is common for health and education researchers to work with multi-level data involving individual questionnaire data (level 1), nested in schools (level 2) and time (level 3).

### Step 1: Open GitHub Codespaces

The course material for the half day course can be found in the [sgsss-workflow](https://github.com/omiridoue/sgsss-workflow) repository, the material lives in a webpage that hosts the [course training](https://omiridoue.github.io/sgsss-workflow/). Material was prepared by [(Student) Eleni Omiridou](https://www.gla.ac.uk/pgrs/eleniomiridou/), University of Glasgow. The course was first run in July 2025.

This lesson is a template lesson that uses [The Carpentries Workbench][workbench].

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/nextflow-io/training?quickstart=1&ref=master)

### Step 2: Organise Template Files

```
mkdir templates
mv * templates/
```

### Step 3: Read in Material Using Git

```
git clone --branch workflow-scripts --single-branch https://github.com/omiridoue/sgsss-workflow.git

```

### Step 4: Navigate to the new Folder

```
cd sgsss-workflow

```

### Materials

The training materials can be found in the following folders:
* [code](episodes/files/scripts) - Jupyter Notebooks and syntax files containing executable Python and R code.
* [installation](https://omiridoue.github.io/sgsss-workflow/) - Guidance on installing software on your own machines.
