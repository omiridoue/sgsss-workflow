#!/usr/bin/env nextflow

nextflow.enable.dsl=2

/*
===========================================================
 pipeline for independent models runs for each schools
 for each time period, implemented in Siena
 we can then perform a meta-analysis on the results

 @authors
 Eleni Omiridou <2333157O@student.gla.ac.uk>
=========================================================== 
*/

params.meta = "07_worfklow_optional/params/meta.csv"
params.effects = "07_worfklow_optional/params/effects.csv"
params.subgroup = "07_worfklow_optional/params/subgroup.csv"
params.school_data = "07_worfklow_optional/data/each_period.tar.gz"
params.school_info = "07_worfklow_optional/params/school_info.json"
params.composition_data = "07_worfklow_optional/data/composition_each_period.tar.gz"
/* 
* Default pipeline parameters 
*/

// Create a channel for values 
Channel
    .fromPath(params.meta)
    .splitCsv(header: false, sep: '\t')
    .set{ pipe_meta }

Channel
    .fromPath(params.subgroup)
    .splitCsv(header: false, sep: '\t')
    .set{ pipe_subgroup }

def map_join(channel_a, key, value){
    channel_a
        .map{ it -> [it['key'], it['value']] }
}

def flatten_estimation(channel_estimation){
    channel_estimation
        .map{ it -> [it[0], it[1], it[2], it[3][0], it[3][1], it[3][2], it[3][3], it[4][0], it[4][1], it[4][2], it[4][3], it[5][1]] }
}

// Create a channel for values 
Channel
    .fromPath(params.effects)    
    .splitCsv(header: false)
    .map { row -> [row[0], row[1], row[2..-1]] }
    .set{ pipe_effects }

Channel
    .fromPath(params.school_info)
    .splitJson()
    .set{ pipe_school_info }

def ZipChannel_dat = Channel.fromPath(params.composition_data) // change this to composition_sub whenever data file name changes
def ZipChannel_RDS = Channel.fromPath(params.school_data) // change this multi_period_sub whenever data file name changes


workflow {
    
    dataset =  GENERATE_DAT(ZipChannel_RDS) \
    | flatten \
    | map { file ->
    def key = file.name.toString().split('\\.')[0]
    def school_ID = file.name.toString().split("_|\\.")[0]
    return tuple(school_ID, key, file)}
    
    composition = GENERATE_RDS(ZipChannel_dat) 
    | flatten \
    | map { file -> 
    def key = file.name.toString().split('\\.')[0]
    def school_ID = file.name.toString().split("_|\\.")[0]
    return tuple(school_ID, key, file)}

    dataset.view()
    composition.view()

}


process GENERATE_READS {

  input:
          path targz

  publishDir "$baseDir/tmp", mode: "copy", overwrite: true

  output:
          path "*"

  script:
          """
          tar -xzf $targz
          # Print file name
          printf '${targz}\\t'
          """
}

workflow.onComplete {
    println "Pipeline completed!"
    println "Started at  $workflow.start" 
    println "Finished at $workflow.complete"
    println "Time elapsed: $workflow.duration"
    println "Execution status: ${ workflow.success ? 'OK' : 'failed' }"
}