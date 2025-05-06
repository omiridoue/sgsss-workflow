---
permalink: index.html
site: sandpaper::sandpaper_site
---

## Introduction

Computational social science (CSS) brings computational approaches to social science questions. [Nextflow](https://www.nextflow.io/) is a workflow management software which enables the writing of scalable and reproducible scientific workflows. With this half day workshop we will motivate the use of this powerful tool in operationalising reproducible research.

We will just about scratch the surface of CSS, please see below a bucket list of skills. With the workshop we'll work on the following select skills. You may find it helpful to reflect on what areas you would like to pursue developing.

:::::::::::::::::: checklist

## 🗺️ Skills Roadmap

__Core Competencies__

- [x] Ability to design and execute research projects from data to report
- [ ] Domain expertise
- [ ] Programming fluency in R and/or Python
- [ ] Experience with data management
- [ ] Effective communication and collaborative with both technical and nontechnical colleagues 
- [ ] Practiced knowledge of quantitative social science paradigms
- [ ] Engagement with ethical concerns (e.g., privacy protection and algorithmic bias)
- [ ] Publicly available research projects documented from end to end 
- [x] Reproducible, efficient, and communicable code via GitHub

__Additional Skills__

- [ ] Ability to apply theory and methods to practical aims of a product and/or organization (non-academic)
- [ ] Proficiency with relational database languages (e.g., SQL) and cloud-based databases (non-academic especially)
- [ ] Sharing learnings through research notes (non-academic) and tutorials (academic)
- [x] Connecting with Computational Social Scientists
- [ ] Work with computational social scientists through work with civic, social, and nonprofit organizations (non-academic)
- [ ] Connect with computational social scientists via online platforms (e.g., LinkedIn and Slack) (non-academic)
- [ ] Attend and know how to navigate cross-disciplinary conferences

::::::::::::::::::::::::::::

This lesson motivates the use of Nextflow ad nf-core as development tools for building and sharing reproducible data science workflow. It can integrate various software package and environment management systems such as Docker, Singularity, and Conda. It allows for existing pipelines written in common scripting languages, such as R and Python, to be seamlessly coupled together. It simplifies the implementation and running of workflows on cloud or high-performance computing (HPC) infrastructure.

## Workshop objectives

1. Understand the role of auxiliary tools (Docker/Git) in supporting best practice within  the Open Research framework.
2. Design and adapt a research project directory to own research objectives.
3. Understand the fundamental components of a workflow implemented in Nextflow, including channels, processes and operators.
4. Learn-by-doing launch a computational workflow using remote workspace, GitPod.
5. Curate own configurations and settings on a practice workflow to ensure portability, scalability, automatic resource management and re-entrancy. 
6. Discuss ways to implement own research directory.
7. Explore links to the wider network for computational researchers across Scotland.


::::::::::::::::::::::::::::::::::::::::::  prereq

## Prerequisites

This is an introductory lesson to computational workflows. Basic familiarity with the core materials covered in the
[Software Carpentry Lessons](https://software-carpentry.org/lessons/). In particular learners need to be familiar with
material covered in [The Unix Shell](https://swcarpentry.github.io/shell-novice).
It is helpful to be familiar with using another programming language, to the level of [Plotting and Programming in Python](https://swcarpentry.github.io/python-novice-gapminder) or
[R for Reproducible Scientific Analysis](https://swcarpentry.github.io/r-novice-gapminder), although this lesson does not specifically rely on Python or R.

No previous knowledge of Nextflow, other workflow software, or Groovy required.


::::::::::::::::::::::::::::::::::::::::::::::::::

# GitHub Codespaces

GitHub Codespaces is a cloud development environment for teams to develop software efficiently and securely.
We use it as a training environment because it allows us to provide learners with a consistent and thoroughly tested environment.

## Creating a GitHub account

You can create a free GitHub account from the [GitHub home page](https://github.com/). You can upgrade your GitHub account to an Education account from the [GitHub Education home page](https://github.com/education) using your affiliate/student email. 

## Running GitHub Codespaces

Once you are logged in to GitHub, open this link in your browser to open the training environment: <https://codespaces.new/nextflow-io/training?quickstart=1&ref=master>

Alternatively, you can click on the button shown below from the many pages in the training portal where it is displayed.

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/nextflow-io/training?quickstart=1&ref=master)

You should be presented with a page where you can create a new GitHub Codespace:

You can click "Change options" to configure the machine used.
Using a machine with more cores allows you to take greater advantage of Nextflow's ability to parallelize workflow execution.

**For the hands-on component, we recommend using a 4-core machine.**

The free GitHub plan includes 120 core-hours of Codespaces compute per month, which amounts to 30 hours of a 4-core machine (See below for more information about quotas.)

Opening a new GitHub Codespaces environment for the first time can take several minutes. Just enough time to touch on the rest of this 

## Explore GitHub Codespaces

After GitHub Codespaces has loaded, you should see something similar to the following (which may open in light mode depending on your account preferences):

![GitHub Codespaces welcome](episodes/fig/codespaces_welcome.png)

This is the interface of the VSCode IDE, a popular code development application that we recommend using for Nextflow development.

- **The sidebar** allows you to customize your GitHub Codespace environment and perform basic tasks (copy, paste, open files, search, git, etc.). You can click the explorer button to see which files are in this repository.
- **The terminal** allows you to run all the programs in the repository. For example, both `nextflow` and `docker` are installed and can be executed.
- **The file explorer** allows you to view and edit files. Clicking on a file in the explorer will open it within the main window.
- **The main editor** showing you a preview of the `README.md` file. When you open code or data files, they will open there.

## Reopening a GitHub Codespaces session

Once you have created an environment, you can easily resume or restart it and continue from where you left off.
Your environment will time out after 30 minutes of inactivity and will save your changes for up to 2 weeks.

You can reopen an environment from <https://github.com/codespaces/>.

Previous environments will be listed. You can manage these sessions by freezing or removing previous sessions. For the moment you can click a session to resume it, just be mindful of your usage.

![List GitHub Codespace sessions](episodes/fig/codespaces_list.png)

If you have saved the URL for your previous GitHub Codespaces environment, you can simply open it in your browser.
Alternatively, click the same button that you used to create it in the first place:

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/nextflow-io/training?quickstart=1&ref=master)

You should see the previous session, the default option is to resume it:

![Resume a GitHub Codespace](episodes/fig/codespaces_resume.png)

## Saving files from GitHub Codespaces to your local machine

To save any file from the explorer panel, right-click the file and select `Download`.

## GitHub Codespaces quotas

GitHub Codespaces gives you up to 15 GB-month storage per month, and 120 core-hours per month. This is equivalent to around 60 hours of the default environment runtime using the standard workspace (up to 2 cores, 8 GB RAM, and 32 GB storage).

GitHub Codespaces environments are configurable. You can create them with more resources, but this will consume your free usage faster and you will have fewer hours of access to this space. Optionally, you can purchase access to more resources.

More information can be found in the GitHub docs:
[About billing for GitHub Codespaces](https://docs.github.com/en/billing/managing-billing-for-your-products/managing-billing-for-github-codespaces/about-billing-for-github-codespaces)
