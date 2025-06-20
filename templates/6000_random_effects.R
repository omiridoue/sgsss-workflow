#!/usr/bin/env Rscript

# Load Data & Dependencies

require(RSiena)
require(network)
require(sna)
require(stringr)
require(dplyr)
require(metafor)
require(mixmeta)


school_vars <- readRDS(paste0("${projectDir}","/data/trial_info.RDS"))

eff <- c("smoking average alter", "gender similarity")

subgroup <- c("","_subgroup_non_rural","_subgroup_rural","_subgroup_control","_subgroup_trial")

for (group in subgroup){
      
    for (j in eff) {
      siena_fishers_period1 <- readRDS(file = paste0("${projectDir}","/results/","siena_results/period1/", "/siena_fishers", group, ".RDS"))
      siena_fishers_period2 <- readRDS(file = paste0("${projectDir}","/results/","siena_results/period2/", "/siena_fishers", group, ".RDS"))
      
      
      rename_columns1 <- colnames(siena_fishers_period1[-((ncol(siena_fishers_period1) - 6):ncol(siena_fishers_period1))])
      rename_columns2 <- colnames(siena_fishers_period2[-((ncol(siena_fishers_period2) - 6):ncol(siena_fishers_period2))])
      
      school_ids1 <- sapply(rename_columns1, function(x) {
        parts <- strsplit(x, "/")[[1]][11]
        schools <- strsplit(parts, "_")[[1]][1]
        return(schools)
      })
      
      school_ids2 <- sapply(rename_columns2, function(x) {
        parts <- strsplit(x, "/")[[1]][11]
        schools <- strsplit(parts, "_")[[1]][1]
        return(schools)
      })
      
      # need to fix this part 
      
      colnames(siena_fishers_period1)[(1:(length(siena_fishers_period1) - 7))] <- school_ids1
      colnames(siena_fishers_period2)[(1:(length(siena_fishers_period2) - 7))] <- school_ids2
      
      p1 <- (length(siena_fishers_period1) - 7)
      p2 <- (length(siena_fishers_period2) - 7)
      
      mvmeta_data <- cbind(t(siena_fishers_period1[(rownames(siena_fishers_period1) == j), (1:(length(siena_fishers_period1) - 7))]), rep("period1", p1))
      
      colnames(mvmeta_data)[2] <- "time"
      
      school_p1 <- school_ids1
      
      mvmeta_data <- cbind(mvmeta_data, school_p1)
      
      tmp_p2 <- cbind(t(siena_fishers_period2[(rownames(siena_fishers_period2) == j), (1:(length(siena_fishers_period2) - 7))]), rep("period2", p2))
      
      colnames(tmp_p2)[2] <- "time"
      
      school_p2 <- school_ids2
      
      tmp_p2 <- cbind(tmp_p2, school_p2)
      
      mvmeta_data <- rbind(mvmeta_data, tmp_p2)
      
      mvmeta_data <- as.data.frame(mvmeta_data)
      colnames(mvmeta_data)[3] <- "school"
      rownames(mvmeta_data) <- NULL
      
      mvmeta_data\$SD <- sapply(strsplit(as.character(mvmeta_data[, 1]), " "), function(x) x[[2]][1])
      mvmeta_data[, 1] <- sapply(strsplit(as.character(mvmeta_data[, 1]), " "), function(x) x[[1]][1])
      mvmeta_data\$SD <- str_replace_all(mvmeta_data\$SD, "[()]", "")
      
      mvmeta_data[, 1] <- as.numeric(mvmeta_data[, 1])
      mvmeta_data\$SD <- as.numeric(mvmeta_data\$SD)
      
      mvmeta_data <- mvmeta_data |>
        left_join(school_vars, by = "school")
      
      j_clean <- str_replace_all(j, "[( ) : .]", "_")
      j_clean <- str_replace_all(j_clean, "__", "_")
      j_clean <- str_replace_all(j_clean, "__", "_")
      
      saveRDS(mvmeta_data, file = paste0("${projectDir}","/results/","siena_meta_reg/","/", j_clean, group, ".RDS"))
    }
}

directories <- list.dirs(path = paste0("${projectDir}","/results/","siena_meta_reg"), full.names = TRUE, recursive = FALSE)

subgroup <- c("","_subgroup_non_rural","_subgroup_rural","_subgroup_control","_subgroup_trial")

mvmeta <- c();

for (dir in directories) {
  # Perform operations for each directory
  sub_directories <- list.files(path = dir, full.names = TRUE, recursive = TRUE)
  
  for (file_path in sub_directories) {
    
    mvmeta[[file_path]] <- readRDS(file=file_path)
    
  }
}

effects <- c("smoking_average_alter", "gender_similarity")

