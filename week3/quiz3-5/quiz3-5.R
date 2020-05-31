# Load data
if(!file.exists('data-gdp.csv')) {
  gdpFileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
  download.file(gdpFileUrl, destfile='data-gdp.csv', method="curl")
}

if(!file.exists('data-education.csv')) {
  eduFileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'
  download.file(eduFileUrl, destfile='data-education.csv', method="curl")
}

# Read, clean and reshaping data
dataEdu <- data.table(read.csv('data-education.csv'))
dataGdp <- data.table(read.csv('data-gdp.csv', skip = 4))
dataGdp <- dataGdp[, list(X, X.1, X.3, X.4)]
dataGdp <- dataGdp[X != '']
colnames(dataGdp) <- c('CountryCode', 'Ranking', 'CountryName', 'GDP')
dataGdp$Ranking <- as.numeric(as.character(dataGdp$Ranking))

dataMerged <- merge(dataGdp, dataEdu, all = TRUE, by = "CountryCode")

# Quiz 3
matchedIdCount <- sum(!is.na(unique(dataMerged$Ranking)))
print(matchedIdCount)

selectedCountry <- dataMerged[order(Ranking, decreasing = TRUE)][13]
selectedCountry

# Quiz 4
meanRankingAvg <- dataMerged[, mean(Ranking, na.rm = TRUE), by = Income.Group]

# Quiz 5
breakGrp <- quantile(dataMerged$Ranking, probs = seq(0, 1, 0.20), na.rm = TRUE)
dataMerged$quantileGDP <- cut(dataMerged$Ranking, breaks = breakGrp)

