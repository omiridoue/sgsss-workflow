#!/usr/bin/env Rscript

siena07RunSimOnly <- function(alg, dat, eff, thetaB, ans0, modelName, batch, verbose, silent, returnThetas, returnChains, returnDeps, status, ...)  {
  numr <- 0 
  ans <- siena07(x = alg, data=dat, effects=eff, prevAns=ans0, thetaBound = thetaB, batch=batch, verbose=verbose, silent=silent, returnThetas=returnThetas, returnChains=returnChains, returnDeps=returnDeps) # the first run 
  
  repeat { 
    numr <- numr+1 # count number of repeated runs 
    tm <- ans$tconv.max # convergence indicator 
    
    alg$nsub <- 1
    alg$n2start <- 2 * (sum(eff$include) + 7) * 2.52**4
    if (isTRUE(numr == 1)) {alg$firstg <- alg$firstg/5}

    if (isTRUE(tm < 0.25)) {
      status <- "_CONVERGED"
      break
      }
    if (isTRUE(numr > 19)) {
      status <- "_NOTCONVERGED"
      break
      }
    ans <- siena07(x = alg, data=dat, effects=eff, prevAns=ans, thetaBound = thetaB, batch=batch, verbose=verbose, silent=silent, returnThetas=returnThetas, returnChains=returnChains, returnDeps=returnDeps)
    # success 
    #if (tm > 10) {break} # divergence without much hope of returning to good parameter values 
  } 
  saveRDS(ans, file = paste0(modelName, "ITER", numr, status,"_SIM.RDS"))
  return(ans) 
}