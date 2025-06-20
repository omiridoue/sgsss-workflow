process META_FISHERS {
  tag{subgroup}
  label 'big_mem'
  errorStrategy 'ignore'
  //debug true

  publishDir "${params.outdir}/siena_results", mode: "copy", overwrite: true

  input:
  tuple val(period), val(subgroup)

  output:
  val true

  script:

    if (subgroup == "full")
        template '4000_meta_regression.R'
    else if (subgroup == "trial")
        template '4000_meta_regression_trial.R'
    else
        template '4000_meta_regression_valley.R'

}