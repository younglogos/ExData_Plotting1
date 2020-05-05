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

# Open device
png(file = "./plot3.png",
    width = 480, height = 480)
# Plot figure
par(mfrow = c(1,1), mar = c(4,4,2,1))
with(dataExtra, plot(Date_Time, Sub_metering_1, type = "l",xlab = "", ylab = "Energy sub metering"))
with(dataExtra, lines(Date_Time, Sub_metering_2, type = "l", col = "red"))
with(dataExtra, lines(Date_Time, Sub_metering_3, type = "l", col = "blue"))
legend("topright",  col = c("black", "red", "blue"), lwd = 2, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# Close device
dev.off()
