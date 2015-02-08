
library("data.table")


if (!file.exists("./household_power_consumption.txt")){
    if (!file.exists("./data.zip")){
        fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileurl,"./data.zip",method="curl")
    }
    unzip("./data.zip")
}

#read only Date and required columns
data <- fread("./household_power_consumption.txt",header=TRUE,sep=";",na.strings="?",select=c("Date","Time","Global_active_power"))
a
#remove the NA's
valid <- na.omit(data)

start <- as.Date("01/02/2007",format="%d/%m/%Y")
end <- as.Date("02/02/2007",format="%d/%m/%Y")


#Subset out the necessary dates
plotset <- subset(valid,as.Date(valid$Date,format="%d/%m/%Y") %in% c(start,end))

plotdata <- cbind(plotset,datetime=strptime(paste(plotset$Date,plotset$Time),"%d/%m/%Y %H:%M:%S"))

#open png file
png(filename="plot2.png",width=480,height=480,units="px",bg = "transparent")

#Create graph
plot(x=plotdata$datetime,y=plotdata$Global_active_power,ylab="Global Active Power (kilowatts)",xlab="",type="l")

#close png file.
dev.off()
