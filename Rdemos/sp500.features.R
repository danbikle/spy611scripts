# sp500.features.R
# 2014-4-27
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

rm(list = ls()) # remove any existing list objects

# install the manipulate package to make graphs interactive
install.packages("manipulate")  # This need only be done once
library(manipulate)

# set the working directory to where you place the GSPC.csv data file
setwd("/Users/Robert/Dropbox/Class/Mr Stock Market meet Mr Data Scientist/data")
#read in some price data
sp500 <- read.table(file = "GSPC.csv", header=TRUE, sep=",")
head(sp500)   # show the first few dates from the data showing the column lables
plot(sp500$Close, pch=".")  # since the most recent date is first the plot appears backwards
                            #  showing the high stock market getting lower over time
# i+1 is in the past
# to reverse this so it looks more usual
index <- nrow(sp500):1

# here's price data in left to right chronological starting low and growing
plot(sp500$Close[index], pch=".")  

# Create an interactive plot with a start and size for the data
manipulate(
  plot(sp500$Close[index][x.min: (x.min+x.size)], type = "l", pch="."),  # type l is line
  x.min = slider(0,nrow(sp500), initial = 10000),
  x.size = slider(1,nrow(sp500), initial = 1000)
)

# use attach to not have to write the data frame name over and over
attach(sp500) # now sp500 data.frame is assumed
#plot(Date,Close, pch=".")   # Can plot vs Date but this takes a while. 
                              #  This plots Close (y-axis) vs Date (x-axis)
# Using the past to predict the future.  For each date in the past we create a new data.frame
# of features which includes differences in prices for dates in the past
#  and changes for dates in the future
# We create lags (differences) from today to 2 days ago, 1 week ago, 2 weeks ago, 1 month ago and 2 months ago
# A feature of the 100 day moving average (ma100)
# And features of how the market did (lead) 1 day in the future, 2 days and 1 week

# We are looking at creating this from the S&P500 data.
# There is probably a windowing approach which would be better
#   |<-   6  ->|                                               |<-   100     ->|
#   ----------------------------------------------------------------------------
#   |xxxxxxxxxx|                                               |xxxxxxxxxxxxxxx|
#   ----------------------------------------------------------------------------
#              ^                                               ^
#              |___ Start                                      |___ End
# Not all of the data can be used as our difference calculations would go off the ends of the data
# i.e. for example we cannot look past the last date in our data as it requires dates before the last 
#  value we have
# we need to skip the first 6 days for lead features and the last 100 days for lag features
toSkip <- 106 # total days skipped
zeros <- rep(0.0, nrow(sp500)-toSkip) # generate a zero vectors as placeholders in the data.frame

# create a new vector which is 106 trading days shorter which contains Date, Close 
# and the place holder zero vectors 
isp500 <- data.frame(Date[1:(nrow(sp500)-toSkip)],Close[1:(nrow(sp500)-toSkip)], zeros, zeros, zeros, zeros, zeros, zeros, zeros, zeros, zeros)
# Improve column names
colnames(isp500) <- c("Date", "Close","lag_cp2d","lag_cp1w","lag_cp2w","lag_cp1m","lag_cp2m","ma100","leadcp","leadcp2d","leadcp1w" )
head(isp500) # just to see the column names

# create the lag, moveing average and lead features

# THIS IS A VERY SLOW BRUTE FORCE APPROACH USING A FOR LOOP --- RIPE FOR VECTORIZATION

for(i in 1:(nrow(sp500)-toSkip)){
  isp500[i,3] <- Close[i+6]-Close[i+6+2]
  isp500[i,4] <- Close[i+6]-Close[i+6+5]
  isp500[i,5] <- Close[i+6]-Close[i+6+10]
  isp500[i,6] <- Close[i+6]-Close[i+6+20]
  isp500[i,7] <- Close[i+6]-Close[i+6+40]
  isp500[i,9] <- Close[i+6-1]-Close[i+6]
  isp500[i,10] <- Close[i+6-2]-Close[i+6]
  isp500[i,11] <- Close[i+6-5]-Close[i+6]
  isp500[i,8] <- mean(Close[(i+6):(i+106)])
}


# Next steps:
# Create other features from other examples on slide 7
#  http://www.spy611.com/blog/demo_features
# use this data for traing and validating different machine learning algorithms 
#  as described in slides 9 on



