# 1. Read and load data into NEI and SCC variables respectively
source('load_data.R')

# 2. Find all observations by fips / Baltimore City
baltimoreData <- subset(NEI, NEI$fips == '24510')

# 3. Summarize data by year
emissionSumByYear <- aggregate(x = baltimoreData$Emissions, by = list(baltimoreData$year), FUN = sum)

# 4. Set graphical layout
png('plot2.png', width = 480, height = 480)
par(mfrow = c(1, 1)) 

# 5. Plot the graph
plot(emissionSumByYear$Group.1, emissionSumByYear$x, type = "l", main = "Total PM2.5 emission from Baltimore", xlab = 'Year', ylab = 'PM2.5 Emission (tons)')
dev.off()