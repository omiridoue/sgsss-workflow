moran_decomposition <- function(School_raw, School_exclPI_raw, School_exclPS_raw, School_exclBoth_raw, nodes, school_period){
  
  nodes <- nodes
  nodes <- as.numeric(nodes)
  
  school_period <- school_period
  
  School_raw <- School_raw
  School_exclPI_raw  <- School_exclPI_raw
  School_exclPI_raw  <- School_exclPI_raw
  School_exclBoth_raw  <- School_exclBoth_raw
  
  School <- lapply(School_raw$sims,function(s){
    net <- network.initialize(n=nodes,directed=TRUE)
    edges <- s$'Data1'$'friends'$'1'[,1:2]
    net <- network.edgelist(edges,net)
    net %v% 'smoking' <- as.numeric(s$'Data1'$'smoking'$'1')
    return(net)
  })
  
  School_exclPI  <- lapply(School_exclPI_raw$sims,function(s){
    net <- network.initialize(n=nodes,directed=TRUE)
    edges <- s$'Data1'$'friends'$'1'[,1:2]
    net <- network.edgelist(edges,net)
    net %v% 'smoking' <- as.numeric(s$'Data1'$'smoking'$'1')
    return(net)
  })
  
  School_exclPS  <- lapply(School_exclPS_raw$sims,function(s){
    net <- network.initialize(n=nodes,directed=TRUE)
    edges <- s$'Data1'$'friends'$'1'[,1:2]
    net <- network.edgelist(edges,net)
    net %v% 'smoking' <- as.numeric(s$'Data1'$'smoking'$'1')
    return(net)
  })
  
  School_exclBoth <- lapply(School_exclBoth_raw$sims,function(s){
    net <- network.initialize(n=nodes,directed=TRUE)
    edges <- s$'Data1'$'friends'$'1'[,1:2]
    net <- network.edgelist(edges,net)
    net %v% 'smoking' <- as.numeric(s$'Data1'$'smoking'$'1')
    return(net)
  })
  
  require(sna)
  
  Moran_School <- sapply(School,function(s)
    nacf(net=s,y=s%v%"smoking",type='moran',lag.max=1)[2])
  
  Moran_School_exclPI <- sapply(School_exclPI,function(s)
    nacf(net=s,y=s%v%"smoking",type='moran',lag.max=1)[2])
  
  Moran_School_exclPS <- sapply(School_exclPS,function(s)
    nacf(net=s,y=s%v%"smoking",type='moran',lag.max=1)[2])
  
  Moran_School_exclBoth <- sapply(School_exclBoth,function(s)
    nacf(net=s,y=s%v%"smoking",type='moran',lag.max=1)[2])
  
  Mean_Moran_School <- mean(Moran_School)
  Mean_Moran_School_exclPI <- mean(Moran_School_exclPI)
  Mean_Moran_School_exclPS <- mean(Moran_School_exclPS)
  Mean_Moran_School_exclBoth <- mean(Moran_School_exclBoth)
  
  SD_Moran_School <- sd(Moran_School)
  SD_Moran_School_exclPI <- sd(Moran_School_exclPI)
  SD_Moran_School_exclPS <- sd(Moran_School_exclPS)
  SD_Moran_School_exclBoth <- sd(Moran_School_exclBoth)
  
  School_PS_M=min((mean(Moran_School)-mean(Moran_School_exclPS)), (mean(Moran_School_exclPI)-mean(Moran_School_exclBoth)))/mean(Moran_School)
  School_PI_M=min((mean(Moran_School)-mean(Moran_School_exclPI)), (mean(Moran_School_exclPS)-mean(Moran_School_exclBoth)))/mean(Moran_School)
  School_Undetermined_M=abs(mean(Moran_School)-mean(Moran_School_exclPS)-mean(Moran_School_exclPI)+mean(Moran_School_exclBoth))/mean(Moran_School)
  School_Control_M=mean(Moran_School_exclBoth)/mean(Moran_School)
  
  Geary_School <- sapply(School,function(s)
    nacf(net=s,y=s%v%"smoking",type='geary',lag.max=1)[2])
  
  Geary_School_exclPI <- sapply(School_exclPI,function(s)
    nacf(net=s,y=s%v%"smoking",type='geary',lag.max=1)[2])
  
  Geary_School_exclPS <- sapply(School_exclPS,function(s)
    nacf(net=s,y=s%v%"smoking",type='geary',lag.max=1)[2])
  
  Geary_School_exclBoth <- sapply(School_exclBoth,function(s)
    nacf(net=s,y=s%v%"smoking",type='geary',lag.max=1)[2])
  
  Mean_Geary_School <- mean(Geary_School)
  Mean_Geary_School_exclPI <- mean(Geary_School_exclPI)
  Mean_Geary_School_exclPS <- mean(Geary_School_exclPS)
  Mean_Geary_School_exclBoth <- mean(Geary_School_exclBoth)
  
  SD_Geary_School <- sd(Geary_School)
  SD_Geary_School_exclPI <- sd(Geary_School_exclPI)
  SD_Geary_School_exclPS <- sd(Geary_School_exclPS)
  SD_Geary_School_exclBoth <- sd(Geary_School_exclBoth)
  # 
  School_PS_G=min((mean(Geary_School)-mean(Geary_School_exclPS)), (mean(Geary_School_exclPI)-mean(Geary_School_exclBoth)))/mean(Geary_School)
  School_PI_G=min((mean(Geary_School)-mean(Geary_School_exclPI)), (mean(Geary_School_exclPS)-mean(Geary_School_exclBoth)))/mean(Geary_School)
  School_Undetermined_G=abs(mean(Geary_School)-mean(Geary_School_exclPS)-mean(Geary_School_exclPI)+mean(Geary_School_exclBoth))/mean(Geary_School)
  School_Control_G=mean(Geary_School_exclBoth)/mean(Geary_School)
  
  varlist <- list(Mean_Moran_School, Mean_Moran_School_exclPI, Mean_Moran_School_exclPS, Mean_Moran_School_exclBoth, SD_Moran_School, SD_Moran_School_exclPI, SD_Moran_School_exclPS, SD_Moran_School_exclBoth, School_PS_M, School_PI_M, School_Undetermined_M, School_Control_M, Mean_Geary_School, Mean_Geary_School_exclPI, Mean_Geary_School_exclPS, Mean_Geary_School_exclBoth, SD_Geary_School, SD_Geary_School_exclPI, SD_Geary_School_exclPS, SD_Geary_School_exclBoth, School_PS_G, School_PI_G, School_Undetermined_G, School_Control_G)
  
  return(varlist)
}