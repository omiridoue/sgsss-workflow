#!/usr/bin/env Rscript

siena07RunToConvergence <- function(alg, dat, eff, thetaB, ans0, modelName, batch, verbose, silent, returnThetas,  returnChains, returnDeps, status, ...){
  numr <- 0

  repeat {
    
    numr <- numr + 1 ## Count the number of repeated runs
    
    if (isTRUE(numr == 1)) {
      previous_estimation <- ans0
    }
    else {
      previous_estimation <- ans
    }

    saveRDS(previous_estimation, file = paste0(modelName, "ITER", numr,".RDS"))

    alg$n2start <- 2 * (sum(eff$include) + 7) * 2.52**4
    alg$n3 <- alg$n3 * 1.1 + numr * 100

    if (isTRUE(numr == 1)) {alg$firstg <- alg$firstg/5}

     ans <- siena07(x = alg, data = dat, effects = eff, thetaBound = thetaB, prevAns = previous_estimation, batch=batch, verbose=verbose, silent=silent, returnChains=returnChains, returnThetas=returnThetas, returnDeps=returnDeps)

     tconv.max <- ans$tconv.max ## Extract the overall maximum convergence ratio
     tratio.max <- max(abs(ans$tstat[(ans$effects$type != "rate") & (ans$effects$fix == FALSE)])) ## Extract the maximum absolute value of the convergence t-ratios. Don't include the t-ratio for the rate parameter as it is fixed!
    
    saveRDS(ans, file = paste0(modelName, "ITER", numr, status,".RDS"))

    if (isTRUE(tconv.max < 0.25)) { 
      if (isTRUE(tratio.max < 0.11)) { 
        status <- "_CONVERGED"

        saveRDS(ans, file = paste0(modelName, "ITER", numr, status,".RDS"))

        break 
      } 
    } 
    
    if (isTRUE(tconv.max > 100)) { 
      status <- "_NOTCONVERGED"
      
      saveRDS(ans, file = paste0(modelName, "ITER", numr, status,".RDS"))

      break 
    } 
    if (isTRUE(numr > 29)) {
      status <- "_NOTCONVERGED"
      
      saveRDS(ans, file = paste0(modelName, "ITER", numr, status,".RDS"))

      break
    } # now it has lasted too long 
  }
  return(ans)
 }