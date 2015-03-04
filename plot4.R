# change working directory after storing current wd
old.dir <- getwd()
directory <- 'c:/r_course/EDA/'
setwd(directory)

# open the power consumption file 
# read the header for the column names
colnames <- strsplit(readLines('household_power_consumption.txt',1),';')
# start reading around the beginning of February 2007 and skip the rest
data<-read.csv('household_power_consumption.txt', header=FALSE, sep=';', 
               na.strings='?',skip=6e4, nrows=1e4, col.names=colnames
                 
# convert dates and times
data$DateTime <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# subset the dataset to Feb 1 and 2 2007
selected_days <- (data$Date >= "2007-02-01" & data$Date <="2007-02-02")
data <- subset(data,selected_days)

# create a PNG with four subplots
png(filename = "plot4.png",width = 480, height = 480, units = "px")
par(mfrow=c(2,2))
with(data,{plot(data$DateTime, Global_active_power, type="l",xlab='', ylab='Global Active Power')})
with(data,{plot(data$DateTime, data$Voltage, type="l",xlab='datetime', ylab='Voltage')})
with(data,{plot(data$DateTime, Sub_metering_1, type="l",col="black",xlab='', ylab='Energy sub metering')})
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"))
with(data,{plot(data$DateTime, data$Global_reactive_power, type="l",xlab='datetime', ylab='Global_reactive_power')})

dev.off()