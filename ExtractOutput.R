
flowData <- read.csv(paste0(getwd(),'/EcuadorBrazilSites.csv'),header=T,stringsAsFactors=F)
sites <- colnames(flowData)[-1]
# sites <- c('H0718','H0719','H0720') # for test only
nsites <- length(sites)
modMeans <- as.data.frame(matrix(NA,nrow=46,ncol=nsites))
colnames(modMeans) <- sites
for(i in 1:nsites){
  siteName <- sites[i]
  modOut1 <- read.csv(paste0(getwd(),'/',siteName,'_annual_flow_result.csv'),
                     header=T,stringsAsFactors=F,row.names=1)
  modOut1[modOut1=='None'] <- NA; modOut1[modOut1=='nan'] <- NA
  modOut <- as.data.frame(apply(modOut1,2,as.numeric));rownames(modOut) <- rownames(modOut1)
  dumMeans <- apply(modOut,1,mean,na.rm=T)
  modMeans[,i] <- dumMeans
}; rownames(modMeans) <- rownames(modOut)