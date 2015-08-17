source("make_file_name.R")

complete <- function(directory, id = 1:332) {
  complete_ids = numeric()
  complete_nobs = numeric()
  
  for (i in id) {
    file_name <- make_file_name(directory, i)
    
    num_obs = 0
    
    file_data <- read.csv(file_name)
    
    nitrate <- file_data$nitrate
    sulfate <- file_data$sulfate
    
    for (j in seq_along(nitrate)) {
      
      if (is.na(nitrate[j])) {
        #print("nitrate is nan!")
      } 
      else {
        if (is.na(sulfate[j])) {
          #print("sulfate is nan!")
        } else {
          num_obs <- num_obs + 1
        }
      }
    }
    
    complete_ids <- append(complete_ids, i)
    complete_nobs <- append(complete_nobs, num_obs)
  }
  
  data.frame(id = complete_ids, nobs = complete_nobs)
}
