#!/usr/bin/env Rscript

# Load Data & Dependencies

require(metafor)
require(stringr)
require(dplyr)
require(vioplot)

## -----------------------------------------------------------------------------
## Load Meta-Data
## -----------------------------------------------------------------------------

## -----------------------------------------------------------------------------
files <- list.files(path = paste0("${projectDir}","/results/tmp/"), full.names = TRUE, recursive = TRUE)

dat <- do.call('rbind', lapply(lapply(list.files(paste0("${projectDir}","/results/tmp/"), full.names = TRUE, recursive=TRUE), readRDS),as.data.frame))

saveRDS(dat, file = paste0("${projectDir}","/results/moran/", "moran_decomposition", ".RDS"))

nacf_OBS_NULL <- readRDS(paste0("${projectDir}","/results/moran/nacf_OBS_NULL.RDS"))

moran_decomposition <- dat
colnames(nacf_OBS_NULL) <- colnames(moran_decomposition)

school_info <- readRDS(paste0("${projectDir}","/data/trial_info.RDS"))

## -----------------------------------------------------------------------------
## Clean Variables
## -----------------------------------------------------------------------------
nacf_OBS_NULL$time <- rep(c(1,2), times=(dim(nacf_OBS_NULL)[1] / 2))

moran_decomposition <- moran_decomposition |> 
  mutate(across(c(3:26), as.numeric)) |> 
  left_join(school_info, by="school")

colnames(nacf_OBS_NULL)[27] <- "social_interaction"

## -----------------------------------------------------------------------------
## Meta-Analysis - MORAN I
## -----------------------------------------------------------------------------
# SUB GROUP ANALYSIS - VALLEY/NON-VALLEY AREAS
moran_decomposition |> 
  group_by(valley,school_period) |> 
  summarise(Group_Mean_Control_M = mean(Trial_Control_M),
            Group_Mean_PS_M = mean(Trial_PS_M), 
            Group_Mean_PI_M = mean(Trial_PI_M),
            Group_Mean_Undet_M = mean(Trial_Undetermined_M), 
            Group_Mean_Control_M = mean(Trial_Control_M), 
            Group_Mean_PS_M = mean(Trial_PS_M),
            Group_Mean_PI_M = mean(Trial_PI_M),
            Group_Mean_Undet_M = mean(Trial_Undetermined_M)) 

# SUB GROUP ANALYSIS - INTERVENTION/CONTROL ARMS
moran_decomposition |> 
  group_by(groupitt,school_period) |> 
  summarise(Group_Mean_Control_M = mean(Trial_Control_M),
            Group_Mean_PS_M = mean(Trial_PS_M), 
            Group_Mean_PI_M = mean(Trial_PI_M),
            Group_Mean_Undet_M = mean(Trial_Undetermined_M), 
            Group_Mean_Control_M = mean(Trial_Control_M), 
            Group_Mean_PS_M = mean(Trial_PS_M),
            Group_Mean_PI_M = mean(Trial_PI_M),
            Group_Mean_Undet_M = mean(Trial_Undetermined_M)) 

# SUB GROUP ANALYSIS - SCHOOL SIZE
moran_decomposition |> 
  group_by(stsize,school_period) |> 
  summarise(Group_Mean_Control_M = mean(Trial_Control_M),
            Group_Mean_PS_M = mean(Trial_PS_M), 
            Group_Mean_PI_M = mean(Trial_PI_M),
            Group_Mean_Undet_M = mean(Trial_Undetermined_M), 
            Group_Mean_Control_M = mean(Trial_Control_M), 
            Group_Mean_PS_M = mean(Trial_PS_M),
            Group_Mean_PI_M = mean(Trial_PI_M),
            Group_Mean_Undet_M = mean(Trial_Undetermined_M)) 

## -----------------------------------------------------------------------------
## Meta-Analysis - GEARY C
## -----------------------------------------------------------------------------
# SUB GROUP ANALYSIS - VALLEY/NON-VALLEY AREAS
moran_decomposition |> 
  group_by(valley,school_period) |> 
  summarise(Group_Mean_Control_G = mean(Trial_Control_G),
            Group_Mean_PS_G = mean(Trial_PS_G), 
            Group_Mean_PI_G = mean(Trial_PI_G),
            Group_Mean_Undet_G = mean(Trial_Undetermined_G), 
            Group_Mean_Control_G = mean(Trial_Control_G), 
            Group_Mean_PS_G = mean(Trial_PS_G),
            Group_Mean_PI_G = mean(Trial_PI_G),
            Group_Mean_Undet_G = mean(Trial_Undetermined_G)) 

