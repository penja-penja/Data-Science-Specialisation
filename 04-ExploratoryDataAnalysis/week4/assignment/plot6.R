# 1. Read and load data into NEI and SCC variables respectively
source('load_data.R')

# 2. Get data for Baltimore and Los Angeles
citiesNEI <- subset(NEI, (NEI$fips == '24510' | NEI$fips == '06037'))

# 3. Get SCC code related to Light Vechicle
lightVechicleCC <- dplyr::filter(SCC, grepl('Mobile - On-Road Gasoline Light Duty Vehicles', EI.Sector))[,1]

# 4. Subset data with SCC matching only light vechicle
lightVechicleCitiesNEI <- subset(citiesNEI, SCC %in% lightVechicleSCC)

# 5. Summarize data by year and by fips
emissionByYear <- aggregate(x = lightVechicleCitiesNEI$Emissions, 
                            by = list(lightVechicleCitiesNEI$year,
                            lightVechicleCitiesNEI$fips), FUN = sum)

# 5.1 Provide meaningful column names
colnames(emissionByYear) <- c('Year', 'fips', 'Emission')

# 5.2 Add city name column to table
emissionByYear$CityName <- ifelse(emissionByYear$fips == '24510', 'Baltimore', 'LA')

# 6. Set graphical layout
png('plot6.png', width = 480, height = 480)
par(mfrow = c(1, 1)) 

# 7. Plot the graph
ggplot(data=emissionByYear, aes(x=Year, y=Emission, col=CityName)) + 
       geom_line() + 
       labs(y="Emission", x = "Year", title="Emission PM2.5 Comparison between LA and Batimore")
dev.off()

