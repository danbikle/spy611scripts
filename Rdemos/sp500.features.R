# sp500.features.R
# 2014-6-12
# R.Sloan
#
# This R code is deisgned to run in R Studio, development environment for R includes plot screen
#  R Studio is required for interactive graph using library manipulate
#
# Translating to R the ideas of Dan Bikle
# Based on his class Mr Stock Market meet Mr Data Scientist
#  http://www.spy611.com/blog/preso
# Starting with Standards and Poors 500 (S&P500) data downloaded from Yahoo Finance using wget 
#  as described in slide 1 http://www.spy611.com/blog/demo_wget
#  Using the file GSPC.csv this comma separated value file contains S&P500 stock data back 50 years

# This code is to create a feature set as defined in slide 7 http://www.spy611.com/blog/demo_features


# The code is written by James (Xinghai) Hu. It uses the features proposed by Robert Sloan.
# 5/31/2014 
# Robert Sloan slight improvements and save feature file as featuresSP500.Rdata
# Sanjay Patel added Feature sales 'Volume' for SP500
# Zvi Eintracht install only new package

rm(list = ls()) # remove any existing list objects

# install packages as needed. Packages only need to be installed once
#packages <- c("manipulate")
#install.packages(setdiff(packages, rownames(installed.packages())))

library(manipulate)   

# set the working directory to where you place the GSPC.csv data file
setwd("/Users/Robert/Dropbox/Class/Mr Stock Market meet Mr Data Scientist/data")
#read in some price data
sp500 <- read.table(file = "GSPC.csv", header=TRUE, sep=",")
head(sp500)   # show the first few dates from the data showing the column lables

# since the most recent date is first plots of the data would appear backwards
#  showing the high stock market getting lower over time
# i+1 is in the past
# to reverse this so it looks more usual
index <- nrow(sp500):1

# here's price data in left to right chronological starting low and growing
plot(sp500$Close[index], pch=".")  

# Create an interactive plot with a start and size for the data
# manipulate(
#  plot(sp500$Close[index][x.min: (x.min+x.size)], type = "l", pch="."),  # type l is line
#  x.min = slider(0,nrow(sp500), initial = 10000),
#  x.size = slider(1,nrow(sp500), initial = 1000)
#)

# use attach to not have to write the data frame name over and over
attach(sp500) # now sp500 data.frame is assumed
#plot(Date,Close, pch=".")   # Can plot vs Date but this takes a while. 
                              #  This plots Close (y-axis) vs Date (x-axis)
# Using the past to predict the future.  For each date in the past we create a new data.frame
# of features which includes differences in prices for dates in the past
#  and changes for dates in the future
# We create lags (differences) from today to 1 day ago, 2 days ago, 1 week ago, 2 weeks ago, 1 month ago and 2 months ago
# A feature of the 100 day moving average (ma100) and Volume of stock traded
# And features of how the market did (lead) 1 day in the future, 2 days and 1 week

# We are looking at creating this from the S&P500 data.
# There is probably a windowing approach which would be better
#   |<-     100     ->|                                             |<-   6  ->|
#   ----------------------------------------------------------------------------
#   |xxxxxxxxxxxxxxxxx|                                             |xxxxxxxxxx|
#   ----------------------------------------------------------------------------
#                     ^                                             ^
#                     |___ oldest date in file                      |___ most recent date
# Not all of the data can be used as our difference calculations would go off the ends of the data
# i.e. for example we cannot look past the last date in our data as it requires dates before the last 
#  value we have
# we need to skip the first 6 days for lead features and the last 100 days for lag features
toSkip <- 106 # total days skipped
numberOfRows <- nrow(sp500)-toSkip # number of valid data rows

# create a new vector which is 106 trading days shorter which contains Date, Close ...
columnNames <- c("Date", "Close","lag_cp1d","lag_cp2d","lag_cp1w","lag_cp2w","lag_cp1m","lag_cp2m","ma100",
                 "Volume","leadcp","leadcp2d","leadcp1w" )
numberOfColumns <- length(columnNames)
featuresSP500 <- data.frame(matrix(ncol = numberOfColumns, nrow = numberOfRows))  # Create Empty Data Frame
# Add Column Names
colnames(featuresSP500) <- columnNames
featuresSP500$Date <- Date[7:(numberOfRows+6)]
featuresSP500$Close <- Close[7:(numberOfRows+6)]
featuresSP500$Volume <- Volume[7:(numberOfRows+6)]


# create the lag, moving average and lead features

# Rewrite the loop in Robert's code in a matrix/vector format so that it runs faster. Also a minor note: 
# the average of past 100 days should be mean(Close[(i+6):(i+105)]).

featuresSP500[1:(numberOfRows),"lag_cp1d"] <- Close[7:(numberOfRows+6)] - Close[8:(numberOfRows+7)]
featuresSP500[1:(numberOfRows),"lag_cp2d"] <- Close[7:(numberOfRows+6)] - Close[9:(numberOfRows+8)]
featuresSP500[1:(numberOfRows),"lag_cp1w"] <- Close[7:(numberOfRows+6)] - Close[12:(numberOfRows+11)]
featuresSP500[1:(numberOfRows),"lag_cp2w"] <- Close[7:(numberOfRows+6)] - Close[17:(numberOfRows+16)]
featuresSP500[1:(numberOfRows),"lag_cp1m"] <- Close[7:(numberOfRows+6)] - Close[27:(numberOfRows+26)]
featuresSP500[1:(numberOfRows),"lag_cp2m"] <- Close[7:(numberOfRows+6)] - Close[47:(numberOfRows+46)]
featuresSP500[1:(numberOfRows),"leadcp"] <- Close[6:(numberOfRows+5)] - Close[7:(numberOfRows+6)]
featuresSP500[1:(numberOfRows),"leadcp2d"] <- Close[5:(numberOfRows+4)] - Close[7:(numberOfRows+6)]
featuresSP500[1:(numberOfRows),"leadcp1w"] <- Close[2:(numberOfRows+1)] - Close[7:(numberOfRows+6)]

# Calculate moving average
tempavg <- rep(0, (numberOfRows))  # a temporary vector used for computing moving average (average of 100 prices)
tempavg[1] <- sum(Close[7:106])
for (i in 2: length(tempavg) )
{
    tempavg[i] <- tempavg[i-1] - Close[i+5] + Close[i+105]
}
featuresSP500[, "ma100"] <- tempavg/100

#head(featuresSP500)

# standardization of features
write.table(featuresSP500,  file="featuresSP500.csv", sep=",",row.names=FALSE)

