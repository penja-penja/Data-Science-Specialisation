# 1. Read and load data into NEI and SCC variables respectively
source('load_data.R')

# 2. Find all observations by fips / Baltimore City
baltimoreData <- subset(NEI, NEI$fips == '24510')

# 3. Summarize data by year and by type
emissions <- aggregate(x = baltimoreData$Emissions, by = list(baltimoreData$year, baltimoreData$type), FUN = sum)

colnames(emissions) <- c('Year', 'Type', 'Emission')

# 4. Set graphical layout
png('plot3.png', width = 480, height = 480)
par(mfrow = c(1, 1)) 

# 5. Plot the graph
ggplot(data=emissions,aes(x=Year, y=Emission, col=Type)) + geom_line() + labs(y="Emission (tons)", x = "Year", title = "Balitmore City PM2.5 Emission by Type")
dev.off()