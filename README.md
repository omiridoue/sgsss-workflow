![image](https://github.com/user-attachments/assets/884c5c31-3a4b-47ed-8539-2ddacdc13551)

# Practical Guide: Building your own Computational Pipeline for Social Scientists

<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/"><img alt="Creative Commons License" src="fig/cc_by-nc-nd.svg" /></a>

## Introduction

Computational social science (CSS) brings computational approaches to social science questions, has been shown to be a powerful tool.

The training explores a practical introduction to building computational workflows with _Nextflow_ with the examples focusing on an application within social science. Feel free to follow along some of the practical material, the only prerequisite is that you register for an account with GitHub - no prior software installation is required!

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



## Pre-requisites

- [x]  Bring own device to follow practical component
- [x]  Set up an account with GitHub, follow link to: [GitHub page](https://github.com/)
- [x]  Optionally, upgrade to a GitHub Education account. For more information follow link: [GitHub Education](https://github.com/education)


## Set up - Online Learning Environment

### Step 1: Open GitHub Codespaces

The course material for the half day course can be found in the [sgsss-workflow](https://github.com/omiridoue/sgsss-workflow) repository, the material lives in a webpage that hosts the [course training](https://omiridoue.github.io/sgsss-workflow/). Material was prepared by [(Student) Eleni Omiridou](https://www.gla.ac.uk/pgrs/eleniomiridou/), University of Glasgow. The course was first run in July 2025.


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
cd sgsss-workflow/scripts

```

## Practical Material

The training materials can be found in the following folders:

* [code](episodes/files/scripts) - Jupyter Notebooks and syntax files containing executable Python and R code.
* [installation](https://omiridoue.github.io/sgsss-workflow/) - Guidance on installing software on your own machines.

Further material and supporting resources can be found in the following links:

* [set-up](https://omiridoue.github.io/sgsss-workflow/) - Instructions to set up the material for the workshop.
* [template](https://github.com/omiridoue/sgsss-workflow/tree/repo-boilerplate) - Template folder to adapt to your own workflow.
* [workflow](https://github.com/omiridoue/sgsss-workflow/tree/ready-set-workflow) - Full demo - ready-set-workflow !

### Asynchronous Material

Link to [pre-recorded material](https://youtube.com/playlist?list=PLF2plRzeFIjiV0JvN20TGxYgucR98OXNq&si=c_po1RYGY9eggCkI)

Follow along with the companion practical material:

- [Workflow 00: Setup](https://omiridoue.github.io/sgsss-workflow/)
- [Workflow 01: Intro](https://omiridoue.github.io/sgsss-workflow/00.html)
- [Workflow 02: Hello Nextflow](https://omiridoue.github.io/sgsss-workflow/02.html)
- [Workflow 03: Parameters](https://omiridoue.github.io/sgsss-workflow/03.html)
- [Workflow 04: Channels](https://omiridoue.github.io/sgsss-workflow/04.html)
- [Workflow 05: Modules + Optional Topics](https://omiridoue.github.io/sgsss-workflow/05.html)

## Synthetic Data 

The data involves low fidelity synthetic data. This means that the data is generated using functions, and only resembles real-world data in a very basic way. This type of synthetic can be useful for teaching and learning, or helping develop code. Generative AI was used to construct the data generating functions for this synthetic data. Please ensure any further use of this data includes this section. The code used to generate data can be shared upon request, drop a line to [(PGR) Eleni Omiridou](mailto:2333157o@student.gla.ac.uk).

The example application is from my research project working with school based secondary data on adolescent health behaviours. It is common for health and education researchers to work with multi-level data involving individual questionnaire data (level 1), nested in schools (level 2) and time (level 3).


## AI Disclosure

This document was created with assistance from AI tools. The content has been reviewed and edited by the author. For more information on the extent and nature of AI usage, please contact the author.

## Citations 

> Graeme R. Grimes, Evan Floden, Paolo Di Tommaso, Phil Ewels and Maxime Garcia Introduction to Workflows with Nextflow and nf-core. [https://github.com/carpentries-incubator/workflows-nextflow](https://github.com/carpentries-incubator/workflows-nextflow) 2021.

> Ruth M. Ripley, Tom A. B. Snijders, Zsofia Boda, Andras Voros, and Paulina Preciado (2024). Manual for Siena version 4.0. R package version 1.4.13. [https://www.cran.r-project.org/web/packages/RSiena/](https://www.cran.r-project.org/web/packages/RSiena/).

> The Turing Way Community. (2022). The Turing Way: A handbook for reproducible, ethical and collaborative research (1.0.2). Zenodo. [http://doi.org/10.5281/zenodo.3233853](http://doi.org/10.5281/zenodo.3332807).

> The Turing Way Community, & Scriberia. (2020, March 3). Illustrations from the Turing Way book dashes. Zenodo. [http://doi.org/10.5281/zenodo.3332807](http://doi.org/10.5281/zenodo.3332807).

>The lesson material was adapted with permission from seqera labs [nextflow-tutorial](https://github.com/seqeralabs/nextflow-tutorial)


