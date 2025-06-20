#!/usr/bin/env Rscript

EgoAlterTable <- function(i, data, sims, wave, groupName, varName, levls=1){
	#unloadNamespace("igraph") # to avoid package clashes
	#require(sna)
	#require(network)
	x <- as.sociomatrix(networkExtraction(i, data, sims, wave, groupName, varName[1]))
	z <- behaviorExtraction(i,data,sims,wave,groupName,varName[2])
	res <- matrix(0,nr=5,nc=5)
	for (ego in 1:5) {
	for (alt in 1:5) {
		thesum <- sum(x[z==ego,z==alt],na.rm=TRUE)
		if (thesum>0) {
			res[ego,alt] <- thesum
		}
	}}
	thenames <- paste('e',col(res),'a',row(res),sep='')
	res <- c(t(res))
	names(res) <- thenames
	return(res)
}