
# Section 05: Processes (optional)

| Teaching  | 30 | Exercises  | 15 | 
| --------------- | -------------- | -------------- |-------------- |


- Understand how Nextflow uses processes to execute tasks.
- Create a Nextflow process.
- Define inputs to a process.

- How do I run tasks/processes in Nextflow?
- How do I get data, files and values, into a processes?

## Processes

We now know how to create and use Channels to send data around a workflow. We will now see how to run tasks within a workflow using processes.

A `process` is the way Nextflow executes commands you would run on the command line or custom scripts.

A process can be thought of as a particular step in a workflow, e.g. an alignment step in RNA-seq analysis. Processes are independent of each other (don't require any another process to execute) and can not communicate/write to each other. Data is passed between processes via input and output Channels.

For example, below is the command you would run to count the number of sequence records in a FASTA format file such as the yeast transcriptome:

- A Nextflow process is an independent step in a workflow.
- Processes contain up to five definition blocks including: directives, inputs, outputs, when clause and finally a script block.
- The script block contains the commands you would like to run.
- A process should have a script but the other four blocks are optional.
- Inputs are defined in the input block with a type qualifier and a name.
