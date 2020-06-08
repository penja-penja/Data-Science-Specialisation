source('load_data.R')

# 3. convert data
#power_consumption$Global_active_power <- as.numeric(power_consumption$Global_active_power)
  
# 4. Draw plot 2
png('plot2.png')
plot(power_consumption$DateTime, 
     as.numeric(power_consumption$Global_active_power), 
     type = 'l', 
     xlab = '', 
     ylab = 'Global Active Power (kilowatts)')
dev.off()

