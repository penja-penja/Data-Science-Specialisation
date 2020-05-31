# Load data
if(!file.exists('./data/quiz1-data-hid.csv')) {
  hidFileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
  download.file(hidFileUrl, destfile='./data/quiz1-data-hid.csv', method="curl")
}

dataHid <- data.table(read.csv('./data/quiz1-data-hid.csv'))
print(sapply(colnames(dataHid), function(x) strsplit(x, 'wgtp'))[123])

