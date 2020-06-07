rankhospital <- function(state, outcome, num = "best") {
  rawData <- read.csv("outcome-of-care-measures.csv");
  hospitalData <- rawData[, c(2, 7, 11, 17, 23)]
  outcomeName <- gsub(" ", ".", outcome)
  
  ## Check that state and outcome are valid
  if (is.na(match(state, unique(hospitalData[,2])))) {
    stop(paste('invalid state'));
  }
  
  if (length(grep(outcomeName, colnames(hospitalData), ignore.case = TRUE)) == 0) {
    stop(paste('invalid outcome'));
  }
  
  ## Return rows with selected state
  dataByState <- subset(hospitalData, State == state)
  
  # Find column to be processed by input outcome
  colNum <- grep(outcomeName, colnames(dataByState), ignore.case = TRUE)
  
  # Get only the hospital name and outcome column
  selectedResult <- dataByState[, c(1, colNum)]
  
  # Rename the column
  colnames(selectedResult)<- c("Hospital name", "Rate")
  
  # Remove any row with unavailable data
  selectedResult <- selectedResult[selectedResult$Rate != 'Not Available', ]

  # Convert character column into decimal
  selectedResult$Rate <- as.numeric(as.character(sub("," , ".", selectedResult$Rate)))
  
  # Order the result and give it a rank
  result <- selectedResult[order(selectedResult[, 2], selectedResult[, 1]),]
  
  # Add rank to hospital
  result$Rank <- seq.int(result$Rate)
  
  if (num == 'best') {
    result <- head(result, 1);
  } else if (num == 'worst') {
    result <- tail(result, 1);
  } else if (num <= nrow(result)) {
    result <- result[result$Rank == num, ];
  } else {
    result <- NA;
  }
  
  result
}
