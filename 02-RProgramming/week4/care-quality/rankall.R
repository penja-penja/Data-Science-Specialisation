rankall <- function(outcome, num = 'best') {
  # Read outcome data
  rawData <- read.csv("outcome-of-care-measures.csv")
  hospitalData <- rawData[, c(2, 7, 11, 17, 23)]
  outcomeName <- gsub(" ", ".", outcome)
  
  ## Check that outcome are valid
  if (length(grep(outcomeName, colnames(hospitalData), ignore.case = TRUE)) == 0) {
    stop(paste('invalid outcome'))
  }
  
  # Find column to be processed by input outcome
  colNum <- grep(outcomeName, colnames(hospitalData), ignore.case = TRUE)
  
  # Get only the hospital name and outcome column
  hospitalData <- hospitalData[, c(1, 2, colNum)]
  
  colnames(hospitalData)<- c("hospital", "state", "rate")
  
  hospitalData <- hospitalData[hospitalData$rate != 'Not Available', ]
  
  hospitalData$rate <- as.numeric(as.character(sub("," , ".", hospitalData$rate)))
  
  # Order the result and give it a rank
  hospitalData <- hospitalData[order(hospitalData[, 2], hospitalData[, 3], hospitalData[, 1]),]
  
  # Add rank to hospital
  hospitalData$rank <- ave(hospitalData$rate, hospitalData$state, FUN = seq_along)
  
  # For each group take the row with column equal to certain rank
  if (num == 'best') {
    hospitalData <- hospitalData %>% group_by(state) %>% filter(row_number() == 1)
  } else if (num == 'worst') {
    hospitalData <- hospitalData %>% group_by(state) %>% filter(row_number() == n())
  } else {
    hospitalData <- hospitalData %>% group_by(state) %>% filter(row_number() == num)
  }
  
  hospitalData
}
