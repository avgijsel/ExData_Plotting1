# change working directory after storing current wd
old.dir <- getwd()
directory <- 'c:/r_course/EDA/'
setwd(directory)

# open the power consumption file
data<-read.csv('household_power_consumption.txt', header=FALSE, sep=';', +
  na.strings='?',skip=6e4, nrows=1e4, col.names=c('Date','Time',+
  'Global_active_power','Global_reactive_power','Voltage','Global_intensity',+
  'Sub_metering_1','Sub_metering_2','Sub_metering_3'))
data$DateTime <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# count # of monitors
nIDs<-length(unique(id))
c<-0
bid=numeric(nIDs)
hobs=numeric(nIDs)
for (i in id) {
  c<-c+1
