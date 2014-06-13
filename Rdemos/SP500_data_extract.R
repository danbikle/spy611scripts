# 30 April 2014
# Peter Li
# Robert Sloan - May 3, 2014 modified to download up to current date
#       June 12, 2014 shortened to just get the S&P500 data into file GSPC.csv

rm(list = ls())   # Clean start.  Remove any existing objects.
# install.packages("manipulate") needs to be run once to install manipulate
library(manipulate) # Used to interactivly look at data

# modified to download everything up to the current date 
# url <- 'http://www.quandl.com/api/v1/datasets/YAHOO/INDEX_GSPC.csv?&trim_start=1950-01-03&trim_end=2014-04-29&sort_order=asc'
url <- paste("http://www.quandl.com/api/v1/datasets/YAHOO/INDEX_GSPC.csv?&trim_start=1950-01-03&trim_end=",Sys.Date(),"&sort_order=desc",sep="")
sp500 <- read.csv(url, colClasses = c('Date' = 'Date'))

# set the working directory to where you place the GSPC.csv data file
setwd("/Users/Robert/Dropbox/Class/Mr Stock Market meet Mr Data Scientist/data")

# Write the file
write.table(sp500,  file="GSPC.csv", sep=",",row.names=FALSE)

# optionally create an interactive plot of the S&P500 data
manipulate(
  plot(sp500$Close[x.min:(x.min + x.size)], type = "l", pch = "."),
  x.min = slider(0,nrow(sp500), initial = 10000),
  x.size = slider(1,nrow(sp500), initial = 1000)
)

