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

# 5. convert data
power_consumption$Global_active_power <- as.numeric(power_consumption$Global_active_power)
  
# 6. Draw plot 2
png('plot2.png')
plot(power_consumption$DateTime, power_consumption$Global_active_power, type='l', xlab='', ylab = 'Global Active Power (kilowatts)')
dev.off()


