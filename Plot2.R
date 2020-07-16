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

# Making plot2
plot(selected.data$DateTime, selected.data$Global_active_power, type="l",
     xlab = " ",
     ylab="Global Active Power (kilowatts)") 

# Saving plot2
dev.copy(png,file = "plot2.png",width = 480, height = 480)
dev.off