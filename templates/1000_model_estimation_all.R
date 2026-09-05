#!/usr/bin/env Rscript

#args <- commandArgs(trailingOnly = TRUE)
# Load Utility Functions
script_dir <- file.path("${projectDir}", "bin")
source(file.path(script_dir, "sienaRunToConvergence.R"))
source(file.path(script_dir, "sienaRunSimOnly.R"))
source(file.path(script_dir, "EgoAlterTable.R"))
source(file.path(script_dir, "InfluenceTables.R"))

# Load Data & Dependencies
library(RSiena)
require(network)
require(sna)
require(stringr)
require(dplyr)
require(parallel)

availableCores <- detectCores(logical = FALSE)

effects_raw <- "${effects}"

effects_raw <- gsub("[[:punct:]]", "", effects_raw)
effects_raw <- unlist(strsplit(effects_raw, " "))

effects_info <- effects_raw

#str(effects_info)
#print(effects_info)
school_period_info <- "${school_period}"
specification <- "${specification}"
print("====================================")
print("INFORMATION ON INPUTS OF THE MODEL ESTIMATION")
print("====================================")
print(school_period_info)
print(specification)
print("====================================")

school <- readRDS("${STR}")
compChange <- RSiena::sienaCompositionChangeFromFile("${compositionFile_period}")

# Create Behaviour Data Object
behavior_matrix <- as.matrix(school[["behavior"]])

smoking <- RSiena::as_dependent_rsiena(behavior_matrix, type = "behavior")

# Constant Covariates over Time
gender <- RSiena::as_covariate_rsiena(school[["gender"]], warn=FALSE)

friends <- as_dependent_rsiena(school[["friendship"]])

# Load data objects to Siena model
myData <- RSiena::make_data_rsiena(friends, smoking, gender, compChange)

myEffects_Network <- RSiena::make_specification(myData)

# Model Specification
myEffects_Network <- set_effect(myEffects_Network, Rate, type="rate",
             depvar="friends")
myEffects_Network <- set_effect(myEffects_Network, list(density, recip,
             gwespFF), type="eval", depvar="friends")
myEffects_Network <- set_effect(myEffects_Network, linear, type="eval",
             depvar="smoking")

myEffects_Network <- set_effect(myEffects_Network, egoX, type="eval",
             depvar="friends", covar1="gender")

myEffects_Network <- set_effect(myEffects_Network, effFrom, type="eval",
             depvar="smoking", covar1="gender")


effects_info <- as.logical(effects_info)
cond <- which(effects_info)

# for (i in seq_along(cond)) {
#   if (cond[i] < max(myEffects_Network[, c("effectNumber")])) {
#     myEffects_Network[myEffects_Network[, c("effectNumber")] == cond[i], c("fix")] <- TRUE
#     myEffects_Network[myEffects_Network[, c("effectNumber")] == cond[i], c("test")] <- TRUE
#   }
# }

modelOptions <- sienaAlgorithmCreate(diagonalize=0.2, seed=786840, useStdInits = TRUE, n3 = 100)

myResults <- RSiena::siena(modelOptions,
                             data = myData,
                             effects = myEffects_Network,
                             batch=TRUE,
                             verbose=FALSE,
                             silent=TRUE,
                             returnDeps=TRUE,
						     thetaBound=Inf)

# # ===============================================================================

modelOptions_conv <- RSiena::sienaAlgorithmCreate(
  MaxDegree = c(friends = 6),
  diagonalize = .2,
  seed = 786840,
  n3 = 10000,
  firstg = 0.05
) # the seed is for the lab only

# # # # ===============================================================================
# myResults <- sienaRunToConvergence(alg=modelOptions_conv,
#    dat = myData,
#    eff = myEffects_Network,
#    thetaB=Inf,
#    ans0 = ans0,
#    modelName = paste0("${school_period}","_A_"),
#     batch=TRUE,
#     verbose=FALSE,
#     silent=TRUE,
#    returnThetas=TRUE,
#    returnChains=FALSE,
#    returnDeps=TRUE,
#     status = NULL,
#     nbrNodes = 10,
#     useCluster = TRUE)

modelOptions_sim <- RSiena::sienaAlgorithmCreate(
  MaxDegree = c(friends = 6),
  diagonalize = .2,
  seed = 786840,
  simOnly = TRUE,
  nsub = 0,
  n3 = 500
) # the seed is for the lab only

# # # ===============================================================================
myResults_sim <- sienaRunSimOnly(alg = modelOptions_sim,
   dat = myData,
   eff = myEffects_Network,
   thetaB=Inf,
   ans0 = myResults,
   modelName = paste0("${school_period}","_A_"),
   batch=TRUE,
   verbose=TRUE,
   silent=FALSE,
   returnThetas=TRUE,
   returnChains=FALSE,
   returnDeps=TRUE,
   status = NULL)

png(filename=paste0("${school_period}","_A_", "gofEgoAlterTable.png"))
gof.EgoAlterTable <- sienaGOF(myResults_sim,EgoAlterTable,
	verbose=TRUE,join=TRUE,varName=c("friends","smoking"))
plot(gof.EgoAlterTable, main = paste0("${school_period}","_A_", "gofEgoAlterTable"))
dev.off()
