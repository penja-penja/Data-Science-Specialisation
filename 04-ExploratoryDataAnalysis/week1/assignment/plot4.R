source('load_data.R')

# 1. Set graph layout
png('plot4.png', width = 480, height = 480)
par(mfrow = c(2, 2)) 

# 2. plot c(1,1) - Global active power
plot(power_consumption$DateTime, as.numeric(power_consumption$Global_active_power), type = 'l', xlab = '', ylab = 'Global Active Power')

# 3. plot c(1,2) - Voltage
plot(power_consumption$DateTime, as.numeric(power_consumption$Voltage), type='l', xlab = 'datetime', ylab = 'Voltage')

# 4. plot c(2,1) - Energy sub metering
plot(power_consumption$DateTime, as.numeric(power_consumption$Sub_metering_1), type = 'l', xlab = '', ylab = 'Energy sub metering')
lines(power_consumption$DateTime, as.numeric(power_consumption$Sub_metering_2), type = 'l', col = 'red')
lines(power_consumption$DateTime, as.numeric(power_consumption$Sub_metering_3), type = 'l', col = 'blue')
legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lty = 1, lwd = 2.5, col=c('black', 'red', 'blue'), bty = 'n')

# 5. plot c(2.2)
plot(power_consumption$DateTime, as.numeric(power_consumption$Global_reactive_power), type = 'l', xlab = 'datetime', ylab = 'Global_reactive_power')

dev.off()
