# Assume package - "jpeg" already loaded
if(!file.exists('data-image.jpg')) {
  fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg'
  download.file(fileUrl, destfile='data-image.jpg', method="curl")
}

dataImage <- readJPEG('data-image.jpg', native = TRUE)
quantile(dataImage, probs = c(0.3, 0.8))
