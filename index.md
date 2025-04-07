---
permalink: index.html
site: sandpaper::sandpaper_site
---

[Nextflow](https://www.nextflow.io/) is workflow management software which
enables the writing of scalable and reproducible scientific workflows. It
can integrate various software package and environment management systems
such as Docker, Singularity, and Conda. It allows for existing pipelines
written in common scripting languages, such as R and Python, to
be seamlessly coupled together. It implements a Domain Specific Language
(DSL) that simplifies the implementation and running of workflows on
cloud or high-performance computing (HPC) infrastructure

This lesson also introduces [nf-core](https://nf-co.re/): a
community-driven platform, which provide peer reviewed
best practice analysis pipelines written in Nextflow.

This lesson motivates the use of Nextflow ad nf-core as development tools
for building and sharing reproducible data science workflow

## lesson objectives

1. The learner will understand the fundamental components of Nextflow
  script, including channels, processes and operators.
2. The learner will write a multi-step workflow script to align, quantify, and perform QC on an RNA-Seq data in Nextflow DSL2.
3. The learner will be able to write a Nextflow configuration file to alter the computational resources allocated to a process.
4. The learner will use nf-core to run a community curated pipeline.

::::::::::::::::::::::::::::::::::::::::::  prereq

## Prerequisites

This is an intermediate lesson and assumes familiarity with the core materials covered in the
[Software Carpentry Lessons](https://software-carpentry.org/lessons/). In particular learners need to be familiar with
material covered in [The Unix Shell](https://swcarpentry.github.io/shell-novice).
It is helpful to be familiar with using another programming language, to the level of
[Plotting and Programming in Python](https://swcarpentry.github.io/python-novice-gapminder) or
[R for Reproducible Scientific Analysis](https://swcarpentry.github.io/r-novice-gapminder),
although this lesson does not specifically rely on Python or R.
No previous knowledge of Nextflow, other workflow software, or Groovy required


::::::::::::::::::::::::::::::::::::::::::::::::::


# GitHub Codespaces

GitHub Codespaces is a cloud development environment for teams to develop software efficiently and securely.
We use it as a training environment because it allows us to provide learners with a consistent and thoroughly tested environment.

## Creating a GitHub account

You can create a free GitHub account from the [GitHub home page](https://github.com/).

## Running GitHub Codespaces

Once you are logged in to GitHub, open this link in your browser to open the training environment: <https://codespaces.new/nextflow-io/training?quickstart=1&ref=master>

Alternatively, you can click on the button shown below from the many pages in the training portal where it is displayed.

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/nextflow-io/training?quickstart=1&ref=master)

You should be presented with a page where you can create a new GitHub Codespace:

![Create a GitHub Codespace](img/codespaces_create.png)

You can click "Change options" to configure the machine used.
Using a machine with more cores allows you to take greater advantage of Nextflow's ability to parallelize workflow execution.

**For our Hello Nextflow, Nextflow For Science, and nf-core training courses, we recommend using a 4-core machine.**

The free GitHub plan includes 120 core-hours of Codespaces compute per month, which amounts to 30 hours of a 4-core machine.
(See below for more information about quotas.)

!!! warning

    Opening a new GitHub Codespaces environment for the first time can take several minutes.
    Just enough time to brew a cup of tea and check your emails, or go over the intro materials if you're in a group training.

## Explore your GitHub Codespaces IDE

After GitHub Codespaces has loaded, you should see something similar to the following (which may open in light mode depending on your account preferences):

![GitHub Codespaces welcome](img/codespaces_welcome.png)

This is the interface of the VSCode IDE, a popular code development application that we recommend using for Nextflow development.

- **The sidebar** allows you to customize your GitHub Codespace environment and perform basic tasks (copy, paste, open files, search, git, etc.). You can click the explorer button to see which files are in this repository.
- **The terminal** allows you to run all the programs in the repository. For example, both `nextflow` and `docker` are installed and can be executed.
- **The file explorer** allows you to view and edit files. Clicking on a file in the explorer will open it within the main window.
- **The main editor** showing you a preview of the `README.md` file. When you open code or data files, they will open there.

## Reopening a GitHub Codespaces session

Once you have created an environment, you can easily resume or restart it and continue from where you left off.
Your environment will time out after 30 minutes of inactivity and will save your changes for up to 2 weeks.

You can reopen an environment from <https://github.com/codespaces/>.
Previous environments will be listed.
Click a session to resume it.

![List GitHub Codespace sessions](img/codespaces_list.png)

If you have saved the URL for your previous GitHub Codespaces environment, you can simply open it in your browser.
Alternatively, click the same button that you used to create it in the first place:

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/nextflow-io/training?quickstart=1&ref=master)

You should see the previous session, the default option is to resume it:

![Resume a GitHub Codespace](img/codespaces_resume.png)

## Saving files from GitHub Codespaces to your local machine

To save any file from the explorer panel, right-click the file and select `Download`.

## GitHub Codespaces quotas

GitHub Codespaces gives you up to 15 GB-month storage per month, and 120 core-hours per month.
This is equivalent to around 60 hours of the default environment runtime using the standard workspace (up to 2 cores, 8 GB RAM, and 32 GB storage).

GitHub Codespaces environments are configurable.
You can create them with more resources, but this will consume your free usage faster and you will have fewer hours of access to this space.
Optionally, you can purchase access to more resources.

More information can be found in the GitHub docs:
[About billing for GitHub Codespaces](https://docs.github.com/en/billing/managing-billing-for-your-products/managing-billing-for-github-codespaces/about-billing-for-github-codespaces)

