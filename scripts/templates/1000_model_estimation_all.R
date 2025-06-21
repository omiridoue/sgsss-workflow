#!/usr/bin/env Rscript

#args <- commandArgs(trailingOnly = TRUE)
# Load Utility Functions
script_dir <- file.path("${projectDir}", "bin")
source(file.path(script_dir, "siena07RunToConvergence.R"))
source(file.path(script_dir, "siena07RunSimOnly.R"))
source(file.path(script_dir, "EgoAlterTable.R"))
source(file.path(script_dir, "InfluenceTables.R"))

# Load Data & Dependencies
library(RSiena)
require(network)
require(sna)
require(stringr)
require(dplyr)

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
behaviour_matrix <- as.matrix(school[["behaviour"]])

behaviour_matrix[behaviour_matrix %in% c(1)] <- 1
behaviour_matrix[behaviour_matrix %in% c(2,3,4)] <- 2
behaviour_matrix[behaviour_matrix %in% c(5,6)] <- 3

smoking <- RSiena::sienaDependent(behaviour_matrix, type = "behavior")

# Constant Covariates over Time
peerselected <- RSiena::coCovar(school[["covar_PoL"]])
gender <- RSiena::coCovar(school[["gender"]], warn=FALSE)

friends <- sienaDependent(school[["friendship"]])

# Load data objects to Siena model
myData <- RSiena::sienaDataCreate(friends, smoking, peerselected, gender, compChange)

myEffects_Network <- RSiena::getEffects(myData)

# Model Specification
myEffects_Network <- setEffect(myEffects_Network, Rate, name = "friends", type = "rate")
myEffects_Network <- includeEffects(myEffects_Network, density, recip, gwespFF, name="friends", type = "eval")
myEffects_Network <- includeEffects(myEffects_Network, linear, name="smoking", type = "eval")

myEffects_Network <- includeEffects(myEffects_Network, egoX, name="friends", interaction1="gender", type = "eval")

myEffects_Network <- includeEffects(myEffects_Network, effFrom, name="smoking", interaction1="gender", type = "eval")

modelOptions <- sienaAlgorithmCreate(MaxDegree=c(friends=6), diagonalize=.2, seed=786840, useStdInits = TRUE, n3 = 100)

effects_info <- as.logical(effects_info)
cond <- which(effects_info)

for (i in seq_along(cond)) {
  if (cond[i] < max(myEffects_Network[, c("effectNumber")])) {
    myEffects_Network[myEffects_Network[, c("effectNumber")] == cond[i], c("fix")] <- TRUE
    myEffects_Network[myEffects_Network[, c("effectNumber")] == cond[i], c("test")] <- TRUE
  }
}


myResults <- RSiena::siena07(modelOptions,
    data = myData,
    effects = myEffects_Network,
    batch=TRUE,
    verbose=FALSE,
    silent=TRUE,
    returnThetas=TRUE,
    nbrNodes = 2, 
    modelName = paste0("${school_period}","_A_"),
    useCluster = TRUE)

# # # ===============================================================================
# 
# modelOptions_conv <- RSiena::sienaAlgorithmCreate(
#     MaxDegree = c(friends = 6),
#     diagonalize = .2,
#     seed = 786840,
#     n3 = 10000,
#     firstg = 0.05
# ) # the seed is for the lab only

# # # ===============================================================================
# myResults <- siena07RunToConvergence(alg=modelOptions_conv,
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

# modelOptions_sim <- RSiena::sienaAlgorithmCreate(
#     MaxDegree = c(friends = 6),
#     diagonalize = .2,
#     seed = 786840,
#     simOnly = TRUE,
#     nsub = 0,
#     n3 = 500
# ) # the seed is for the lab only

# # # ===============================================================================
myResults_sim <- siena07RunSimOnly(alg = modelOptions_sim,
   dat = myData,
   eff = myEffects_Network,
   thetaB=Inf,
   ans0 = myResults,
   modelName = paste0("${school_period}","_A_"),
   batch=TRUE,
   verbose=FALSE,
   silent=TRUE,
   returnThetas=TRUE,
   returnChains=FALSE,
   returnDeps=TRUE,
   status = NULL)


png(filename=paste0("${school_period}","_A_", "gofIndegrees.png"))
gofIndegrees <- sienaGOF(sienaFitObject=myResults_sim, varName="friends", auxiliaryFunction=IndegreeDistribution, cumulative=FALSE, levls=0:6)
plot(gofIndegrees, main = paste0("${school_period}","_A_", "gofIndegrees")) 
dev.off()

# goodness of fit for outdegree distribution:
png(filename=paste0("${school_period}","_A_", "gofOutdegrees.png"))
gofOutdegrees <- sienaGOF(sienaFitObject=myResults_sim, varName="friends", auxiliaryFunction=OutdegreeDistribution, cumulative=FALSE, levls=0:6)
plot(gofOutdegrees, main = paste0("${school_period}","_A_", "gofOutdegrees")) 
dev.off()

# goodness of fit for triad census:
png(filename=paste0("${school_period}","_A_", "gofTriads.png"))
gofTriads <- sienaGOF(sienaFitObject=myResults_sim, varName="friends", auxiliaryFunction=TriadCensus, verbose=TRUE,join=TRUE)
plot(gofTriads, main = paste0("${school_period}","_","_A_", "gofTriads")) 
dev.off()

png(filename=paste0("${school_period}","_A_", "gofEgoAlterTable.png"))
gof.EgoAlterTable <- sienaGOF(myResults_sim,EgoAlterTable,
                              verbose=TRUE,join=TRUE,varName=c("friends","smoking"))
plot(gof.EgoAlterTable, main = paste0("${school_period}","_A_", "gofEgoAlterTable")) 
dev.off()

name <- "smoking" 
zname <- "friends" 
levls <- 1:3

png(filename = paste0("${school_period}","_A_","influenceTable.png" , sep = ""), width = 1000, height = 800) 
zselect <- influenceTable(myResults, myData, zname, name, levls)

# Create sample data
x <- levls

y1 <- zselect |> 
  dplyr::filter(alter == 1) |> 
  dplyr::select(select) |> 
  pull()

y2 <- zselect |> 
  dplyr::filter(alter == 2) |> 
  dplyr::select(select) |> 
  pull()

y3 <- zselect |> 
  dplyr::filter(alter == 3) |> 
  dplyr::select(select) |> 
  pull()

# Create an empty plot
plot(x, y1, type = "n", xlim = c(1, 3), ylim = c(-5, 5), 
     xlab = "X", ylab = "Y", main = paste0("${school_period}","_A_", "Influence Effect Friendship on Smoking"))

# Plot each line one by one
lines(x, y1, type = "l", col = "red")
lines(x, y2, type = "l", col = "blue")
lines(x, y3, type = "l", col = "green")

# Add a legend
legend("topright", legend = c("Smoking Value = 1", "Smoking Value = 2", "Smoking Value = 3"), 
       col = c("red", "blue", "green"), lty = 1, title="Smoking Alter")
graphics.off()

siena.table(myResults, type="tex", file=paste0("${school_period}","_","A.tex"),
            vertLine=TRUE, tstatPrint=FALSE, sig=TRUE, d=3, nfirst=NULL)