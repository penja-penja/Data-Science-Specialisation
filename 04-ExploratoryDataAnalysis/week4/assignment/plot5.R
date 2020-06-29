# 1. Read and load data into NEI and SCC variables respectively
source('load_data.R')

# 2. Get all data for Baltimore City
baltimoreData <- subset(NEI, NEI$fips == '24510')

# 3. Get SCC code related to Light Vechicle
lightVechicleSCC <- dplyr::filter(SCC, grepl('Mobile - On-Road Gasoline Light Duty Vehicles', EI.Sector))[,1]

# 4. Subset data with SCC matching only coal combustion-related sources
lightVechicleNEI <- subset(baltimoreData, SCC %in% lightVechicleSCC)

# 5. Summarize data by year and by type
emissionByYear <- aggregate(x = lightVechicleNEI$Emissions, by = list(lightVechicleNEI$year), FUN = sum)

# 6. Set graphical layout
png('plot5.png', width = 480, height = 480)
par(mfrow = c(1, 1)) 

# 7. Plot the graph
plot(emissionByYear$Group.1, emissionByYear$x, type = "l", main = "Baltimore City Emissions from Motor Vechicle", xlab = 'Year', ylab = 'Emissions (tons)')
dev.off()
