source("make_file_name.R")
source("complete.R")

corr <- function(directory, threshold = 0) {
  complete_obs <- complete(directory)
  
  obs_above_threshold <- complete_obs[complete_obs$nobs > threshold,]
  
  correlations <- numeric()
  for (i in obs_above_threshold$id) {
    file_name <- make_file_name(directory, i)
    
    file_data <- read.csv(file_name, header = TRUE)
    
    nitrate <- file_data$nitrate
    sulfate <- file_data$sulfate
    
    file_corr <- cor(nitrate, sulfate, use = 'complete.obs')
    
    correlations <- append(correlations, file_corr)
  }
  correlations
}
