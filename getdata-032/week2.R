# Getting and Cleaning Data - Week 2
# 2015-09-19
# Robert Impey

setwd("~")

dataDir <- 'data'

if (!file.exists(dataDir)) {
  dir.create(dataDir)
}

# Q4
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(con)
close(con)

lines <- c(10, 20, 30, 100)

for(line in lines) 
{
  print(nchar(htmlCode[[line]]))
}

# Q5

q5File <- sprintf('%s/getdata%%2Fwksst8110.for', dataDir)

if (!file.exists(q5File)) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
  download.file(fileUrl, destfile = q5File, method = "curl")
}

q5Data <- read.fwf(
  file=q5File,
  skip=4,
  widths=c(12, 7,4, 9,4, 9,4, 9,4))

sumC4 <- sum(q5Data$V4)
sumC9 <- sum(q5Data$V9)

print(sprintf('sumC4 = %f', sumC4))
print(sprintf('sumC9 = %f', sumC9))
print(sprintf('sumC4 + sumC9 = %f', (sumC4 + sumC9)))
