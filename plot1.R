##This script reads in household power consumption data and makes a histogram of second-by-second
##global active power loads on the household between 2007-02-01 and 2007-02-02

library(lubridate)
library(dplyr)

setwd("C:/Users/andre/Dropbox/DataScience/Assignments/ExDataAssign1/ExData_Plotting1")

## Read in the data, only looking for our dates and only reading in these dates
        file.name <- "C:/Users/andre/Dropbox/DataScience/Assignments/ExDataAssign1/data/household_power_consumption.txt"
        skip_begin <- grep("1/2/2007", readLines(file.name))[1] - 1
        coln <- as.vector(read.table(file.name, sep = ";", nrows = 1))
        dat <- read.table(file.name, sep = ";", na.strings = "?",
                          colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric",
                                         "numeric","numeric"),
                          col.names = c("date","time","globalactivepower","globalreactivepower","voltage",
                                        "globalintensity","submeter1","submeter2","submeter3"),
                          skip = skip_begin, nrows = 2*24*60)
        dat <- tbl_df(dat)
        dat <- dat %>% mutate(date = paste(date,time)) %>% mutate(time = NULL)
        dat$date <- dmy_hms(dat$date)
        
## Making plot 1
        png(file = "plot1.png", width = 480, height = 480)
        par(oma = c(1,1,1,1))
        with(dat, hist(globalactivepower, col = "red",main = "Global Active Power",
                       xlab = "Global Active Power (kilowatts)"))
        dev.off()
        
        