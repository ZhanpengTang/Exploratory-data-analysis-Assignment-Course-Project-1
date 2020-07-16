# Loading the data
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)
head(data)
names(data)
class(data$Date)
class(data$Time)

# converting the Date and Time variables to Date/Time classses
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
class(data$Date)
head(data$Date)
tail(data$Date)
data$DateTime <- strptime(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")
head(data$DateTime)

# Choosing specific date ("2007-2-1" to "2007-2-2")
selected.data <- data[data$Date >= "2007-2-1" & data$Date <= "2007-2-2",]
str(selected.data)

# Changing the format
change.function <- function(selected.data){
  as.numeric(selected.data)
}
selected.data$Global_active_power <- change.function(selected.data$Global_active_power)
selected.data$Global_reactive_power <- change.function(selected.data$Global_reactive_power)
selected.data$Voltage <- change.function(selected.data$Voltage)
selected.data$Global_intensity <- change.function(selected.data$Global_intensity)
selected.data$Sub_metering_1 <- change.function(selected.data$Sub_metering_1)
selected.data$Sub_metering_2 <- change.function(selected.data$Sub_metering_2)
selected.data$Sub_metering_3 <- change.function(selected.data$Sub_metering_3)

str(selected.data)

# Making plot4

# setting the plot format
par(mfrow=c(2,2))

with(selected.data,{
  # 1st plot
  plot(selected.data$DateTime,selected.data$Global_active_power,type="l", xlab="",
       ylab="Global Active Power") 
  # 2nd plot
  plot(selected.data$DateTime,selected.data$Voltage, type="l",xlab="datetime",ylab="Voltage")
  # 3rd plot
  plot(selected.data$DateTime,selected.data$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  with(selected.data,lines(DateTime,Sub_metering_1))
  with(selected.data,lines(DateTime,Sub_metering_2,col="red"))
  with(selected.data,lines(DateTime,Sub_metering_3,col="blue"))
  legend("topright", lty=1, cex = 0.6,
         col=c("black","red","blue"),
         legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  # 4th plot
  plot(selected.data$DateTime,selected.data$Global_reactive_power,
       type="l",xlab="datetime",ylab="Global_reactive_power")
})

#Saving plot4 to a PNG file
dev.copy(png,file = "plot4.png",width = 480, height = 480)
dev.off