# SUB GROUP ANALYSIS - INTERVENTION/CONTROL ARMS
moran_decomposition |> 
  group_by(groupitt,school_period) |> 
  summarise(Group_Mean_Control_G = mean(Trial_Control_G),
            Group_Mean_PS_G = mean(Trial_PS_G), 
            Group_Mean_PI_G = mean(Trial_PI_G),
            Group_Mean_Undet_G = mean(Trial_Undetermined_G), 
            Group_Mean_Control_G = mean(Trial_Control_G), 
            Group_Mean_PS_G = mean(Trial_PS_G),
            Group_Mean_PI_G = mean(Trial_PI_G),
            Group_Mean_Undet_G = mean(Trial_Undetermined_G)) 

# SUB GROUP ANALYSIS - SCHOOL SIZE
moran_decomposition |> 
  group_by(stsize,school_period) |> 
  summarise(Group_Mean_Control_G = mean(Trial_Control_G),
            Group_Mean_PS_G = mean(Trial_PS_G), 
            Group_Mean_PI_G = mean(Trial_PI_G),
            Group_Mean_Undet_G = mean(Trial_Undetermined_G), 
            Group_Mean_Control_G = mean(Trial_Control_G), 
            Group_Mean_PS_G = mean(Trial_PS_G),
            Group_Mean_PI_G = mean(Trial_PI_G),
            Group_Mean_Undet_G = mean(Trial_Undetermined_G)) 

png(filename=paste0("${projectDir}","/results/plots/","moranI_autocorr.png"))

# plot Supplementary Figure S1
moran_decomposition |> 
  filter(social_interaction %in% "OBS") |> 
  select(Mean_Moran_Trial,Mean_Moran_Trial_exclPS,Mean_Moran_Trial_exclPI,Mean_Moran_Trial_exclBoth) |> 
  vioplot::vioplot(list(
  full=Mean_Moran_Trial,
  no_sel=Mean_Moran_Trial_exclPS,
  no_inf=Mean_Moran_Trial_exclPI,
  neither=Mean_Moran_Trial_exclBoth),
  col="lightgrey",
  names= c("Full", "Excluding PS", "Excluding PI", "Excluding PS and PI"))

sim <- nacf_OBS_NULL |> 
  filter(social_interaction %in% "SIM") |> 
  select(Mean_Moran_Trial) |> 
  summarise(mean_sim = mean(as.numeric(Mean_Moran_Trial))) |> 
  pull()
  
# add expected Moran under random allocation of behaviour
# as lower reference line:
lines(x=c(0.5,4.5),y=rep(sim,2),col="black",lwd=2)

obs1 <- nacf_OBS_NULL |> 
  filter(social_interaction %in% "OBS") |>
  mutate(time = str_extract(school_period, "[0-9]+")) |> 
  filter(time %in% 1) |> 
  select(Mean_Moran_Trial) |> 
  summarise(mean_sim = mean(as.numeric(Mean_Moran_Trial))) |> 
  pull()

obs2 <- nacf_OBS_NULL |> 
  filter(social_interaction %in% "OBS") |> 
  mutate(time = str_extract(school_period, "[0-9]+")) |> 
  filter(time %in% 2) |> 
  select(Mean_Moran_Trial) |> 
  summarise(mean_sim = mean(as.numeric(Mean_Moran_Trial))) |> 
  pull()

# add observed Moran in data set as upper reference line:
lines(x=c(0.5,4.5),
      y=rep(obs1,2),
      lty="dashed",col="blue",lwd=2)

# add observed Moran in data set as upper reference line:
lines(x=c(0.5,4.5),
      y=rep(obs2,2),
      lty="dashed",col="red",lwd=2)

legend("topright", legend=c("Mean Moran's I, Random Permutations","Mean Observed Moran's I, period 1", "Mean Observed Moran's I, period 2"), fill=c("black","blue", "red"), cex = 0.5)
title(xlab = "Model Specification", ylab = "Moran's I")

dev.off()