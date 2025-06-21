process ESTIMATION {
    
  tag{school_period}
  label 'small_time_cpus'
  
  errorStrategy { task.exitStatus == 140 ? 'retry' : 'ignore' } 
  maxRetries 1

  publishDir "$params.outdir/siena_fit", pattern: "*.RDS",  mode: "copy", overwrite: true // all file outputs are copied to this directory - i.e CONVERGED / NOT CONVERGED
  
  publishDir "$params.outdir/siena_sim/$school_period", pattern: "*_SIM.RDS",  mode: "copy", overwrite: true
  publishDir "$params.outdir/siena_gof/$school_period", pattern: "*.png",  mode: "copy", overwrite: true

  input:
  tuple val(school_period), val(specification), val(school_ID_dat), path(compositionFile_period), val(school_ID), path(STR), val(period), val(effects)
  
  output:
  tuple val(school_ID), val(school_period), val(specification), path("*_SIM.RDS"), val(period), emit: simulation_ch
  tuple val(school_ID), val(school_period), val(specification), path("*A*_CONVERGED.RDS"), val(period), optional: true, emit: meta_reg_ch
  tuple val(school_ID), val(school_period), val(specification), path("*.png"), val(period), optional: true, emit: gof_ch
  tuple val(school_ID), val(school_period), val(specification), path("*.tex"), val(period), optional: true, emit: estimates_ch


  script:

  if (specification == "all")
      template '1000_model_estimation_all.R'
  else if (specification == "influence")
      template '1000_model_estimation_influence.R'
  else if (specification == "none")
      template '1000_model_estimation_no.R'
  else
      template '1000_model_estimation_selection.R'

}