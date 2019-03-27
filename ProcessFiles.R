setwd('/Users/zacharyjohnson/Desktop/Waterhackweek/OtherProjectFiles')

data <- read.csv(paste0(getwd(),'/Stations_Ecuador.csv'),header=T,stringsAsFactors=F)
data$Date <- as.Date(data$Date,format='%m/%d/%Y')
data$H0884[which(data$H0884=='')] <- NA
data$H0884 <- as.numeric(data$H0884)

for(i in 2:ncol(data)){
  dum <- data[,c(1,i)]; colnames(dum) <- c('date','flow')
  dum$date
  write.csv(dum,paste0(getwd(),'/',colnames(data)[i],'.csv'),row.names=F,na='')
}

library(dplyr)
library(lubridate)


data2 <- read.csv(paste0(getwd(),'/Stations_Brazil.csv'),header=T,stringsAsFactors=F)
colnames(data2)[1] <- 'Date'
date.range <- seq(as.Date('1928-01-01'),as.Date('2013-12-31'),by='days')
data_all <- as.data.frame(matrix(NA,nrow=length(date.range),ncol=(ncol(data)+ncol(data2)-1)))
colnames(data_all) <- c(colnames(data),colnames(data2)[-1])
data_all$Date <- date.range
ecu.cols <- 2:ncol(data)
ecu.rows <- which(date.range%in%data$Date)
data_all[ecu.rows,ecu.cols] <- data[,-1] # ecuador sites
braz.cols <- (ncol(data)+1):ncol(data_all)
data_all[,braz.cols] <- data2[(1:length(date.range)),-1] # brazil sites

write.csv(data_all,paste0(getwd(),'/EcuadorBrazilSites.csv'),row.names=F,na='')
