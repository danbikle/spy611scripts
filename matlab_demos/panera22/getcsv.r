# /a/ks/b/matlab/panera22/getcsv.r

# I use this script to copy price data out of IB-API into a CSV file.
# Demo1:
# ~/rdir/bin/R -f getcsv.r SPY USD $mytsu            data/spy_${myts}.csv
# Demo2:
# ~/rdir/bin/R -f getcsv.r SPY USD 20140727 22:35:40 data/SPY_20140727_22_35_40.csv

# Note:
# On ubuntu 14, I installed R with this shell command:
# apt-get install r-base

args = commandArgs()
print(args)
print(args[4])
print(args[5])
print(args[6])
print(args[7])
print(args[8])
mysymbol   = args[4]
mycurrency = args[5]
myday  = args[6]
myhr   = args[7]
myfile = args[8]
my_endDateTime = sprintf("%s %s GMT", myday, myhr)
print(my_endDateTime)

# Now I make use of the IBrokers package.
# Syntax to install it:
# install.packages("IBrokers", lib="rpackages", repos="http://cran.us.r-project.org")
# Once I install it, I see it in a folder named rpackages/

# Next, tell this script where IBrokers resides:
.libPaths("rpackages")

# Now I can use IBrokers R Package:
library(IBrokers)

tws <- twsConnect()
reqCurrentTime(tws)

mytkr = twsContract(symbol=mysymbol,
currency=mycurrency,
exch='SMART',
sectype='STK',
primary='',
expiry='',
strike='0.0',
right='',
local='',
multiplier='',
combo_legs_desc='',
comboleg='',
include_expired='0',
conId=0)

reqHistoricalData(tws,mytkr,
endDateTime = sprintf("%s %s GMT", myday, myhr),
barSize = '30 mins',
duration = '1 M',
useRTH = '0',
whatToShow = 'MIDPOINT',
timeFormat = '1',
file = myfile
)

twsDisconnect(tws)
