complete <- function(directory, id = 1) {
  filenames <- paste(directory, sprintf("%03d.csv", id), sep="/")
  fileList <- data.frame(id, filenames)

  result <- c();
  
  for(row in 1:nrow(fileList)) {
    id <- fileList[row, "id"]
    filename <- as.character(fileList[row, "filenames"])
    
    nobs <- sum(complete.cases(read.csv(filename)))
    result[[row]] <- data.frame(id, nobs)
  }
  
  df <- ldply(result)
}
