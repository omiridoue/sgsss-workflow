#!/usr/bin/env nextflow

/*
===========================================================
 pipeline for independent models runs for each schools
 for each time period, implemented in Siena
 we can then perform a meta-analysis on the results

 @authors
 Eleni Omiridou <2333157O@student.gla.ac.uk>
=========================================================== 
*/

/* 
* Default pipeline parameters 
*/

params.help            = false
params.resume          = true
cleanup = true
debug = true
log.info """
====================================================
PARAMETERS
====================================================
batches                     : ${params.batches}
model specification         : ${params.meta}
school data                 : ${params.school_data}
school info                 : ${params.school_info}
composition data            : ${params.composition_data}
effects                     : ${params.effects}
subgroup                    : ${params.subgroup}


"""

if (params.help) {
    log.info 'This is the the siena pipeline'
    log.info '\n'
    exit 1
}

/*
========================================================================================
    Workflow parameters are written as params.<parameter>
    and can be initialised using the `=` operator.
========================================================================================
*/

/*
========================================================================================
    Input data is received through channels
========================================================================================
*/

input_ch = Channel.fromPath(params.school_data)

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
