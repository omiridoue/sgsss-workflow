#!/usr/bin/env Rscript

siena07RunToConvergence <- function(alg, dat, eff, thetaB, ans0, modelName, batch, verbose, silent, returnThetas,  returnChains, returnDeps, status, nbrNodes, useCluster, initC, clusterType, ...){
  numr <- 0
 
  repeat {
    
    numr <- numr + 1 ## Count the number of repeated runs
    
    if (isTRUE(numr == 1)) {
      previous_estimation <- ans0
    }
    else {
      previous_estimation <- ans
    }

    if (isTRUE(numr == 1)) {
          alg$n2start <- (sum(eff$include) + 7) * 2.52**4
          alg$n3 <- alg$n3 * 1.1 + numr * 500

          alg$firstg <- 0.05

          alg$nsub <- 4

           ans <- siena07(alg = alg, data = dat, effects = eff, thetaBound = thetaB, batch=batch, verbose=verbose, silent=silent, returnChains=returnChains, returnThetas=returnThetas, returnDeps=returnDeps, useCluster=FALSE)
    }
 

          alg$n2start <- 2 * (sum(eff$include) + 7) * 2.52**4
          alg$n3 <- alg$n3 * 1.1 + numr * 10000

          alg$firstg <- 0.001

          alg$nsub <- 1

          eff <- updateTheta(eff, ans) 

           ans <- siena07(alg = alg, data = dat, effects = eff, thetaBound = thetaB, batch=batch, verbose=verbose, silent=silent, returnChains=returnChains, returnThetas=returnThetas, returnDeps=returnDeps, nbrNodes=nbrNodes, useCluster=useCluster,
                    initC = initC, clusterType = clusterType)

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
    if (isTRUE(numr > 100)) {
      status <- "_NOTCONVERGED"
      
      saveRDS(ans, file = paste0(modelName, "ITER", numr, status,".RDS"))

      break
    } # now it has lasted too long 
  }
  return(ans)
 }
