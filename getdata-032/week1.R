# Getting and Cleaning Data - Week 1
# RFI 2015-09-13

setwd("~")

dataDir <- 'data'

if (!file.exists(dataDir)) {
  dir.create(dataDir)
}

# Question 1
idahoPropertiesFile <- sprintf("%s/idahoProperties.csv", dataDir)

if (!file.exists(idahoPropertiesFile)) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
  download.file(fileUrl, destfile = idahoPropertiesFile, method = "curl")
}

idahoPropertiesData <- read.csv(idahoPropertiesFile)

millionPlusPropertyValueKey <- 24
numberMillionPlusProperties <- nrow(idahoPropertiesData[(!is.na(idahoPropertiesData$VAL) & idahoPropertiesData$VAL == millionPlusPropertyValueKey),])

print(sprintf("Number of properties with a value of 1M USD or more: %d", numberMillionPlusProperties))

# Question 3

library(xlsx)

ngapFile <- sprintf("%s/ngap.xlsx", dataDir)

if (!file.exists(ngapFile)) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
  download.file(fileUrl, destfile = ngapFile, method = "curl")
}

colIndex <- 7:15
rowIndex <- 18:23
dat <- read.xlsx(ngapFile,sheetIndex=1,header=TRUE,colIndex=colIndex,rowIndex = rowIndex)

print(sum(dat$Zip*dat$Ext,na.rm=T))

# Question 4

library(XML)

restaurantsFile =  sprintf("%s/BaltimoreRestaurants.xml", dataDir)

if (!file.exists(restaurantsFile)) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
  download.file(fileUrl, destfile = restaurantsFile, method = "curl")
}

restaurantsDoc <- xmlTreeParse(restaurantsFile,useInternal=TRUE)
zipCode = 21231
xPath = sprintf("//zipcode[text()='%d']", zipCode)
numberOfRestaurantsInZipCode <- length(xpathSApply(restaurantsDoc, xPath, xmlValue))

print(sprintf("There are %d restaurants in %d", numberOfRestaurantsInZipCode, zipCode))

# Question 5

idahoCommunitiesFile = sprintf("%s/idahoCommunities.csv", dataDir)

if (!file.exists(idahoCommunitiesFile)) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
  download.file(fileUrl, destfile = idahoCommunitiesFile, method = "curl")
}

DT <- read.csv(idahoCommunitiesFile, header = TRUE)

print(tapply(DT$pwgtp15,DT$SEX,mean))
print(sapply(split(DT$pwgtp15,DT$SEX),mean))
print(mean(DT$pwgtp15,by=DT$SEX))
print(mean(DT[DT$SEX==1,]$pwgtp15))
print(mean(DT[DT$SEX==2,]$pwgtp15))

print(system.time(tapply(DT$pwgtp15,DT$SEX,mean)))
print(system.time(sapply(split(DT$pwgtp15,DT$SEX),mean)))
print(system.time(mean(DT$pwgtp15,by=DT$SEX)))
print(system.time(mean(DT[DT$SEX==1,]$pwgtp15)))
print(system.time(mean(DT[DT$SEX==2,]$pwgtp15)))

