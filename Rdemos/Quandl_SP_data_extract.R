# 30 April 2014
# Peter Li
# Robert Sloan May 3, 2014 modified to download up to current date
# PL 11 May 2014: S&P 500 tweaks; lags and leads to reflect trading sessions; lapply() code

rm(list = ls())

library(manipulate)  # RStudio specific code

# This is the earliest date in Yahoo data
start.date <- "1950-01-03"

# Sent end date as current date (R. Sloan)
end.date <- Sys.Date()

# To set a custom end date 
# end.date <- "2014-01-31"

# N.B. Default URL from website sorts descending, "desc", switched to "asc"
url <- paste0(
   "http://www.quandl.com/api/v1/datasets/YAHOO/INDEX_GSPC.csv?&trim_start=", 
   start.date, "&trim_end=", end.date, "&sort_order=asc")

sp500 <- read.csv(url, colClasses = c("Date" = "Date"))

## Graphs

plot(sp500$Date, sp500$Close, type = "l")

# RStudio specific code
manipulate(
  plot(sp500$Close[x.min:(x.min + x.size)], type = "l", pch = "."),
  x.min = slider(0,nrow(sp500), initial = 10000),
  x.size = slider(1,nrow(sp500), initial = 1000)
)

## Lags, Leads and Moving Avg Window Parameters ##

# calendar days
# lag.days <- c(2, 7, 14, 30, 60)
# lead.days <- c(1, 2, 7)

# trading sessions (Bikle approximations)
lag.days <- c(2, 5, 10, 20, 40)
lead.days <- c(1, 2, 5)
moving.avg.days <- 100

close.id <- "Close"

sp500$idx <- 1:nrow(sp500)
first.obs <- sp500[1, "idx"] + max(c(lag.days, moving.avg.days))
last.obs <- sp500[nrow(sp500), "idx"] - max(lead.days)

## Data ##

# Subset for "complete" obs. lags, leads and moving avg.
sp <- sp500[sp500$idx >= first.obs & sp500$idx <= last.obs, ]
var.names <- c("lag_cp2d", "lag_cp1w", "lag_cp2w", "lag_cp1m", "lag_cp2m", 
  "ma100", "leadcp", "leadcp2d", "leadcp1w")

# ----------------------- For Loop version ----------------------- #

# appox 90 seconds #

output <- data.frame(matrix(0, nrow(sp), length(var.names)))

for (i in seq_along(sp$Date)) {
  lag.close <- sp500[sp500$idx %in% (sp[i, "idx"] - lag.days), close.id]
  ma.window <- (sp[i, "idx"] - moving.avg.days):(sp[i, "idx"] - 1)
  ma.100 <- mean(sp500[ma.window, close.id])
  lead.close <- sp500[sp500$idx %in% (sp[i, "idx"] + lead.days), close.id]
  output[i, ] <- c(lag.close, ma.100, lead.close)
}

names(output) <- var.names
isp500 <- cbind(sp[-ncol(sp)], output)


# ----------------------- lapply() version ----------------------- #

output <- lapply(seq_along(sp$Date), function(i) {
  lag.close <- sp500[sp500$idx %in% (sp[i, "idx"] - lag.days), close.id]
  ma.window <- (sp[i, "idx"] - moving.avg.days):(sp[i, "idx"] - 1)
  ma.100 <- mean(sp500[ma.window, close.id])
  lead.close <- sp500[sp500$idx %in% (sp[i, "idx"] + lead.days), close.id]
  c(lag.close, ma.100, lead.close)
})

output <- do.call("rbind", output)
colnames(output) <- var.names
isp500 <- cbind(sp[-ncol(sp)], output)


# ----------------------- mclapply() version ----------------------- #

# appox 40 seconds #


## Embarrassingly Parallel Problem #
# N.B. mclapply() w/ more than 1 core should only be run in terminal (not GUI)
# N.B. mclapply() w/ more than 1 core will not work in Windows
# When set to 1 core, essentially lapply()

library(parallel)
cores <- 1L  

output <- mclapply(seq_along(sp$Date), function(i) {
  lag.close <- sp500[sp500$idx %in% (sp[i, "idx"] - lag.days), close.id]
  ma.window <- (sp[i, "idx"] - moving.avg.days):(sp[i, "idx"] - 1)
  ma.100 <- mean(sp500[ma.window, close.id])
  lead.close <- sp500[sp500$idx %in% (sp[i, "idx"] + lead.days), close.id]
  c(lag.close, ma.100, lead.close)
}, mc.cores = cores)

output <- do.call("rbind", output)
colnames(output) <- var.names
isp500 <- cbind(sp[-ncol(sp)], output)

