#!/bin/bash

# ~/spy611/script/wget_pricenow.bash


# export TKR=$1
export TKR=SPY
export myts=`date +%Y_%m_%d_%H_%M`

mkdir -p ~/tmp/
cd       ~/tmp/

rm -f ${TKR}.html
wget --output-document=${TKR}.html  http://finance.yahoo.com/q?s=${TKR} 

cp -p ${TKR}.html ${TKR}${myts}.html
ls -la ${TKR}${myts}.html

cd ~/spy611/
bin/rails runner ~/spy611/script/wget_pricenow.rb > /tmp/wget_pricenow.txt
cat /tmp/wget_pricenow.txt

# I want an INSERT like this:
# INSERT INTO mydata (ydate, closing_price) VALUES ('2014-02-12','182.07');

DELETE='DELETE FROM mydata WHERE ydate = '
INSERT='INSERT INTO mydata (ydate, closing_price) VALUES('

TODAY=`date +\'%Y-%m-%d\'`

PRICE=`cat /tmp/wget_pricenow.txt`

echo ${DELETE}${TODAY}             \;  > /tmp/ins_pricenow.sql
echo ${INSERT}${TODAY}','${PRICE}\)\; >> /tmp/ins_pricenow.sql
cat /tmp/ins_pricenow.sql

~/spy611/script/psqlmad.bash -f    /tmp/ins_pricenow.sql

exit
