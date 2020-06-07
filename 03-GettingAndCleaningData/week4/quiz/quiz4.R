# Load data
if(!file.exists('./data/quiz4-data-gdp.csv')) {
  gdpFileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
  download.file(gdpFileUrl, destfile='./data/quiz4-data-gdp.csv', method="curl")
}

if(!file.exists('./data/quiz4-data-education.csv')) {
  eduFileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'
  download.file(eduFileUrl, destfile='./data/quiz4-data-education.csv', method="curl")
}

# Read, clean and reshaping data
dataEdu <- data.table(read.csv('./data/quiz4-data-education.csv'))
dataEdu <- dataEdu[Special.Notes != '']
dataGdp <- data.table(read.csv('./data/quiz4-data-gdp.csv', skip = 4))
dataGdp <- dataGdp[, list(X, X.1, X.3, X.4)]
dataGdp <- dataGdp[X != '']
colnames(dataGdp) <- c('CountryCode', 'Ranking', 'CountryName', 'GDP')

mergeTable <- merge(dataGdp, dataEdu, by = 'CountryCode')
result <- data.table(lapply(mergeTable$Special.Notes, function(x) grepl('^Fiscal year end: June+', x)))
print(sum(result == TRUE))




