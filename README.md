![SGSSS Logo](episodes/fig/SGSSS_Stacked.png)

# Building your own Computational Pipeline for Social Scientists


<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/"><img alt="Creative Commons License" src="episodes/fig/cc_by-nc-nd.svg" /></a>


## Introduction

Computational social science (CSS), which brings computational approaches to social science questions, has been shown to be a powerful tool.

[Nextflow](https://www.nextflow.io/) is workflow management software which
enables the writing of scalable and reproducible scientific workflows. It
can integrate various software package and environment management systems
such as Docker, Singularity, and Conda. It allows for existing pipelines
written in common scripting languages, such as R and Python, to
be seamlessly coupled together. It simplifies the implementation and running of workflows on
cloud or high-performance computing (HPC) infrastructure

This training material was based off the training developed and maintained by [Seqera](https://seqera.io) and released under an open-source license ([CC BY-NC-ND](https://creativecommons.org/licenses/by-nc-nd/4.0/)) for the benefit of the community. You are welcome to reuse these materials according to the terms of the license. The training includes material from the [carpentries incubator](https://carpentries-incubator.github.io/workflows-nextflow/) and [The Turing Way](http://doi.org/10.5281/zenodo.3233853). The course material page was designed based off the [workbench](https://carpentries.github.io/sandpaper-docs/).

## Data 

Low fidelity means that the data only resembles real-world data in a very basic way. This type of dataset can be useful for teaching students, or helping programmers to plan code for things like health applications.

## Course materials

The course material for the half day course can be found in the [sgsss-workflow](https://github.com/omiridoue/sgsss-workflow) repository, the material lives in a webpage that hosts the [course training](https://omiridoue.github.io/sgsss-workflow/). Material was prepared by [PGR Eleni Omiridou](https://www.gla.ac.uk/pgrs/eleniomiridou/), University of Glasgow. The course was first run in July 2025.

This lesson is a template lesson that uses [The Carpentries Workbench][workbench].

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/nextflow-io/training?quickstart=1&ref=master)

<p align="center">
  <a href="https://nextflow.io/">
    <picture>
        <source media="(prefers-color-scheme: dark)" width="350" srcset="https://github.com/seqeralabs/logos/blob/master/nextflow/nextflow_logo_color_darkbg.png?raw=true">
        <img alt="Nextflow Logo" width="350" src="https://github.com/seqeralabs/logos/blob/master/nextflow/nextflow_logo_color.png?raw=true">
    </picture>
  </a>
</p>


### Programme

The course programme can be viewed here:
* 

### Materials

The training materials can be found in the following folders:
* [code](episodes/files/scripts) - Jupyter Notebooks and syntax files containing executable Python and R code.
* [installation](https://omiridoue.github.io/sgsss-workflow/) - Guidance on installing software on your own machines.

## Acknowledgements

I am grateful to the Scottish Graduate School of Social Sciences (SGSSS) for funding and organising this course.

## Further information

Please do not hesitate to get in contact if you have queries, criticisms or ideas regarding these materials: [PGR Eleni Omiridou](mailto:2333157o@student.gla.ac.uk)

> Copyright 2025, omiridoue. All examples and descriptions are licensed under the <a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/">Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License</a>.

## Citations 

> The Turing Way Community. (2022). The Turing Way: A handbook for reproducible, ethical and collaborative research (1.0.2). Zenodo. DOI 10.5281/zenodo.3233853.

> The Turing Way Community, & Scriberia. (2020, March 3). Illustrations from the Turing Way book dashes. Zenodo. http://doi.org/10.5281/zenodo.3332807.

> Graeme R. Grimes, Evan Floden, Paolo Di Tommaso, Phil Ewels and Maxime Garcia Introduction to Workflows with Nextflow and nf-core. https://github.com/carpentries-incubator/workflows-nextflow 2021.

>The lesson material was adapted with permission from from seqera labs [nextflow-tutorial](https://github.com/seqeralabs/nextflow-tutorial)