res <- c();
res_mlm <- c();
  
  for (effect in effects){
    
    yi <- mvmeta[[paste0("${projectDir}","/results/","siena_meta_reg/",effect,".RDS")]][,1]
    vi <- mvmeta[[paste0("${projectDir}","/results/","siena_meta_reg/",effect,".RDS")]][,"SD"]
    groupitt <- mvmeta[[paste0("${projectDir}","/results/","siena_meta_reg/",effect,".RDS")]][,"groupitt"]
    school <- mvmeta[[paste0("${projectDir}","/results/","siena_meta_reg/",effect,".RDS")]][,"school"]
    
    time <- as.numeric(
      str_extract( mvmeta[[paste0("${projectDir}","/results/","siena_meta_reg/",effect,".RDS")]][,"time"], "[0-9]+"))
    
    dat <- cbind(yi,vi,groupitt,time)
    dat <- as.data.frame(dat)
    
    res[[paste0(effect)]] <- rma(yi ~ groupitt, vi^2, data = dat)

    res_mlm[[paste0(effect)]] <- mixmeta(yi ~ groupitt, vi^2, random= ~ 1|time, data=dat)
    
    (res_mlm[[paste0(effect)]])
    
  }
  
}

res1 <- res[["gender_similarity"]]
res2 <- res[["smoking_average_alter"]]
  
summary(res1,ci.level=0.95)
summary(res2,ci.level=0.95)

## -----------------------------------------------------------------------------
# Supplementary Table1 in Paper for Discussion
## -----------------------------------------------------------------------------

eff1 <- mvmeta[[paste0("${projectDir}","/results/siena_meta_reg/gender_similarity.RDS")]]

eff2 <- mvmeta[[paste0("${projectDir}","/results/siena_meta_reg/smoking_average_alter.RDS")]]

# b and se 
(mean(eff1[,1]))
(sd(eff1[,1])/sqrt(12))

# b and se 
(mean(eff2[,1]))
(sd(eff2[,1])/sqrt(12))

## -----------------------------------------------------------------------------
## Sub-group Non rural 
## -----------------------------------------------------------------------------

# Supplementary Table1 in Paper for Discussion

eff1_subgroup_non_rural <- mvmeta[[paste0("${projectDir}","results/siena_meta_reg/gender_similarity_subgroup_non_rural.RDS")]]

eff2_subgroup_non_rural <- mvmeta[[paste0("${projectDir}","results/siena_meta_reg/smoking_average_alter_subgroup_non_rural.RDS")]]

# b and se 
(mean(eff1_subgroup_non_rural[,1]))
(sd(eff1_subgroup_non_rural[,1])/sqrt(4))

# b and se 
(mean(eff2_subgroup_non_rural[,1]))
(sd(eff2_subgroup_non_rural[,1])/sqrt(4))

## -----------------------------------------------------------------------------
## Sub-group rural 
## -----------------------------------------------------------------------------

# Supplementary Table1 in Paper for Discussion

eff1_subgroup_rural <- mvmeta[[paste0("${projectDir}","results/siena_meta_reg/gender_similarity_subgroup_rural.RDS")]]

eff2_subgroup_rural <- mvmeta[[paste0("${projectDir}","results/siena_meta_reg/smoking_average_alter_subgroup_rural.RDS")]]


# b and se 
(mean(eff1_subgroup_rural[,1]))
(sd(eff1_subgroup_rural[,1])/sqrt(3))

# b and se 
(mean(eff2_subgroup_rural[,1]))
(sd(eff2_subgroup_rural[,1])/sqrt(3))

## -----------------------------------------------------------------------------
## Sub-group control 
## -----------------------------------------------------------------------------

# Supplementary Table1 in Paper for Discussion

eff1_subgroup_control <- mvmeta[[paste0("${projectDir}","results/siena_meta_reg/gender_similarity_subgroup_control.RDS")]]

eff2_subgroup_control <- mvmeta[[paste0("${projectDir}","results/siena_meta_reg/smoking_average_alter_subgroup_control.RDS")]]


# b and se 
(mean(eff1_subgroup_control[,1]))
(sd(eff1_subgroup_control[,1])/sqrt(6))

# b and se 
(mean(eff2_subgroup_control[,1]))
(sd(eff2_subgroup_control[,1])/sqrt(6))

## -----------------------------------------------------------------------------
## Sub-group trial 
## -----------------------------------------------------------------------------

# Supplementary Table1 in Paper for Discussion

eff1_subgroup_trial <- mvmeta[[paste0("${projectDir}","results/siena_meta_reg/gender_similarity_subgroup_trial.RDS")]]

eff2_subgroup_trial <- mvmeta[[paste0("${projectDir}","results/siena_meta_reg/smoking_average_alter_subgroup_trial.RDS")]]

# b and se 
(mean(eff1_subgroup_trial[,1]))
(sd(eff1_subgroup_trial[,1])/sqrt(7))

# b and se 
(mean(eff2_subgroup_trial[,1]))
(sd(eff2_subgroup_trial[,1])/sqrt(7))
