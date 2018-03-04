##This script reads in the household power consumption data and creates
##a line graph of the 3 sub-meter reading through time.

library(lubridate)
library(dplyr)

setwd("C:/Users/andre/Dropbox/DataScience/Assignments/ExDataAssign1/ExData_Plotting1")

## Read in the data, only looking for our dates
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

## Making plot 3: 3 submeter readings against dates 
        png(file = "plot3.png", width = 480, height = 480)
        par(oma = c(1,1,1,1))
        with(dat, plot(date, submeter1, type = "n",
                       ylab = "Energy sub metering"))
        legend("topright", lty = 1, col = c("black","red","blue"),
               legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
        with(dat,lines(date, submeter1, col = "black"))
        with(dat, lines(date,submeter2, col ="red"))
        with(dat, lines(date,submeter3, col ="blue"))
        
        dev.off()
        
        