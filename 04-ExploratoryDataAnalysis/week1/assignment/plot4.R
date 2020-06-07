# 1. download data
if(!file.exists('./data')) {
  # 1.1 create data directory
  dir.create('./data/')
  
  # 1.2 download file
  zipFileUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
  download.file(zipFileUrl, destfile='./data/rawData.zip', method="curl")
  
  # 1.3 unzip files
  unzip('./data/rawData.zip', exdir = './data', unzip = 'internal') 
}

# 2. read data
power_consumption <- read.csv2('./data/household_power_consumption.txt', stringsAsFactors = FALSE)

# 3. remove missing data
power_consumption %>% filter_all(any_vars(. %in% '?'))

# 4. subset data between 2007-02-01 and 2007-02-02
power_consumption$DateTime <- as.POSIXct(paste(power_consumption$Date, power_consumption$Time), format = '%d/%m/%Y %H:%M:%S')
power_consumption <- subset(power_consumption, DateTime >= '2007/2/1' & DateTime < '2007/2/3')

# 5. Convert data to correct format
power_consumption$Global_active_power <- as.numeric(power_consumption$Global_active_power)
power_consumption$Voltage <- as.numeric(power_consumption$Voltage)
power_consumption$Sub_metering_1 <- as.numeric(power_consumption$Sub_metering_1)
power_consumption$Sub_metering_2 <- as.numeric(power_consumption$Sub_metering_2)
power_consumption$Sub_metering_3 <- as.numeric(power_consumption$Sub_metering_3)
power_consumption$Global_reactive_power <- as.numeric(power_consumption$Global_reactive_power)

# 5. Set graph layout
png('plot4.png', width = 480, height = 480)
par(mfrow = c(2, 2)) 

# 6. plot c(1,1) - Global active power
plot(power_consumption$DateTime, power_consumption$Global_active_power, type = 'l', xlab = '', ylab = 'Global Active Power')

# 7. plot c(1,2) - Voltage
plot(power_consumption$DateTime, power_consumption$Voltage, type='l', xlab = 'datetime', ylab = 'Voltage')

# 8. plot c(2,1) - Energy sub metering
plot(power_consumption$DateTime, power_consumption$Sub_metering_1, type = 'l', xlab = '', ylab = 'Energy sub metering')
lines(power_consumption$DateTime, power_consumption$Sub_metering_2, type = 'l', col = 'red')
lines(power_consumption$DateTime, power_consumption$Sub_metering_3, type = 'l', col = 'blue')
legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lty = 1, lwd = 2.5, col=c('black', 'red', 'blue'), bty = 'n')

# 9. plot c(2.2)
plot(power_consumption$DateTime, power_consumption$Global_reactive_power, type = 'l', xlab = 'datetime', ylab = 'Global_reactive_power')

dev.off()


