# Load data
if(!file.exists('./data/quiz2-3-data-gdp.csv')) {
  gdpFileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
  download.file(gdpFileUrl, destfile='./data/quiz2-3-data-gdp.csv', method="curl")
}

dataGdp <- data.table(read.csv('./data/quiz2-3-data-gdp.csv', skip = 4))
dataGdp <- dataGdp[1:190]
dataGdp <- dataGdp[, list(X, X.1, X.3, X.4)]
colnames(dataGdp) <- c('CountryCode', 'Ranking', 'CountryName', 'GDP')

# Quiz 2
dataGdp$GDP <- as.numeric(gsub(',', '', dataGdp$GDP))
meanGdp <- mean(dataGdp$GDP, na.rm = TRUE)
meanGdp

#Quiz 3
grep('^United', dataGdp$CountryName)

# count number of occurence
sapply(dataGdp$CountryName, function(x) grep('^United', x))

