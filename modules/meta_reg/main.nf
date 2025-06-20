process META_REG {
  label 'big_mem'
  errorStrategy 'ignore'
  //debug true

  publishDir "${params.outdir}/siena_meta_reg", mode: "copy", overwrite: true

  input:
  val ready 

  script:

    template '6000_random_effects.R'
    
}