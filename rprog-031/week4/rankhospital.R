source("lib.R")

rankhospital <- function(state, outcome, num = "best") {
  if (num == "best")
  {
    rankedData <- rank(state, outcome)
    rankedData[1,2]
  }
  else if (num == "worst")
  {
    rankedData <- rank(state, outcome, decreasing = TRUE)
    rankedData[1,2]
  }
  else
  {
    rankedData <- rank(state, outcome)
    if (num > nrow(rankedData))
    {
      NA
    }
    else
    {
      rankedData[num,2]
    }
  }
}