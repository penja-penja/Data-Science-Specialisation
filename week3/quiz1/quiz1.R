if(!file.exists('data-ss06hid.csv')) {
  fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
  download.file(fileUrl, destfile='data-ss06hid.csv', method="curl")
}

ss06hidData = read.csv('data-ss06hid.csv')
agricultureLogical <- (ss06hidData$ACR == 3 & ss06hidData$AGS == 6)
which(agricultureLogical)[1:3]
