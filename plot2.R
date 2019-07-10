# Plot 2

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

# Plot 2
png(filename = "plot2.png")
with(hpc_extract, plot(DateTime, Global_active_power, type = "l",
                       xlab = "",
                       ylab = "Global Active Power (kilowatts)"))
dev.off()
