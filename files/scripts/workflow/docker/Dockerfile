FROM bioconductor/bioconductor_docker:devel-R-4.4.1

RUN R -e "install.packages(c('Matrix', 'lattice', 'parallel', 'MASS', 'methods', 'xtable', 'network', 'vioplot', 'sna', 'codetools', 'dplyr', 'metafor', 'argparse', 'stringr', 'mixmeta'), repos = c(CRAN = 'https://cloud.r-project.org'))"

COPY rsiena_1.4.19.tar.gz .

RUN R -e "install.packages('rsiena_1.4.19.tar.gz', repos = NULL, type = 'source')"