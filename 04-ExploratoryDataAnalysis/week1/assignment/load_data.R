# 1. Download data
if(!file.exists('./data')) {
  # 1.1 create data directory
  dir.create('./data/')
  
  # 1.2 download file
  zipFileUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
  download.file(zipFileUrl, destfile='./data/rawData.zip', method="curl")
  
  # 1.3 unzip files
  unzip('./data/rawData.zip', exdir = './data', unzip = 'internal') 
}

# 2. Read data
power_consumption <- read.table('./data/household_power_consumption.txt', sep = ';', header = TRUE, stringsAsFactors = FALSE)
power_consumption %>% filter_all(any_vars(. %in% '?'))

# 3. Subset data between 2007-02-01 and 2007-02-02
power_consumption$DateTime <- as.POSIXct(paste(power_consumption$Date, power_consumption$Time), format = '%d/%m/%Y %H:%M:%S')
power_consumption <- subset(power_consumption, DateTime >= '2007/2/1' & DateTime < '2007/2/3')

