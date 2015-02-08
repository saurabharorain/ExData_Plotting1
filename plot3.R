
library("data.table")

if (!file.exists("./household_power_consumption.txt")){
    if (!file.exists("./data.zip")){
        fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileurl,"./data.zip",method="curl")
    }
    unzip("./data.zip")
}

#read only Date and required columns
data <- fread("./household_power_consumption.txt",header=TRUE,sep=";",na.strings="?",select=c("Date","Time","Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#remove the NA's
valid <- na.omit(data)

start <- as.Date("01/02/2007",format="%d/%m/%Y")
end <- as.Date("02/02/2007",format="%d/%m/%Y")


#Subset out the necessary dates
plotset <- subset(valid,as.Date(valid$Date,format="%d/%m/%Y") %in% c(start,end))

plotdata <- cbind(plotset,datetime=strptime(paste(plotset$Date,plotset$Time),"%d/%m/%Y %H:%M:%S"))

#open png file
png(filename="plot3.png",width=480,height=480,units="px")

#Create plot
plot(x=plotdata$datetime,plotdata$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(plotdata$datetime,plotdata$Sub_metering_2,col="red",type="l")
lines(plotdata$datetime,plotdata$Sub_metering_3,col="blue",type="l")
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1)
#close png file.
dev.off()
