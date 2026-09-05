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
    output_control <- set_output_saom(returnThetas=returnThetas, returnChains=returnChains)
    
    ans <- siena(control_algo=alg, data=dat, effects=eff, prevAns=ans, thetaBound = thetaB, returnDeps=returnDeps, batch=batch, verbose=verbose, silent=silent, control_out=output_control)

  }
  saveRDS(ans, file = paste0(modelName, "ITER", numr, status,"_SIM.RDS"))
  return(ans)
}
