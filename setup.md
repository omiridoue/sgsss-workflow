---
layout: page
title: Setup
root: .
---


:::::::::::::::::::::::::::::::::::::::  challenge

To follow along the practical component it is recommended use GitHub Codespaces. This will require a stable internet connection. If you are not signed in to GitHub, you may be prompted to do so, once you open the material in GitHub Codespaces.

:::::::::::::::  solution

## Step 1: Set up Coding Environment

::: group-tab

### GitHub Codespaces

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/nextflow-io/training?quickstart=1&ref=master)

### Local Computer

To set up locally you will need to follow the installation steps on [Nextflow Install page](https://www.nextflow.io/docs/stable/install.html). 

### Local Container

Alternatively, you can set up locally using VS Code
[Devcontainer Nextflow](https://training.nextflow.io/latest/envsetup/03_devcontainer/#benefits-of-using-devcontainers).

:::

## Step 2: Clear Template Content

``` bash
mkdir templates

mv * templates/
```

## Step 3: Download Material for Workshop

``` bash
git clone --branch workflow-scripts --single-branch https://github.com/omiridoue/sgsss-workflow.git

cd sgsss-workflow
```
:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::  challenge

## GitHub Codespaces

GitHub Codespaces is a cloud development environment for teams to develop software efficiently and securely. We use it as a training environment because it allows us to work in a consistent and thoroughly tested environment. It requires connection to Internet and can be accessed through your web browser.

:::::::::::::::  solution

##### Creating a GitHub account

You can create a free GitHub account from the [GitHub home page](https://github.com/). You can upgrade your GitHub account to an Education account from the [GitHub Education home page](https://github.com/education) using your affiliate/student email. 

##### Running GitHub Codespaces

You can click on the button shown below from the many pages in the training portal where it is displayed.
[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/nextflow-io/training?quickstart=1&ref=master)

Once you are logged in to GitHub, you can open this link in your browser to open the training environment: <https://codespaces.new/nextflow-io/training?quickstart=1&ref=master>.

You should be presented with a page where you can create a new GitHub Codespace. You can click "Change options" to configure the machine used.

Using a machine with more cores allows you to take greater advantage of Nextflow's ability to parallelize workflow execution.

**For the hands-on component, we recommend using a 4-core machine.**

The free GitHub plan includes 120 core-hours of Codespaces compute per month, which amounts to 30 hours of a 4-core machine. Opening a new GitHub Codespaces environment for the first time can take several minutes. 

##### Explore GitHub Codespaces

After GitHub Codespaces has loaded, you should see the welcome page:

![GitHub Codespaces welcome](episodes/fig/codespaces_welcome.png)

This is the interface of the VSCode IDE, a popular code development application that we recommend using for Nextflow development.

- **The sidebar** allows you to customize your GitHub Codespace environment and perform basic tasks (copy, paste, open files, search, git, etc.). You can click the explorer button to see which files are in this repository.
- **The terminal** allows you to run all the programs in the repository. For example, both `nextflow` and `docker` are installed and can be executed.
- **The file explorer** allows you to view and edit files. Clicking on a file in the explorer will open it within the main window.
- **The main editor** showing you a preview of the `README.md` file. When you open code or data files, they will open there.

##### Reopening a GitHub Codespaces session

Once you have created an environment, you can easily resume or restart it and continue from where you left off.
Your environment will time out after 30 minutes of inactivity and will save your changes for up to 2 weeks.

You can reopen an environment from <https://github.com/codespaces/>.

Previous environments will be listed. You can manage these sessions by freezing or removing previous sessions. For the moment you can click a session to resume it, just be mindful of your usage. If you have saved the URL for your previous GitHub Codespaces environment, you can simply open it in your browser.

Alternatively, click the same button that you used to create it in the first place:

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/nextflow-io/training?quickstart=1&ref=master)

You should see the previous session, the default option is to resume it:

![Resume a GitHub Codespace](episodes/fig/codespaces_resume.png)

##### Saving files from GitHub Codespaces to your local machine

To save any file from the explorer panel, right-click the file and select `Download`.

##### GitHub Codespaces quotas

GitHub Codespaces gives you up to 15 GB-month storage per month, and 120 core-hours per month. This is equivalent to around 60 hours of the default environment runtime using the standard workspace (up to 2 cores, 8 GB RAM, and 32 GB storage).

GitHub Codespaces environments are configurable. You can create them with more resources, but this will consume your free usage faster and you will have fewer hours of access to this space. 

More information can be found in the GitHub docs:
[About billing for GitHub Codespaces](https://docs.github.com/en/billing/managing-billing-for-your-products/managing-billing-for-github-codespaces/about-billing-for-github-codespaces)


:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::
