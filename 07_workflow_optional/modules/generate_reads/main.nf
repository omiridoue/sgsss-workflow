process GENERATE_READS {
  label 'big_mem'

  input:
          path targz
  
  publishDir "$baseDir/out", mode: "copy", overwrite: true
  
  output:
          path "*"
  
  script:
          """
          tar -xzf $targz 
          """
}