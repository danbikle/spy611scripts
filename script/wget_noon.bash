#!/bin/bash

# ~/spy611/script/wget_noon.bash

# export TKR=$1
# export TKR=SPY
export TKRH='%5EGSPC'
export TKR='GSPC'
export myts=`date +%Y_%m_%d_%H_%M`

mkdir -p ~/tmp/
cd       ~/tmp/

rm -f ${TKR}.html
wget --output-document=${TKR}.html  http://finance.yahoo.com/q?s=${TKRH} 

# Get rid of the hat in the id-attribute:
sed -i '/yfs_l10_/s/.gspc/xyzgspc/' ${TKR}.html

cp -p ${TKR}.html ${TKR}${myts}.html
ls -la ${TKR}${myts}.html

cd ~/spy611/
~/spy611/bin/rails runner ~/spy611/script/wget_noon.rb > /tmp/wget_noon.sql
cat /tmp/wget_noon.sql

~/spy611/script/psqlmad.bash -f /tmp/wget_noon.sql

exit
