# Download and decompress dataset
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",  "Electric power consumption.zip")
dataFile <- unzip("Electric power consumption.zip")

# Read data
dataTable <- read.table(dataFile, sep = ";", header = T)
dataExtra <- dataTable[dataTable$Date == "1/2/2007" | dataTable$Date == "2/2/2007",]

# Convert date and time variables to date/time classes
Date_Time <- paste(dataExtra$Date, dataExtra$Time)
dataExtra["Date_Time"] <- Date_Time
dataExtra$Date_Time <- strptime(dataExtra$Date_Time, format = "%d/%m/%Y %H:%M:%S")

# Convert the factor classe to numeric class
dataExtra$Global_active_power <- as.character(dataExtra$Global_active_power)
dataExtra$Global_active_power <- as.numeric(dataExtra$Global_active_power)
dataExtra$Sub_metering_1 <- as.numeric(as.character(dataExtra$Sub_metering_1))
dataExtra$Sub_metering_2 <- as.numeric(as.character(dataExtra$Sub_metering_2))
dataExtra$Sub_metering_3 <- as.numeric(as.character(dataExtra$Sub_metering_3))
dataExtra$Voltage <- as.numeric(as.character(dataExtra$Voltage))
dataExtra$Global_reactive_power <- as.numeric(as.character(dataExtra$Global_reactive_power))

# Open device
png(file = "./plot4.png",
    width = 480, height = 480)
par(mfrow = c(2,2), mar = c(4,4,2,1))
# Plot figure
with(dataExtra, plot(Date_Time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power(kilowatts)"))
with(dataExtra, plot(Date_Time, Voltage, type = "l", xlab = "deadtime", ylab = "voltage"))
with(dataExtra, plot(Date_Time, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(dataExtra, lines(Date_Time, Sub_metering_2, type = "l", col = "red"))
with(dataExtra, lines(Date_Time, Sub_metering_3, type = "l", col = "blue"))
legend("topright", col = c("black", "red", "blue"), bty = "n", lwd = 2, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
with(dataExtra, plot(Date_Time, Global_reactive_power, type = "l", xlab = "deadtime", ylab = "Global_reactive_power"))
# Close device
dev.off()