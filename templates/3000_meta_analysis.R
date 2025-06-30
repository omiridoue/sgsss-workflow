#!/usr/bin/env Rscript

# Load Data & Dependencies

require(network)
require(sna)

# Load Utility Functions
script_dir <- file.path("${projectDir}", "bin")

source(file.path(script_dir, "moran_decomposition.R"))

folders <- paste0("${projectDir}","/results/siena_sim/","${school_period}")
print(folders)

siena_meta_df <- data.frame(matrix(ncol = 27, nrow = 0))
x <- c("school", "school_period", "Moran_School", "Moran_School_exclPI", "Moran_School_exclPS", "Moran_School_exclBoth", "Moran_School_SD", "Moran_School_exclPI_SD", "Moran_School_exclPS_SD", "Moran_School_exclBoth_SD", "School_PS_M", "School_PI_M", "School_Undetermined_M", "School_Control_M", "GearyC_School", "GearyC_School_exclPI", "GearyC_School_exclPS", "GearyC_School_exclBoth", "GearyC_School_SD", "GearyC_School_exclPI_SD", "GearyC_School_exclPS_SD", "GearyC_School_exclBoth_SD", "School_PS_G", "School_PI_G", "School_Undetermined_G", "School_Control_G")
colnames(siena_meta_df) <- x

sim_files <- list.files(path = folders, full.names = TRUE, recursive = TRUE)
print(sim_files)

if (length(sim_files) == 4) {
    # Load the data
    School_raw <- readRDS(sim_files[1])
    School_exclPI_raw <- readRDS(sim_files[3])
    School_exclPS_raw <- readRDS(sim_files[2])
    School_exclBoth_raw <- readRDS(sim_files[4])

    # Extract the school period and social interaction
    school_period <- "${school_period}"
    
    # Extract the school size
    input <- "${schoolsize}"
    # print(input)

    nodes <- as.integer(input)

    school <- strsplit(school_period, "_")[[1]][1]

    output <- moran_decomposition(School_raw, School_exclPI_raw, School_exclPS_raw, School_exclBoth_raw, nodes, school_period, socialinteraction)
    temp <- cbind(school, school_period, output[[1]], output[[2]], output[[3]], output[[4]], output[[5]], output[[6]], output[[7]], output[[8]], output[[9]], output[[10]], output[[11]], output[[12]], output[[13]], output[[14]], output[[15]], output[[16]], output[[17]], output[[18]], output[[19]], output[[20]], output[[21]], output[[22]], output[[23]], output[[24]])
    siena_meta_df <- rbind(siena_meta_df, temp)

    x <- c("school", "school_period", "social_interaction", "Mean_Moran_School", "Mean_Moran_School_exclPI", "Mean_Moran_School_exclPS", "Mean_Moran_School_exclBoth", "SD_Moran_School", "SD_Moran_School_exclPI", "SD_Moran_School_exclPS", "SD_Moran_School_exclBoth", "School_PS_M", "School_PI_M", "School_Undetermined_M", "School_Control_M", "Mean_Geary_School", "Mean_Geary_School_exclPI", "Mean_Geary_School_exclPS", "Mean_Geary_School_exclBoth", "SD_Geary_School", "SD_School_exclPI", "SD_School_exclPS", "SD_School_exclBoth", "School_PS_G", "School_PI_G", "School_Undetermined_G", "School_Control_G")
    colnames(temp) <- x
            
    saveRDS(temp, file = paste0("${projectDir}","/results/tmp/","${school_period}","_","${socialinteraction}", "_moran", ".RDS"))
} else print("Error: Incorrect number of files")
