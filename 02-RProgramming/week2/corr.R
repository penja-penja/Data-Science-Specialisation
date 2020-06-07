corr <- function(directory, threshold = 0) {
  fileList <- list.files(path = directory, full.names = TRUE)
  result <- c();
  
  for(file in fileList) {
    fileName <- as.character(file)
    cc <- na.omit(read.csv(fileName))

    if (nrow(cc) > threshold) {
      result <- c(result, cor(cc[,2], cc[, 3]))
    }
  }
  
  result
}
