# Section 03: Workflow Parameterisation

| Teaching  | 30 | Exercises  | 15 | 
| --------------- | -------------- | -------------- |-------------- |


- Understand how Nextflow manages data using channels.
- Create a value and queue channel using channel factory methods.
- Edit channel factory arguments to alter how data is read in.


- How do I move data around in Nextflow?
- How do I handle different types of input, e.g. files and parameters?
- How can I use pattern matching to select input files?


## Channels

Earlier we learnt that channels are the way in which Nextflow sends data around a workflow. Channels connect processes via their inputs and outputs. Channels can store multiple items, such as values. The number of items a channel stores, determines how many times a process will run, using that channel as input.  
*Note:* When the process runs using one item from the input channel, we will call that run a `task`.

## Why use Channels?

Channels are how Nextflow handles file management, allowing complex tasks to be split up, and run in parallel.

![](fig/channel-files.png){alt='Channel files'}

Channels are asynchronous, which means that outputs from a set of processes will not necessarily be produced in the same order as the corresponding inputs went in.
However, the first element into a channel queue is the first out of the queue (First in - First out). This allows processes to run as soon as they receive input from a channel. Channels only send data in one direction.

## Channel types

Nextflow distinguishes between two different kinds of channels: **queue** channels and **value** channels.

### Queue channel

Queue channels are a type of channel in which data is consumed (used up) to make input for a process/operator. Queue channels can be created in two ways:

1. As the outputs of a process.
2. Channel factory methods [Channel.of](https://www.nextflow.io/docs/latest/channel.html#of) or [Channel.fromPath](https://www.nextflow.io/docs/latest/channel.html#frompath).

### Value channels

The second type of Nextflow channel is a `value` channel. A **value** channel is bound to a **single** value. A value channel can be used an unlimited number times since its content is not consumed. 


## Queue vs Value Channel.

What type of channel would you use to store the following?

1. Multiple values.
2. A list with one or more values.
3. A single value.

## Solution

1. A queue channels is used to store multiple values.
2. A value channel is used to store a single value, this can be a list with multiple values.
3. A value channel is used to store a single value.
  