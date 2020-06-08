library(dplyr)
source('load_data.R')

# 1. subset data between 2007-02-01 and 2007-02-02
power_consumption$Date <- strptime(power_consumption$Date, format = "%d/%m/%Y")
power_consumption <- subset(power_consumption, Date >= as.POSIXlt('2007-02-01') & Date <= as.POSIXlt('2007-02-02'))

# 2. Draw plot 1
png('plot1.png', width = 480, height = 480)
hist(as.numeric(power_consumption$Global_active_power),
     xlab = 'Global Active Power (kilowatts)', 
     col = 'red',
     main = 'Global Active Power')
dev.off()

