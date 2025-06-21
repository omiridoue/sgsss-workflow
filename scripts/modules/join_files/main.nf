process JOINFILES {
  tag{school_period}
  label 'big_mem'
  errorStrategy 'ignore'
  debug true

  publishDir "${params.outdir}/plots", mode: "copy", overwrite: true

  input:
  val ready

  output:
  path("*")

  script:
  template '3000_moran_plots.R'

}