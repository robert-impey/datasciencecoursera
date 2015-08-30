rank <- function(state, outcome, decreasing = FALSE)
{
  outcomeData <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
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
    
    if (outcome == "heart attack")
    {
      rankForOutcome(stateData, 11)
    }
    else if(outcome == "heart failure")
    {
      rankForOutcome(stateData, 17)
    }
    else if (outcome == "pneumonia")
    {
      rankForOutcome(stateData, 23)
    }
    else
    {
      stop(sprintf('Error in best("%s", "%s") : invalid outcome', state, outcome))
    }
  }
}