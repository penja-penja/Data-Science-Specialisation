library(dplyr)

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
power_consumption$Date <- strptime(power_consumption$Date, format = "%d/%m/%Y")
power_consumption <- subset(power_consumption, Date >= as.POSIXlt('2007-02-01') & Date <= as.POSIXlt('2007-02-02'))

# 4. Draw plot 1
png('plot1.png', width = 480, height = 480)
hist(as.numeric(power_consumption$Global_active_power),
     xlab = 'Global Active Power (kilowatts)', 
     col = 'red', 
     main = 'Global Active Power')
dev.off()




