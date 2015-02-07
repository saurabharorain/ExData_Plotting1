
# 
# data<- read.csv("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")
# 
# valid <- na.omit(data)
# 
# plotdata <- subset(valid,as.Date(valid$Date) == as.Date("01/02/2007") | as.Date(valid$Date) == as.Date("02/02/2007"),select=Global_active_power  )
# 
# #subsetwithdt <- cbind(subset,dt=paste(subset$Date,subset$Time))
# 
# #plotdata <- cbind(subsetwithdt,dtf=strptime(subsetwithdt$dt,"%d/%m/%Y %H:%M:%S"))
# 
# hist(plotdata$Global_active_power,xlab="Global Active Power (kilowatts)",col="red",main="Global Active Power")

library("data.table")
data <- fread("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?",select=c("Date","Global_active_power"))

valid <- na.omit(data)

plotdata <- subset(valid,as.Date(valid$Date) == as.Date("01/02/2007") | as.Date(valid$Date) == as.Date("02/02/2007"),select=Global_active_power  )

hist(as.numeric(plotdata$Global_active_power),xlab="Global Active Power (kilowatts)",col="red",main="Global Active Power")

png(filename="plot1.png",width=480,height=480,units="px")
hist(as.numeric(plotdata$Global_active_power),xlab="Global Active Power (kilowatts)",col="red",main="Global Active Power")
dev.off()