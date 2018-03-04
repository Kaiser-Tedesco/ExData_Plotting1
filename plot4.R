##This script reads in the household power consumption data for 2007-02-01 to 2007-02-02 and creates
## 4 graphs
##(1) a line graph of global active power consumption through time
##(2) a line graph of voltage use through time
##(3) a line graph of the 3 sub-meter reading through time
##(4) and a line graph of Global reactive power through time

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

## Setting global parameters
        png(file = "plot4.png", width = 480, height = 480)        
        par(mfrow = c(2,2), oma = c(1,1,1,1))

## Making plot 1: global active power against dates  
        
        with(dat, plot(date, globalactivepower, type = "n",
                       ylab = "Global Active Power"))
        with(dat,lines(date, globalactivepower))
        
## Making plot 2: voltage through time
        
        with(dat, plot(date, voltage, type = "n", xlab = "datetime", ylab = "Voltage"))
        with(dat,lines(date, voltage))
        
## Making plot 3: sub-metering through time
        
        with(dat, plot(date, submeter1, type = "n",
               ylab = "Energy sub metering"))
        legend("topright", lty = 1, col = c("black","red","blue"), bty = "n",
                legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
        with(dat,lines(date, submeter1, col = "black"))
        with(dat, lines(date,submeter2, col ="red"))
        with(dat, lines(date,submeter3, col ="blue"))

        
## Making plot 4: Global reactive power through time

        with(dat, plot(date, globalreactivepower, type = "n",
                       xlab = "datetime", ylab = "Global_reactive_power"))
        with(dat,lines(date, globalreactivepower))
        
dev.off()

