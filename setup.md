---
layout: page
title: Setup
root: .
---

::::::::::::::::::::::::::::::::::::::: objectives

- Understand how to reproduce code.
- Understand the benefits of containers.
- Clone a repository on GitHub.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- When should I use a pre-built container?
- How do I set up code from a GitHub repository?
- How can I navigate folders in a directory?

::::::::::::::::::::::::::::::::::::::::::::::::::

## Introduction
Join this half day training to explore resources to support best practice in making your research Findable, Accessible, Interoperable and Reproducible (FAIR). This software carpentry course offers guided and hands-on learning of the building blocks to design your own scalable and reproducible scientific workflow using Nextflow.

### Recommended Preparation 

Participants will be expected to bring their own devices to be able to follow hands-on training. All participants are required to set up an account with GitHub in advance of the session. Optionally, participants can choose to apply for a GitHub Education account, provided they have used their institutional email at the time of registering.

:::::::::::::: callout

 As an optional alternative I would also recommend creating a GitHub account, [Register an Account](https://docs.github.com/en/get-started/start-your-journey/creating-an-account-on-github). You can then upgrade your Account to a GitHub Education Account for free (you will need to use your academic email to do this) [GitHub Education](https://github.com/education/students). This is a platform where you'll find plenty of open source material from projects including code and open access data. You can then use your GitHub account to login on to GitHub Codespaces, the free resource access online for 120 hours each month. This is an ideal option if you would prefer to skip any of the set-up instructions to download the software to your own computer but follow along the practical component nevertheless. 

::::::::::::::::::::::




### Step 1: Open GitHub Codespaces

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/nextflow-io/training?quickstart=1&ref=master)

<p align="center">
  <a href="https://nextflow.io/">
    <picture>
        <source media="(prefers-color-scheme: dark)" width="350" srcset="https://github.com/seqeralabs/logos/blob/master/nextflow/nextflow_logo_color_darkbg.png?raw=true">
        <img alt="Nextflow Logo" width="350" src="https://github.com/seqeralabs/logos/blob/master/nextflow/nextflow_logo_color.png?raw=true">
    </picture>
  </a>
</p>

### Step 2: Clear files

```
rm -rf *
```

### Step 3: Download Material Using Git

```
git clone git@github.com:omiridoue/sgsss-workflow-scripts.git
```

## Setting up Locally

### Where to Type Commands: How to Open a New Shell

The shell is a program that enables us to send commands to the computer and
receive output. It is also referred to as the terminal or command line.

Some computers include a default Unix Shell program. The steps below describe
some methods for identifying and opening a Unix Shell program if you already
have one installed. There are also options for identifying and downloading a
Unix Shell program, a Linux/UNIX emulator, or a program to access a Unix Shell
on a server.

### Git for Version Control

::: group-tab

### Windows

Computers with Windows operating systems do not automatically have a Unix Shell program installed. In this lesson, we encourage you to use an emulator included in Git for Windows, which gives you access to both Bash shell commands and Git.
If you have attended a Software Carpentry workshop session, it is likely you have already received instructions on how to install Git for Windows.

Once installed, you can open a terminal by running the program Git Bash from
the Windows start menu.

#### Shell Programs for Windows

* [Git for Windows][git4win] -- *Recommended*
* [Windows Subsystem for Linux][ms-wsl] -- recommended option for Windows 10 

#### Alternatives to Git for Windows

> Other solutions are available for running Bash commands on Windows. There is
> now a Bash shell command-line tool available for Windows 10. Additionally,
> you can run Bash commands on a remote computer or server that already has a
> Unix Shell, from your Windows machine. This can usually be done through a
> Secure Shell (SSH) client. One such client available for free for Windows
> computers is [PuTTY][putty]. See the reference below for information on
> installing and using PuTTY, using the Windows 10 command-line tool, or
> installing and using a Unix/Linux emulator.

> For advanced users, you may choose one of the following alternatives:

> * Install the [Windows Subsystem for Linux][ms-wsl]
> * Use the Windows [PowerShell][ms-shell]
> * Read up on [Using a Unix/Linux emulator][unix-emulator] 
>(Cygwin) or Secure
> Shell (SSH) client (PuTTY)

#### Warning
> > Commands in the Windows Subsystem for Linux (WSL), PowerShell, or Cygwin may differ slightly from those shown in the lesson or presented in the workshop. Please ask if you encounter such a mismatch -- you're probably not alone.

### Mac

On macOS, the default Unix Shell is accessible by running the Terminal program
from the `/Application/Utilities` folder in Finder.

To open Terminal, try one or both of the following:

* In Finder, select the Go menu, then select Utilities. Locate Terminal in the
  Utilities folder and open it.
* Use the Mac ‘Spotlight’ computer search function. Search for: `Terminal` and
  press <kbd>Return</kbd>.

For an introduction, see [How to Use Terminal on a Mac][mac-terminal].

### Linux

On most versions of Linux, the default Unix Shell is accessible by running the
[(Gnome) Terminal](https://help.gnome.org/users/gnome-terminal/stable/) or
[(KDE) Konsole](https://konsole.kde.org/) or
[xterm](https://en.wikipedia.org/wiki/Xterm), which can be found via the
applications menu or the search bar.

:::

## SSH for Secure Connections

All students should have an SSH client installed. SSH is a tool that allows us
to connect to and use a remote computer as our own.

::: group-tab

### Windows

Git for Windows comes with SSH preinstalled: you do not have to do anything.

> #### GUI Support for Windows
>
> If you know that the software you will be running on the cluster requires a
> graphical user interface (a GUI window needs to open for the application to
> run properly), please install [MobaXterm](https://mobaxterm.mobatek.net) Home
> Edition.

### macOS

macOS comes with SSH pre-installed: you do not have to do anything.

> #### GUI Support for macOS
>
> If you know that the software you will be running requires a graphical user
> interface, please install [XQuartz](https://www.xquartz.org).

### Linux

Linux comes with SSH and X window support preinstalled: you do not have to do
anything.

:::

::: callout

- [git4win]: https://gitforwindows.org/
- [mac-terminal]: https://www.macworld.co.uk/feature/mac-software/how-use-terminal-on-mac-3608274/
- [ms-wsl]: https://docs.microsoft.com/en-us/windows/wsl/install-win10
- [ms-shell]: https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/ssh-remoting-in-powershell-core?view=powershell-7
- [mobax-gen]: https://mobaxterm.mobatek.net/documentation.html
- [putty]: https://www.chiark.greenend.org.uk/~sgtatham/putty/
- [unix-emulator]: https://www.cygwin.com/
- [wsl]: https://docs.microsoft.com/en-us/windows/wsl/install-win10

:::