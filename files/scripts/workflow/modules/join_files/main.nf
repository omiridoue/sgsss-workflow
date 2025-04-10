process JOINFILES {
  tag{school_period}
  label 'big_mem'
  errorStrategy 'ignore'
  debug true

  publishDir "${params.outdir}/plots", mode: "copy", overwrite: true

  input:
  //tuple val(school_period), val(socialinteraction), path("*")
  tuple val(school_period), path("*")

  output:
  path("*")

  script:
  template '3000_moran_plots.R'

}