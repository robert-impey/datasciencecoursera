make_file_name <- function(directory, id) {
  sprintf("%s/%.3d.csv", directory, id)
}

pollutantmean <- function(directory, pollutant, id = 1:332) {
  readings <- numeric()
  
  for (i in id) {
    file_name <- make_file_name(directory, i)
    
    file_data <- read.csv(file_name, header = TRUE)
    
    file_readings <- if (pollutant == 'sulfate') {
      file_data$sulfate
    } else if(pollutant == 'nitrate') {
      file_data$nitrate
    } else {
      numeric()
    }
    
    for (reading in file_readings) {
      if (!is.na(reading)) {
        readings <- append(readings, reading)  
      }
    }
  }
  
  mean(readings)
}

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
