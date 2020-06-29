# 1. Read and load data into NEI and SCC variables respectively
source('load_data.R')

# 2. Summarize data by year
emissionSumByYear <- aggregate(x = NEI$Emissions, by = list(NEI$year), FUN = sum)

# 3. Set graphical layout
png('plot1.png', width = 480, height = 480)
par(mfrow = c(1, 1)) 

# 4. Plot the graph
plot(emissionSumByYear$Group.1, emissionSumByYear$x, type = "l", main = "Total PM2.5 emission from all sources", xlab = 'Year', ylab = 'PM2.5 Emission (tons)')
dev.off()