process META_MORAN {
  tag{school_period}
  label 'big_mem'
  //errorStrategy 'ignore'
  debug true

  publishDir "${params.outdir}/tmp", mode: "copy", overwrite: true

  input:
  tuple val(school_period), path(A),  path(I), path(S), path(N), val(schoolsize)

  output:
  tuple val(school_period), path("*"), optional: true


  script:
  template '3000_meta_moran.R'

}