moran_decomposition <- function(Trial_raw, Trial_exclPI_raw, Trial_exclPS_raw, Trial_exclBoth_raw, nodes, school_period){
  
  nodes <- nodes
  nodes <- as.numeric(nodes)
  
  school_period <- school_period
  
  Trial_raw <- Trial_raw
  Trial_exclPI_raw  <- Trial_exclPI_raw
  Trial_exclPI_raw  <- Trial_exclPI_raw
  Trial_exclBoth_raw  <- Trial_exclBoth_raw
  
  Trial <- lapply(Trial_raw$sims,function(s){
    net <- network.initialize(n=nodes,directed=TRUE)
    edges <- s$'Data1'$'friends'$'1'[,1:2]
    net <- network.edgelist(edges,net)
    net %v% 'smoking' <- as.numeric(s$'Data1'$'smoking'$'1')
    return(net)
  })
  
  Trial_exclPI  <- lapply(Trial_exclPI_raw$sims,function(s){
    net <- network.initialize(n=nodes,directed=TRUE)
    edges <- s$'Data1'$'friends'$'1'[,1:2]
    net <- network.edgelist(edges,net)
    net %v% 'smoking' <- as.numeric(s$'Data1'$'smoking'$'1')
    return(net)
  })
  
  Trial_exclPS  <- lapply(Trial_exclPS_raw$sims,function(s){
    net <- network.initialize(n=nodes,directed=TRUE)
    edges <- s$'Data1'$'friends'$'1'[,1:2]
    net <- network.edgelist(edges,net)
    net %v% 'smoking' <- as.numeric(s$'Data1'$'smoking'$'1')
    return(net)
  })
  
  Trial_exclBoth <- lapply(Trial_exclBoth_raw$sims,function(s){
    net <- network.initialize(n=nodes,directed=TRUE)
    edges <- s$'Data1'$'friends'$'1'[,1:2]
    net <- network.edgelist(edges,net)
    net %v% 'smoking' <- as.numeric(s$'Data1'$'smoking'$'1')
    return(net)
  })
  
  require(sna)
  
  Moran_Trial <- sapply(Trial,function(s)
    nacf(net=s,y=s%v%"smoking",type='moran',lag.max=1)[2])
  
  Moran_Trial_exclPI <- sapply(Trial_exclPI,function(s)
    nacf(net=s,y=s%v%"smoking",type='moran',lag.max=1)[2])
  
  Moran_Trial_exclPS <- sapply(Trial_exclPS,function(s)
    nacf(net=s,y=s%v%"smoking",type='moran',lag.max=1)[2])
  
  Moran_Trial_exclBoth <- sapply(Trial_exclBoth,function(s)
    nacf(net=s,y=s%v%"smoking",type='moran',lag.max=1)[2])
  
  Mean_Moran_Trial <- mean(Moran_Trial)
  Mean_Moran_Trial_exclPI <- mean(Moran_Trial_exclPI)
  Mean_Moran_Trial_exclPS <- mean(Moran_Trial_exclPS)
  Mean_Moran_Trial_exclBoth <- mean(Moran_Trial_exclBoth)
  
  SD_Moran_Trial <- sd(Moran_Trial)
  SD_Moran_Trial_exclPI <- sd(Moran_Trial_exclPI)
  SD_Moran_Trial_exclPS <- sd(Moran_Trial_exclPS)
  SD_Moran_Trial_exclBoth <- sd(Moran_Trial_exclBoth)
  
  Trial_PS_M=min((mean(Moran_Trial)-mean(Moran_Trial_exclPS)), (mean(Moran_Trial_exclPI)-mean(Moran_Trial_exclBoth)))/mean(Moran_Trial)
  Trial_PI_M=min((mean(Moran_Trial)-mean(Moran_Trial_exclPI)), (mean(Moran_Trial_exclPS)-mean(Moran_Trial_exclBoth)))/mean(Moran_Trial)
  Trial_Undetermined_M=abs(mean(Moran_Trial)-mean(Moran_Trial_exclPS)-mean(Moran_Trial_exclPI)+mean(Moran_Trial_exclBoth))/mean(Moran_Trial)
  Trial_Control_M=mean(Moran_Trial_exclBoth)/mean(Moran_Trial)
  
  Geary_Trial <- sapply(Trial,function(s)
    nacf(net=s,y=s%v%"smoking",type='geary',lag.max=1)[2])
  
  Geary_Trial_exclPI <- sapply(Trial_exclPI,function(s)
    nacf(net=s,y=s%v%"smoking",type='geary',lag.max=1)[2])
  
  Geary_Trial_exclPS <- sapply(Trial_exclPS,function(s)
    nacf(net=s,y=s%v%"smoking",type='geary',lag.max=1)[2])
  
  Geary_Trial_exclBoth <- sapply(Trial_exclBoth,function(s)
    nacf(net=s,y=s%v%"smoking",type='geary',lag.max=1)[2])
  
  Mean_Geary_Trial <- mean(Geary_Trial)
  Mean_Geary_Trial_exclPI <- mean(Geary_Trial_exclPI)
  Mean_Geary_Trial_exclPS <- mean(Geary_Trial_exclPS)
  Mean_Geary_Trial_exclBoth <- mean(Geary_Trial_exclBoth)
  
  SD_Geary_Trial <- sd(Geary_Trial)
  SD_Geary_Trial_exclPI <- sd(Geary_Trial_exclPI)
  SD_Geary_Trial_exclPS <- sd(Geary_Trial_exclPS)
  SD_Geary_Trial_exclBoth <- sd(Geary_Trial_exclBoth)
  # 
  Trial_PS_G=min((mean(Geary_Trial)-mean(Geary_Trial_exclPS)), (mean(Geary_Trial_exclPI)-mean(Geary_Trial_exclBoth)))/mean(Geary_Trial)
  Trial_PI_G=min((mean(Geary_Trial)-mean(Geary_Trial_exclPI)), (mean(Geary_Trial_exclPS)-mean(Geary_Trial_exclBoth)))/mean(Geary_Trial)
  Trial_Undetermined_G=abs(mean(Geary_Trial)-mean(Geary_Trial_exclPS)-mean(Geary_Trial_exclPI)+mean(Geary_Trial_exclBoth))/mean(Geary_Trial)
  Trial_Control_G=mean(Geary_Trial_exclBoth)/mean(Geary_Trial)
  
  varlist <- list(Mean_Moran_Trial, Mean_Moran_Trial_exclPI, Mean_Moran_Trial_exclPS, Mean_Moran_Trial_exclBoth, SD_Moran_Trial, SD_Moran_Trial_exclPI, SD_Moran_Trial_exclPS, SD_Moran_Trial_exclBoth, Trial_PS_M, Trial_PI_M, Trial_Undetermined_M, Trial_Control_M, Mean_Geary_Trial, Mean_Geary_Trial_exclPI, Mean_Geary_Trial_exclPS, Mean_Geary_Trial_exclBoth, SD_Geary_Trial, SD_Geary_Trial_exclPI, SD_Geary_Trial_exclPS, SD_Geary_Trial_exclBoth, Trial_PS_G, Trial_PI_G, Trial_Undetermined_G, Trial_Control_G)
  
  return(varlist)
}