# Section 02: Hello Nextflow

| Teaching  | 30 | Exercises  | 10 | 
| --------------- | -------------- | -------------- |-------------- |


- Understand a workflow management system.
- Understand the benefits of using a workflow management system.
- Explain the components of a Nextflow script.
- Run a Nextflow script.


- What is Nextflow?
- Why should I use a workflow management system?
- What are the features of Nextflow?
- What are the main components of a Nextflow script?
- How do I run a Nextflow script?

## Workflows

Analysing data involves a sequence of tasks, including gathering, cleaning, processing data. This sequence of tasks is called a workflow or a pipeline. These workflows typically require using multiple software packages, sometimes running on different computing environments, such as desktop or a compute cluster. However, as workflows become larger and more complex, the management of the programming logic and software becomes difficult. *Workflow Management Systems* have been developed specifically to manage computational data-analysis workflows. 


These systems contain multiple features that simplify the development, monitoring, execution and sharing of pipelines, such as:

- Run time management
- Software management
- Portability \& Interoperability
- Reproducibility
- Re-entrancy

## Workflow management systems

- **Reproducibility**: Nextflow supports several container technologies, such as [Docker](https://www.docker.com/) and [Singularity](https://sylabs.io/singularity), as well as the package manager [Conda](https://docs.conda.io). This, along with the integration of the [GitHub](https://www.github.com) code sharing platform, allows you to write self-contained pipelines, manage versions and to reproduce any previous result when re-run, including on different computing platforms.

- **Portability \& interoperability**: Nextflow's syntax separates the functional logic (the steps of the workflow) from the configuration (how the scripts run). This allows the pipeline to be run on multiple platforms, e.g. local compute vs. a university compute cluster or a cloud service like [AWS](https://aws.amazon.com/), without changing the steps of the workflow.

- **Simple parallelism**:  Nextflow is based on the dataflow programming model which greatly simplifies the splitting of tasks that can be run at the same time (parallelisation).

- **Continuous checkpoints \& re-entrancy**: All the intermediate results produced during the pipeline execution are automatically tracked. This allows you to resume its execution from the last successfully executed step, no matter what the reason was for it stopping.

## Processes, channels, and workflows

Nextflow workflows have three main parts: *processes*, *channels*, and *workflows*.

- *Processes* describe a task to be run. A process script can be written in any scripting language that can be executed by the Linux platform (Bash, Perl, Ruby, Python, R, etc.). Processes spawn a task for each complete input set. Each task is executed independently and cannot interact with other tasks. The only way data can be passed between process tasks is via asynchronous queues, called *channels*.

- Processes define inputs and outputs for a task. *Channels* are then used to manipulate the flow of data from one process to the next.

- The interaction between processes, and ultimately the pipeline execution flow itself, is then explicitly defined in a *workflow* section.

In the following example we have a channel containing three elements, e.g., three data files. We have a process that takes the channel as input. Since the channel has three elements, three independent instances (tasks) of that process are run in parallel. Each task generates an output, which is passed to another channel and used as input for the next process.

## Workflow implementation

While a `process` defines what command or script has to be executed, the `executor` determines how that script is actually run in the target system. If not otherwise specified, processes are executed on the local computer. The local executor is very useful for pipeline development, testing, and small-scale workflows, but for large-scale computational pipelines, a High Performance Cluster (HPC) or Cloud platform is often required.

<p align="center">   <img  src="fig/executor.png" alt="Diagram of a computational process within a bioinformatics workflow. The image features a large, central, rounded rectangle labeled 'process' with a smaller rectangle inside it labeled 'script', indicating the code or commands that are being executed. Above the script box, there is a smaller inset labeled 'Executors' with three icons: a desktop computer labeled 'Local', a stack of servers labeled 'High Performance Compute Cluster', and a cloud symbol labeled 'Cloud Compute'. These represent the different computing environments where the script can be executed. To the left of the process box is a green left-pointing arrowhead, suggesting input into the process, and to the right is a yellow right-pointing arrowhead, indicating the direction of output from the process." width="350">   <br>   <em>Nextflow Executors</em>
</p>

Nextflow provides a separation between the pipeline's functional logic and the underlying execution platform. This makes it possible to write a pipeline once, and then run it on your computer, compute cluster, or the cloud, without modifying the workflow, by defining the target platform in a configuration file. Note multiple configurations can be defined, and the choice is left to the user, a full list can be found [here](https://www.nextflow.io/docs/latest/executor.html).

## Your first script

We are now going to look at a sample Nextflow script that counts the number of lines in a file. 

The nextflow scripts for each lesson episode are available in the `02_hello_nextflow` directory created during the course setup. You should copy the script into the current directory.

```groovy
#!/usr/bin/env nextflow

/*
========================================================================================
    Workflow parameters are written as params.<parameter>
    and can be initialised using the `=` operator.
========================================================================================
*/

params.input = "data/each_period.tar.gz"

/*
========================================================================================
    Input data is received through channels
========================================================================================
*/

input_ch = Channel.fromPath(params.input)

/*
========================================================================================
   Main Workflow
========================================================================================
*/

workflow {
    //  The script to execute is called by it's process name, and input is provided between brackets.

    GENERATE_READS(input_ch)

    /*  Process output is accessed using the `out` channel.
        The channel operator view() is used to print process output to the terminal. */

   GENERATE_READS.out.view()

}

/*
========================================================================================
    A Nextflow process block. Process names are written, by convention, in uppercase.
    This convention is used to enhance workflow readability.
========================================================================================
*/

process GENERATE_READS {

  input:
          path targz
    
  output:
          path "*"
  
  script:
          """
          tar -xzf $targz 
          # Print file name
          printf '${targz}\\t'
          """
}

```

This is a Nextflow script, which contains the following:

1. An optional interpreter directive ("Shebang") line, specifying the location of the Nextflow interpreter.
2. A multi-line Nextflow comment, written using C style block comments, there are more comments later in the file.
3. A pipeline parameter `params.input` which is given a default value, of the relative path to the location of a compressed archive of data, as a string.
4. A Nextflow channel `input_ch` used to read in data to the workflow.
5. An unnamed `workflow` execution block, which is the default workflow to run.
6. A call to the process `GENERATE_READS`.
7. An operation on the process output, using the channel operator `.view()`.
8. A Nextflow process block named `GENERATE_READS`, which defines what the process does.
9. An `input` definition block that assigns the `input` to the variable `read`, and declares that it should be interpreted as a file path.
10. An `output` definition block that uses the Linux/Unix standard output stream `stdout` from the script block.
11. A script block that contains the bash commands `printf '${targz}\\t'` and `tar -xzf $targz`.

## Running Nextflow scripts

To run a Nextflow script use the command `nextflow run <script_name>`.

## Run a Nextflow script

Run the script by entering the following command in your terminal:

```bash
$ nextflow run 01_read_data.nf
```

## Solution

You should see output similar to the text shown below:

```output
 N E X T F L O W   ~  version 24.10.4

Launching `01_read_data.nf` [frozen_booth] DSL2 - revision: 8a3d1bb9c7

executor >  local (1)
[52/af3b5c] GENERATE_READS (1) [100%] 1 of 1 ✔
[/workspaces/training/work/52/af3b5ca0b401d80915bf823d321a7f/school123_period1.RDS, /workspaces/training/work/52/af3b5ca0b401d80915bf823d321a7f/school123_period2.RDS, /workspaces/training/work/52/af3b5ca0b401d80915bf823d321a7f/school124_period1.RDS, /workspaces/training/work/52/af3b5ca0b401d80915bf823d321a7f/school124_period2.RDS, /workspaces/training/work/52/af3b5ca0b401d80915bf823d321a7f/school125_period1.RDS, /workspaces/training/work/52/af3b5ca0b401d80915bf823d321a7f/school125_period2.RDS, /workspaces/training/work/52/af3b5ca0b401d80915bf823d321a7f/school126_period1.RDS, /workspaces/training/work/52/af3b5ca0b401d80915bf823d321a7f/school126_period2.RDS, /workspaces/training/work/52/af3b5ca0b401d80915bf823d321a7f/school127_period1.RDS, /workspaces/training/work/52/af3b5ca0b401d80915bf823d321a7f/school127_period2.RDS, /workspaces/training/work/52/af3b5ca0b401d80915bf823d321a7f/school128_period1.RDS, /workspaces/training/work/52/af3b5ca0b401d80915bf823d321a7f/school128_period2.RDS]
```

1. The first line shows the Nextflow version number.
2. The second line shows the run name `frozen_booth` (adjective and scientist name) and revision id `8a3d1bb9c7`.
3. The third line tells you the process has been executed locally (`executor >  local`).
4. The next line shows the process id `52/af3b5c`, process name, number of cpus, percentage task completion, and how many instances of the process have been run. Each instance is listed sequentially and separated by a `,` to demonstrate the flow of data as inputs. 
5. The final line is the output of the `.view()` operator.
  

## Quick recap

- A workflow is a sequence of tasks that process a set of data, and a workflow
  management system (WfMS) is a computational platform that provides an
  infrastructure for the set-up, execution and monitoring of workflows.
- Nextflow scripts comprise of *channels* for controlling inputs and outputs,
  and *processes* for defining workflow tasks.
- You run a Nextflow script using the `nextflow run` command.

- A workflow is a sequence of tasks that process a set of data.
- A workflow management system (WfMS) is a computational platform that provides an infrastructure for the set-up, execution and monitoring of workflows.
- Nextflow scripts comprise of channels for controlling inputs and outputs, and processes for defining workflow tasks.
- You run a Nextflow script using the `nextflow run` command.
