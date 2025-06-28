# Section 07: Workflow (optional)

| Teaching  | 15 | Exercises  | 15 | 
| --------------- | -------------- | -------------- |-------------- |

- Create a Nextflow workflow joining multiple processes.
- Understand how to to connect processes via their inputs and outputs within a workflow.


- How do I connect channels and processes to create a workflow?
- How do I invoke a process inside a workflow?


## Workflow

Our previous episodes have shown how to parameterise workflows using `params`, move data around a workflow using `channels` and define individual tasks using `processes`. In this episode we will cover how connect multiple processes to create a workflow.

## Workflow definition

We can connect processes to create our pipeline inside a `workflow` scope.
The  workflow scope starts with the keyword `workflow`, followed by an optional name and finally the workflow body delimited by curly brackets `{}`.

## Task 7.1 


## Task 7.1

Ready set workflow! Run the full workflow demo.

:::::::::::::::  solution

``` bash 

nextflow run main.nf -profile local

```

``` output 

training/sgsss-workflow/scripts -> nextflow run main.nf -profile local
Nextflow 25.04.4 is available - Please consider updating your version to it

 N E X T F L O W   ~  version 25.04.3

Launching `main.nf` [confident_kimura] DSL2 - revision: bc82a00e22


====================================================
 ╔═╔ ╔═╗╔╗╔ ╔═╗
 ║ ║ ║╣ ║║║ ║═║
═╝ ╝ ╚═╝╝╚╝ ╝ ╝
====================================================
batches                     : 1
model specification         : /workspaces/training/sgsss-workflow/scripts/params/meta.csv
school data                 : /workspaces/training/sgsss-workflow/scripts/data/each_period.tar.gz
school info                 : /workspaces/training/sgsss-workflow/scripts/params/school_info.json
composition data            : /workspaces/training/sgsss-workflow/scripts/data/composition_each_period.tar.gz
effects                     : /workspaces/training/sgsss-workflow/scripts/params/effects.csv
subgroup                    : /workspaces/training/sgsss-workflow/scripts/params/subgroup.csv



executor >  local (8)
[d0/de71b6] GENERATE_DAT (1)               [100%] 1 of 1 ✔
[08/aff58c] GENERATE_RDS (1)               [100%] 1 of 1 ✔
[0e/2d5ac4] ESTIMATION (school123_period2) [ 12%] 4 of 32
[-        ] META_MORAN                     -
[-        ] JOINFILES                      -

```

## Implicit workflow

In contrast to processes, the workflow definition in Nextflow does not require a name. In Nextflow, if you don't give a name to a workflow, it's considered the main/implicit starting point of your workflow program.

A named workflow is a `subworkflow` that can be invoked from other workflows, subworkflows are not covered in this lesson, more information can be found in the official documentation [here](https://www.nextflow.io/docs/latest/workflow.html).


#### Invoking processes with a workflow

As seen previously, a `process` is invoked as a function in the `workflow` scope, passing the expected input channels as arguments as it if were.

To combine multiple processes invoke them in the order they would appear in a workflow. When invoking a process with multiple inputs, provide them in the same order in which they are declared in the `input` block of the process.

#### Process outputs

A process output can also be accessed directly using the `out` attribute for the respective `process object`. Remember this is what we did in the Hello Nextflow episode when we specified `GENERATE_READS.out.view()` in the workflow definition. 

When a process defines two or more output channels, each of them can be accessed using the list element operator e.g. `out[0]`, `out[1]`, or using named outputs.

#### Process named output

It can be useful to name the output of a process, especially if there are multiple outputs.

The process `output` definition allows the use of the `emit:` option to define a named identifier that can be used to reference the channel in the external scope.

## Task 7.2

Inspect the code for the `ESTIMATION` module. Can you identify the named output that is used in the workflow in the `main.nf` file?

The named out channel involves `simulation_ch` after implementing the ESTIMATION moderator. 

``` groovy
workflow{
    .
    .
    .
    estimation_out = ESTIMATION(estimation_channel)

    estimation_out.simulation_ch

}
```



#### Accessing script parameters

A workflow component can access any variable and parameter defined in the outer scope. 

In this example `pipe_meta` or `pipe_effects`, are defined outside the workflow scope, but are accessed inside the `workflow` scope.

## Task 7.3

Open the `main.nf` file and identify at which stage of the workflow is the output of the process `META_MORAN` being connected to `JOINFILES` process in the workflow definition.

**Note:** You will need to use the `collect` operator to gather the items in the simulation_ch to a single List item. The reason for this is the `JOINFILES` module combines output into a figure summarising model comparison statistics.

``` groovy

workflow {
.
.
.
    estimation_out.simulation_ch\
        | map { it -> [it[0].split('_|\\.')[0], it[1], it[2], it[3], it[4]]} \
        | combine(mapped_params, by: 0) \
        | transpose \
        | groupTuple(by: [1, 5], sort: true) \
        | map { it -> [it[1], it[3][0], it[3][1], it[3][2], it[3][3], it[5]]  } \
        | META_MORAN \
        | collect \
        | JOINFILES \
        | view
}        
```

- A Nextflow workflow is defined by invoking `processes` inside the `workflow` scope.
- A process is invoked like a function inside the `workflow` scope passing any required input parameters as arguments. e.g. `ESTIMATION(estimation_channel)`.
- Process outputs can be accessed using the `out` attribute for the respective `process` object or assigning the output to a Nextflow variable. 
- Multiple outputs from a single process can be accessed using the list syntax `[]` and it's index or by referencing the a named process output .
