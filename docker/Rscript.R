
#renv::install(c('dplyr', 'metafor', 'argparse'))

#renv::install(c('Matrix', 'lattice', 'parallel', 'MASS', 'methods', 'xtable', 'network', 'codetools', 'dplyr', 'metafor', 'argparse'))


#wants <- c('Matrix', 'lattice', 'parallel', 'MASS', 'methods', 'xtable', 'network', 'codetools', 'dplyr', 'metafor', 'argparse')
         
#has   <- wants %in% rownames(installed.packages())

#if(any(!has)) install.packages(wants[!has])

#lapply(wants, library, character.only=TRUE)
#
#renv::settings$snapshot.type("all")
#renv::snapshot()