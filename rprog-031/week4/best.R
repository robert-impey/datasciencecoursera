best <- function(state, outcome)
{
  outcomeData <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  stateData <- outcomeData[outcomeData$State == state,]
  if (nrow(stateData) == 0) 
  {
    stop(sprintf('Error in best("%s", "%s") : invalid state', state, outcome))
  }
  else
  {
    bestForOutcome <- function(outcome, outcomeCol)
    {
      outcome[, outcomeCol] <- as.numeric(outcome[, outcomeCol])
      outcome[outcomeCol,]
      outcome[ order(outcome[,outcomeCol], na.last = TRUE), ][1,2]
    }
    
    if (outcome == "heart attack")
    {
      bestForOutcome(stateData, 11)
    }
    else if(outcome == "heart failure")
    {
      bestForOutcome(stateData, 17)
    }
    else if (outcome == "pneumonia")
    {
      bestForOutcome(stateData, 23)
    }
    else
    {
      stop(sprintf('Error in best("%s", "%s") : invalid outcome', state, outcome))
    }
  }
}