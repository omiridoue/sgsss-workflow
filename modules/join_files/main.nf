process JOINFILES {
  label 'big_mem'
  errorStrategy 'ignore'

  publishDir "${params.outdir}/plots", mode: "copy", overwrite: true

  input:
  val ready

  output:
  val ready

  script:
  template '3000_moran_plots.R'

}
