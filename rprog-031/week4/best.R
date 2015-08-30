source("lib.R")

best <- function(state, outcome)
{
  rank(state, outcome)[1,2]
}