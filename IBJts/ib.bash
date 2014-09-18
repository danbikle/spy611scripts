#!/bin/bash

# ~/spy611scripts/IBJts/ib.bash

# I use this script to start the IB TWS GUI on my laptop:
# Ref:
# https://www.google.com/search?q=Interactive+Brokers+Trader+Workstation

cd ~/spy611scripts/IBJts/

java -cp jts.jar:total.2013.jar -Xmx512M -XX:MaxPermSize=128M jclient.LoginFrame . &

exit
