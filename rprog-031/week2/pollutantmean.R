source("make_file_name.R")

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

