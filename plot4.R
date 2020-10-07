## read data ##

data1<-read.table("household_power_consumption.txt",header = TRUE,sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## check data ##
str(data1)

## change Date to type date 

data1$Date<-as.Date(data1$Date, "%d/%m/%Y")

## check Date class

class(data1$Date)


## subset data so that you have data from the dates 2007-02-01 and 2007-02-02 ##

data1 <- subset(data1,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## remove incomplete cases ##

data1 <- data1[complete.cases(data1),]

## Combine Date and Time column
dateTime <- paste(data1$Date, data1$Time)

## Name the vector
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and Time column
data1 <- data1[ ,!(names(data1) %in% c("Date","Time"))]

## Add DateTime column
data1 <- cbind(dateTime, data1)

## Format dateTime Column
data1$dateTime <- as.POSIXct(dateTime)






## 

plot4<-par(mfrow=c(2,2),mar=c(4,4,2,1),oma=c(0,0,2,0))
with(data1, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
