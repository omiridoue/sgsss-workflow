#!/usr/bin/env Rscript

sienaRunSimOnly <- function(alg, dat, eff, thetaB, ans0, modelName, batch, verbose, silent, returnThetas, returnChains, returnDeps, status, ...)  {
  numr <- 0 
  ans <- ans0

  repeat { 
    numr <- numr+1 # count number of repeated runs 
    tm <- ans$tconv.max # convergence indicator 
    
    alg$nsub <- 0
    alg$simOnly <- TRUE

    alg$n3 <- 1000
    
    if (isTRUE(tm < 0.25)) {
      status <- "_CONVERGED"
      break
      }
    if (isTRUE(tm > 0.25)) {
      status <- "_NOTCONVERGED"
      break
      }
    ans <- siena(control_algo = alg, data=dat, effects=eff, prevAns=ans, thetaBound = thetaB, batch=batch, verbose=verbose, silent=silent, returnThetas=returnThetas, returnChains=returnChains, returnDeps=returnDeps)
  
  } 
  saveRDS(ans, file = paste0(modelName, "ITER", numr, status,"_SIM.RDS"))
  return(ans) 
}
