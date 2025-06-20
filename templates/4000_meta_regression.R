#!/usr/bin/env Rscript

# Load Data & Dependencies

require(network)
require(sna)
require(RSiena)
require(stringr)

folders <- paste0("${projectDir}","/results/siena_meta/","${period}")
print(folders)

meta_files <- list.files(path = folders, full.names = TRUE, recursive = TRUE)

output <- c()

for (file in meta_files) {
    output[[file]] <- readRDS(file = file)
}

saveRDS(output, file=paste0("${projectDir}","/results/siena_results/","${period}","/siena_effects.RDS"))

school_info <- readRDS(paste0("${projectDir}","/data/trial_info.RDS"))

siena_effects <- output
    
##------------------------------------------------------------------------------
# Check for convergence across all schools
##------------------------------------------------------------------------------
# Check that all went well:
# convergence:
max(sapply(siena_effects, function(x){x\$tconv.max})) # 
# groupnumbers:
sapply(siena_effects, function(x){x\$groupNumber})
#-------------------------------------------------------------------------------
parameters <- sapply(siena_effects, function(x){x\$theta})
standers <- sapply(siena_effects, function(x){x\$se}) 

(eff.names <-
    siena_effects[[1]][["effects"]][siena_effects[[1]][["effects"]][["include"]],'effectName']) 
(eff.names <- eff.names)

#combine parameters and std.errors with effect names
rownames(parameters) <- eff.names
rownames(standers) <- eff.names

# print rounded to 3 decimals
round(parameters,3)
round(standers,3)

ans8 <- siena08(siena_effects, bound=100, maxit=190)

# replacement has length zero
requested_effects  <- names(ans8)
efnames <- names(ans8[c(c(2:11),c(13))])
efnames <- substring(efnames, 8)

Fishers <- t(sapply(c(c(2:11),c(13)),
                    function(i){c(ans8[[i]][["Qstat"]], ans8[[i]][["pttilde"]],ans8[[i]][["cjplus"]], ans8[[i]][["cjminus"]],
                                    ans8[[i]][["cjplusp"]], ans8[[i]][["cjminusp"]], 2*ans8[[i]][["n1"]] )}))

Fishers <- as.data.frame(Fishers)
rownames(Fishers) <- efnames
names(Fishers) <- c('Qstat', 'pttilde','Fplus', 'Fminus', 'pplus', 'pminus', 'df')
#round(Fishers,3)

df<-data.frame(NA,NA,NA,NA,NA,NA,NA)
names(df) <- c('Qstat', 'pttilde','Fplus', 'Fminus', 'pplus', 'pminus', 'df')
rownames(df) <- requested_effects[1]

df1<-data.frame(NA,NA,NA,NA,NA,NA,NA)
names(df1) <- c('Qstat', 'pttilde','Fplus', 'Fminus', 'pplus', 'pminus', 'df')
rownames(df1) <- requested_effects[12]

df2<-data.frame(NA,NA,NA,NA,NA,NA,NA)
names(df2) <- c('Qstat', 'pttilde','Fplus', 'Fminus', 'pplus', 'pminus', 'df')
rownames(df2) <- requested_effects[14]

Fishers <- rbind(df, Fishers)

Fishers <- rbind(Fishers, df1)

Fishers <- rbind(Fishers, df2)

# we make (and save) a dataframe combining club estimates (std. errors) with fisher test statistics
par_standers <- paste(round(parameters, 3), " (", round(standers, 3), ")", sep="")

df <- as.data.frame(matrix(par_standers, nrow=11, ncol=length(siena_effects)))
colnames(df) <- colnames(parameters)
output_fishers <- c()
output_fishers <- cbind(df, round(Fishers, 3))

saveRDS(output_fishers, file=paste0("${projectDir}","/results/siena_results/","${period}","/siena_fishers.RDS"))