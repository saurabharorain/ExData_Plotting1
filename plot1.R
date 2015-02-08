#Setup for R 3.1.2 on Ubuntu 14.04 LTS

library("data.table")

if (!file.exists("./household_power_consumption.txt")){
    if (!file.exists("./data.zip")){
        fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileurl,"./data.zip",method="curl")
    }
    unzip("./data.zip")
}

#read only Date and Global active power columns
data <- fread("./household_power_consumption.txt",header=TRUE,sep=";",na.strings="?",select=c("Date","Global_active_power"))

#remove the NA's
valid <- na.omit(data)

start <- as.Date("01/02/2007",format="%d/%m/%Y")
end <- as.Date("02/02/2007",format="%d/%m/%Y")


#Subset out the necessary dates, select only Global_active_power
plotdata <- subset(valid,as.Date(valid$Date,format="%d/%m/%Y") %in% c(start,end),select=Global_active_power)

#open png file
png(filename="plot1.png",width=480,height=480,units="px")

#Create Histogram
hist(as.numeric(plotdata$Global_active_power),xlab="Global Active Power (kilowatts)",col="red",main="Global Active Power")

#close png file.
dev.off()
