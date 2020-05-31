#install.packages('quantmod')
#library(quantmod)
amzn = getSymbols('AMZN', auto.assign = FALSE)
sampleTimes = index(amzn)

numberOfYears <- data.table(year(sampleTimes))
print(sum(numberOfYears == '2012'))

