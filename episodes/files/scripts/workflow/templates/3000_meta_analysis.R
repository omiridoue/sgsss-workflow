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
x <- c("school", "school_period", "Moran_Trial", "Moran_Trial_exclPI", "Moran_Trial_exclPS", "Moran_Trial_exclBoth", "Moran_Trial_SD", "Moran_Trial_exclPI_SD", "Moran_Trial_exclPS_SD", "Moran_Trial_exclBoth_SD", "Trial_PS_M", "Trial_PI_M", "Trial_Undetermined_M", "Trial_Control_M", "GearyC_Trial", "GearyC_Trial_exclPI", "GearyC_Trial_exclPS", "GearyC_Trial_exclBoth", "GearyC_Trial_SD", "GearyC_Trial_exclPI_SD", "GearyC_Trial_exclPS_SD", "GearyC_Trial_exclBoth_SD", "Trial_PS_G", "Trial_PI_G", "Trial_Undetermined_G", "Trial_Control_G")
colnames(siena_meta_df) <- x

sim_files <- list.files(path = folders, full.names = TRUE, recursive = TRUE)
print(sim_files)

if (length(sim_files) == 4) {
    # Load the data
    Trial_raw <- readRDS(sim_files[1])
    Trial_exclPI_raw <- readRDS(sim_files[3])
    Trial_exclPS_raw <- readRDS(sim_files[2])
    Trial_exclBoth_raw <- readRDS(sim_files[4])

    # Extract the school period and social interaction
    school_period <- "${school_period}"
    
    # Extract the school size
    input <- "${schoolsize}"
    print(input)

    nodes <- as.integer(input)

    school <- strsplit(school_period, "_")[[1]][1]

    output <- moran_decomposition(Trial_raw, Trial_exclPI_raw, Trial_exclPS_raw, Trial_exclBoth_raw, nodes, school_period, socialinteraction)
    temp <- cbind(school, school_period, output[[1]], output[[2]], output[[3]], output[[4]], output[[5]], output[[6]], output[[7]], output[[8]], output[[9]], output[[10]], output[[11]], output[[12]], output[[13]], output[[14]], output[[15]], output[[16]], output[[17]], output[[18]], output[[19]], output[[20]], output[[21]], output[[22]], output[[23]], output[[24]])
    siena_meta_df <- rbind(siena_meta_df, temp)

    x <- c("school", "school_period", "social_interaction", "Mean_Moran_Trial", "Mean_Moran_Trial_exclPI", "Mean_Moran_Trial_exclPS", "Mean_Moran_Trial_exclBoth", "SD_Moran_Trial", "SD_Moran_Trial_exclPI", "SD_Moran_Trial_exclPS", "SD_Moran_Trial_exclBoth", "Trial_PS_M", "Trial_PI_M", "Trial_Undetermined_M", "Trial_Control_M", "Mean_Geary_Trial", "Mean_Geary_Trial_exclPI", "Mean_Geary_Trial_exclPS", "Mean_Geary_Trial_exclBoth", "SD_Geary_Trial", "SD_Trial_exclPI", "SD_Trial_exclPS", "SD_Trial_exclBoth", "Trial_PS_G", "Trial_PI_G", "Trial_Undetermined_G", "Trial_Control_G")
    colnames(temp) <- x
            
    saveRDS(temp, file = paste0("${projectDir}","/results/tmp/","${school_period}","_","${socialinteraction}", "_moran", ".RDS"))
} else print("Error: Incorrect number of files")