# Plot 4

# download file if not already done
if (!file.exists("data.zip")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile = "data.zip", method = "curl")
}

# unzip file if not already done
if (!file.exists("household_power_consumption.txt")) { 
  unzip("data.zip") 
}

# read in data from saved csv file
hpc <- read.table("household_power_consumption.txt", sep = ";", header = TRUE,
                  stringsAsFactors = FALSE, na.strings = "?")

# subset to 2 day period required - 2007-02-01 and 2007-02-02
hpc_extract <- subset(hpc, Date %in% c("1/2/2007", "2/2/2007"))

# Create DateTime field
hpc_extract$DateTime <- paste(hpc_extract$Date, hpc_extract$Time)

# Format Date Only
hpc_extract$Date <- as.Date(hpc_extract$Date, format = "%d/%m/%Y")

# Format DateTime
hpc_extract$DateTime <- strptime(hpc_extract$DateTime, format = "%d/%m/%Y %H:%M:%S")

# Plot 4

png(filename = "plot4.png")
# set layout - 2 x 2 grid filled columnwise
par(mfcol = c(2, 2))

# top left plot - Plot 2 made earlier - ylab altered slightly
with(hpc_extract, plot(DateTime, Global_active_power, type = "l",
                       xlab = "",
                       ylab = "Global Active Power"))

# bottom left plot - Plot 3 made earlier - legend border removed
with(hpc_extract, plot(DateTime, Sub_metering_1, 
                       type = "l", 
                       col = "black",
                       xlab = "",
                       ylab = "Energy sub metering"))
with(hpc_extract, lines(DateTime, Sub_metering_2, col = "red")) 
with(hpc_extract, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1,
       bty = "n")

# top right plot
with(hpc_extract, plot(DateTime, Voltage, 
                       type = "l", 
                       xlab = "datetime",
                       ylab = "Voltage"))

# bottom right plot
with(hpc_extract, plot(DateTime, Global_reactive_power, 
                       type = "l", 
                       xlab = "datetime"))

dev.off()
