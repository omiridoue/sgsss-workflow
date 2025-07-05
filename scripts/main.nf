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

/* 
* Default pipeline parameters 
*/

params.help            = false
params.resume          = true
cleanup = true
debug = true
log.info """
====================================================
 ╔═╔ ╔═╗╔╗╔ ╔═╗
 ║ ║ ║╣ ║║║ ║═║
═╝ ╝ ╚═╝╝╚╝ ╝ ╝
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

//values = file(params.values)
//if( !values.exists() ) exit 1, "Missing values file: '${params.values}'. Specify the path with --values parameter"

// Create a channel for values 

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

//n_batches = Channel.from( 1..params.batches )

//import modules 
include { GENERATE_READS as GENERATE_RDS} from './modules/generate_reads/'
include { GENERATE_READS as GENERATE_DAT} from './modules/generate_reads/'

include { ESTIMATION } from './modules/estimation/'
include { META_MORAN } from './modules/meta_moran/'
include { JOINFILES } from './modules/join_files/'


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

    estimation_channel = composition \
        | combine(dataset, by: 1) \
        | combine(pipe_meta) \
        | map { it -> [it[0], it[5], it[1], it[2], it[0], it[4], it[0].split('_|\\.')[1]]} \
        | combine(pipe_effects, by:[0,1])

    mapped_params = map_join(pipe_school_info, 'key', 'value')
    
    estimation_out = ESTIMATION(estimation_channel)

    estimation_out.simulation_ch\
        | map { it -> [it[0].split('_|\\.')[0], it[1], it[2], it[3], it[4]]} \
        | combine(mapped_params, by: 0) \
        | transpose \
        | groupTuple(by: [1, 5], sort: true) \
        | map { it -> [it[1], it[3][0], it[3][1], it[3][2], it[3][3], it[5]]  } \
        | META_MORAN \
        | collect \
        | JOINFILES 
        
}

workflow.onComplete {
    println "Pipeline completed!"
    println "Started at  $workflow.start" 
    println "Finished at $workflow.complete"
    println "Time elapsed: $workflow.duration"
    println "Execution status: ${ workflow.success ? 'OK' : 'failed' }"
}
