readOutcomeData <- function()
{
  read.csv("outcome-of-care-measures.csv", colClasses = "character")
}

getOutcomeCol <- function(outcome)
{
  if (outcome == "heart attack")
  {
    11
  }
  else if(outcome == "heart failure")
  {
    17
  }
  else if (outcome == "pneumonia")
  {
    23
  }
  else
  {
    NA
  }
}

rank <- function(state, outcome, decreasing = FALSE)
{
  outcomeData <- readOutcomeData()
  
  stateData <- outcomeData[outcomeData$State == state,]
  if (nrow(stateData) == 0) 
  {
    stop(sprintf('Error in best("%s", "%s") : invalid state', state, outcome))
  }
  else
  {
    rankForOutcome <- function(outcome, outcomeCol)
    {
      outcome[, outcomeCol] <- as.numeric(outcome[, outcomeCol])
      outcome[outcomeCol,]
      outcome[ order(outcome[,outcomeCol], outcome[,2], na.last = TRUE, decreasing = decreasing), ]
    }
    
    outComeCol <- getOutcomeCol(outcome)
    if (is.na(outComeCol))
    {
      stop(sprintf('Error in best("%s", "%s") : invalid outcome', state, outcome))
    }
    else
    {
      rankForOutcome(stateData, outComeCol)
    }
  }
}