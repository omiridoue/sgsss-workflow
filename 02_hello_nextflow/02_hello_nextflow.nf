#!/usr/bin/env nextflow

/*
========================================================================================
    Workflow parameters are written as params.<parameter>
    and can be initialised using the `=` operator.
========================================================================================
*/

params.input = "07_worfklow_optional/data/each_period.tar.gz"

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
