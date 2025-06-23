![SGSSS Logo](episodes/fig/SGSSS_Stacked.png)

# Building your own Computational Pipeline for Social Scientists


<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/"><img alt="Creative Commons License" src="episodes/fig/cc_by-nc-nd.svg" /></a>


## Introduction

Computational social science (CSS) brings computational approaches to social science questions.

This student-led training explores a practical introduction to building computational workflows with [Nextflow](https://www.nextflow.io/).

[Nextflow](https://www.nextflow.io/) is a workflow management software which
enables the writing of scalable and reproducible scientific workflows. It
can integrate various software package and environment management systems
such as Docker, Singularity, and Conda. It allows for existing pipelines
written in common scripting languages, such as R and Python, to
be seamlessly coupled together. It simplifies the implementation and running of workflows on
cloud or high-performance computing (HPC) infrastructure.

The guided practical component of the training is implemented in the code spaces environment developed and maintained by [Seqera](https://seqera.io) and released under an open-source license ([CC BY-NC-ND](https://creativecommons.org/licenses/by-nc-nd/4.0/)) for the benefit of the community. You are welcome to reuse any of these materials according to the terms of the license. 

The training is based off [carpentries incubator](https://carpentries-incubator.github.io/workflows-nextflow/) and [The Turing Way](http://doi.org/10.5281/zenodo.3233853). The course material page was designed using the [workbench](https://carpentries.github.io/sandpaper-docs/).

## 🗺️ Objectives

- [x] Understand the role of auxiliary tools in supporting best practice within the Open Research framework.
- [x] Design/adapt a research project directory to own research.
- [x] Understand the fundamental components of a workflow implemented in Nextflow, including channels, processes and operators.
- [x] Launch a computational workflow using remote workspace, GitHub Codespaces.
- [x] Curate own configurations and settings on a practice workflow to ensure portability, scalability, automatic resource management and re-entrancy. 
- [x] Discuss ways to implement own research directory.
- [x] Explore links to the wider network for computational researchers across Scotland.

## 🗺️ Skills

- [x] Ability to design and execute research projects from data to report
- [x] Navigate reproducible, efficient, and communicable code via GitHub
- [x] Connecting with researchers in your field

## Synthetic Data 

The data involves low fidelity synthetic data. This means that the data is generated using functions, and only resembles real-world data in a very basic way. This type of synthetic can be useful for teaching and learning, or helping develop code. Generative AI was used to construct the data generating functions for this synthetic data. Please ensure any further use of this data includes this section. The code used to generate data can be shared upon request, drop a line to [(PGR) Eleni Omiridou](mailto:2333157o@student.gla.ac.uk).

## Course materials

The course material for the half day course can be found in the [sgsss-workflow](https://github.com/omiridoue/sgsss-workflow) repository. The teaching and learning material lives in the following page: [course training](https://omiridoue.github.io/sgsss-workflow/). Material was prepared by [(PGR) Eleni Omiridou](https://www.gla.ac.uk/pgrs/eleniomiridou/), University of Glasgow. The course was first run in July 2025.
 
### Materials

This workshop makes use of an online teaching and learning space. This online environment involves using the GitHub Codespaces training environment:

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/nextflow-io/training?quickstart=1&ref=master)

The material and supporting resources can be found in the following folders:
* [set-up](https://omiridoue.github.io/sgsss-workflow/) - Instructions to set up the material for the workshop.
* [code](https://github.com/omiridoue/sgsss-workflow/tree/workflow-scripts) - Files for the guided practical material on building a workflow.
* [template](https://github.com/omiridoue/sgsss-workflow/tree/repo-boilerplate) - Template folder to adapt to your own workflow.
* [workflow](https://github.com/omiridoue/sgsss-workflow/tree/ready-set-workflow) - Full demo - ready-set-workflow !

## Acknowledgements

I am grateful to the Scottish Graduate School of Social Sciences (SGSSS) for funding and organising this course.

This lesson is a template lesson that uses [The Carpentries Workbench](https://carpentries.org/). Built with [sandpaper (0.16.12)](https://github.com/carpentries/sandpaper/tree/0.16.12), [pegboard (0.7.9)](https://github.com/carpentries/pegboard/tree/0.7.9), and [varnish (1.0.5)](https://github.com/omiridoue/varnish/tree/main).

## Further information

Please do not hesitate to get in contact if you have queries, suggestions or corrections regarding the material: [(PGR) Eleni Omiridou](mailto:2333157o@student.gla.ac.uk)

Any errors, omissions or inaccuracies are my own.

> Copyright 2025, omiridoue. All examples and descriptions are licensed under the <a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/">Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License</a>.

## Citations 

> The Turing Way Community. (2022). The Turing Way: A handbook for reproducible, ethical and collaborative research (1.0.2). Zenodo. DOI 10.5281/zenodo.3233853.

> The Turing Way Community, & Scriberia. (2020, March 3). Illustrations from the Turing Way book dashes. Zenodo. http://doi.org/10.5281/zenodo.3332807.

> Graeme R. Grimes, Evan Floden, Paolo Di Tommaso, Phil Ewels and Maxime Garcia Introduction to Workflows with Nextflow and nf-core. https://github.com/carpentries-incubator/workflows-nextflow 2021.

>The lesson material was adapted with permission from seqera labs [nextflow-tutorial](https://github.com/seqeralabs/nextflow-tutorial)