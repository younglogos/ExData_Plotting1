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

# Open device
png(file = "./plot2.png",
    width = 480, height = 480)
# Plot figure
with(dataExtra, plot(Date_Time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power(kilowatts)"))
# Close device
dev.off()