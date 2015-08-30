source("lib.R")

rankall <- function(outcome, num = "best") {
  ## Read outcome data
  outcomeData <- readOutcomeData()
  
  ## Check that state and outcome are valid
  outcomeCol <- getOutcomeCol(outcome)
  if (is.na(outcomeCol))
  {
    stop(sprintf('Error in rankall("%s") : invalid outcome', outcome))
  }
  else
  {
    ## For each state, find the hospital of the given rank
    statesData <- split(outcomeData, outcomeData$State)
    numStates <- nrow(statesData)
    decreasing <- (num == 'worst')
    out <- data.frame()
    for (df in statesData)
    {
      df[, outcomeCol] <- as.numeric(df[, outcomeCol])
      df[outcomeCol,]
      df <- df[ order(df[,outcomeCol], df[,2], na.last = TRUE, decreasing = decreasing), ]
      
      if (!is.numeric(num))
      {
        num <- 1
      }
      
      out <- rbind(out,data.frame(state = df[1,7], hospital = df[num, 2]))
    }
    out
  }
}