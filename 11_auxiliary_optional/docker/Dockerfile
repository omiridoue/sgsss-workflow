FROM bioconductor/bioconductor_docker:devel-R-4.6.1

RUN R -e "install.packages(c('Matrix', 'lattice', 'parallel', 'MASS', 'methods', 'xtable', 'network', 'vioplot', 'sna', 'codetools', 'dplyr', 'metafor', 'argparse', 'stringr', 'mixmeta', 'igraph', 'ggplot2' , 'influential', 'doParallel', 'parallel', 'tidyr'), repos = c(CRAN = 'https://cloud.r-project.org'))" # buildkit

COPY rsiena_1.6.11.tar.gz .

RUN R -e "install.packages('rsiena_1.6.11.tar.gz', repos = NULL, type = 'source')"
