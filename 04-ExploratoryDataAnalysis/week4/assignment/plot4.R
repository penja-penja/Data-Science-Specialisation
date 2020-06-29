# 1. Read and load data into NEI and SCC variables respectively
source('load_data.R')

# 2. Find SCC code with coal combustion-related sources
coalsSCC <- dplyr::filter(SCC, grepl('Coal|coal', EI.Sector))[,1]

# 3. Subset data with SCC matching only coal combustion-related sources
coalNEI <- subset(NEI, SCC %in% coalsSCC)

# 4. Summarize data by year and by type
emissionByYear <- aggregate(x = coalNEI$Emissions, by = list(coalNEI$year), FUN = sum)

# 5. Set graphical layout
png('plot4.png', width = 480, height = 480)
par(mfrow = c(1, 1)) 

# 6. Plot the graph
plot(emissionByYear$Group.1, emissionByYear$x, type = "l", main = "US PM2.5 Emission from Coal Related Sources", xlab = 'Year', ylab = 'Emissions (tons)')
dev.off()