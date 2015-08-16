pollutantmean <- function(directory, pollutant, id = 1:332) {
  readings <- numeric()
  
  for (i in id) {
    file_name <- sprintf("%s/%.3d.csv", directory, i)
    
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
