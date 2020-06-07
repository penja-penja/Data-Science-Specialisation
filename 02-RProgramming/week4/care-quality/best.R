best <- function(state, outcome) {
  careData <- read.csv("outcome-of-care-measures.csv", colClasses = "character");
  colNum <- getColNumByOutcome(outcome);
  
  if (is.na(match(state, unique(careData[,7])))) {
    stop(paste('invalid state'));
  }
  
  if (colNum == 0) {
    stop(paste('invalid outcome'));
  }
  
  dataByState <- subset(careData, State == state)
  resultByState <- dataByState[which.min(dataByState[, colNum]),];
  hospitalNames <- resultByState[, 2]
  hospitalNames
}

getColNumByOutcome <- function(illness) {
  colNumber <- 0;
  
  if (illness == 'heart attack') {
    colNumber <- 11
  } else if (illness == 'heart failure') {
    colNumber <- 17
  } else if (illness == 'pneumonia') {
    colNumber <- 23
  }
  
  colNumber;
}

