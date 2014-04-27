#!/usr/bin/env python

# ~/spy611/script/gbm.py

# This script is called by:
# ~/spy611/script/pred_gbm.bash

# I use this script to create variables from CSV files.
# Then I feed the variables to:
# sklearn.ensemble.GradientBoostingClassifier

import sklearn.ensemble
import numpy

x_is  = numpy.loadtxt('/tmp/x_is.csv', delimiter=',')
x_oos = numpy.loadtxt('/tmp/x_oos.csv', delimiter=',')
          			           
y_is_n1dg  = numpy.loadtxt('/tmp/y_is_n1dg.csv', delimiter=',')
y_is_n2dg  = numpy.loadtxt('/tmp/y_is_n2dg.csv', delimiter=',')
y_is_n1wg  = numpy.loadtxt('/tmp/y_is_n1wg.csv', delimiter=',')
          			           
y_oos_n1dg = numpy.loadtxt('/tmp/y_oos_n1dg.csv', delimiter=',')
y_oos_n2dg = numpy.loadtxt('/tmp/y_oos_n2dg.csv', delimiter=',')
y_oos_n1wg = numpy.loadtxt('/tmp/y_oos_n1wg.csv', delimiter=',')

clf_n1dg = sklearn.ensemble.GradientBoostingClassifier(n_estimators=100, learning_rate=1.0,max_depth=1, random_state=0).fit(x_is,y_is_n1dg)
clf_n2dg = sklearn.ensemble.GradientBoostingClassifier(n_estimators=100, learning_rate=1.0,max_depth=1, random_state=0).fit(x_is,y_is_n2dg)
clf_n1wg = sklearn.ensemble.GradientBoostingClassifier(n_estimators=100, learning_rate=1.0,max_depth=1, random_state=0).fit(x_is,y_is_n1wg)

print('GBM gives me access to a measurement called score.')
print('Here are scores for out of sample data.')
print('Higher scores are better. A score of 1 is perfect:')

print('clf_n1dg.score(x_oos,y_oos_n1dg)) is:')
print(clf_n1dg.score(x_oos,y_oos_n1dg))

print('clf_n2dg.score(x_oos,y_oos_n2dg)) is:')
print(clf_n2dg.score(x_oos,y_oos_n2dg))

print('clf_n1wg.score(x_oos,y_oos_n1wg)) is:')
print(clf_n1wg.score(x_oos,y_oos_n1wg))

# print('clf_n1dg.predict(x_oos)) is:')
# print(clf_n1dg.predict(x_oos))
# 
# print('clf_n2dg.predict(x_oos)) is:')
# print(clf_n2dg.predict(x_oos))
# 
# print('clf_n1wg.predict(x_oos)) is:')
# print(clf_n1wg.predict(x_oos))

# Copy the predictions into tables:
# gbm_predictions_n1dg
# gbm_predictions_n2dg
# gbm_predictions_n1wg

# SQL creation syntax
# CREATE TABLE gbm_predictions_n1dg (pnum INTEGER, prob_willbetrue INTEGER);

import psycopg2
import sys
import pprint

conn_string = "host='localhost' dbname='madlib' user='madlib' password='madlib'"

# print the connection string we will use to connect
print "Connecting to database\n ->%s" % (conn_string)

# get a connection, if a connect cannot be made an exception will be raised here
conn = psycopg2.connect(conn_string)

# conn.cursor will return a cursor object, you can use this cursor to perform queries
cursor = conn.cursor()
print "Connected!\n"

cursor.execute("TRUNCATE TABLE gbm_predictions_n1dg")
cursor.execute("TRUNCATE TABLE gbm_predictions_n2dg")
cursor.execute("TRUNCATE TABLE gbm_predictions_n1wg")

rnum = 0
for prediction in clf_n1dg.predict(x_oos) :
  rnum = rnum + 1
  cursor.execute("INSERT INTO gbm_predictions_n1dg (pnum,prob_willbetrue) values(%s,%s)",(rnum,prediction))
conn.commit()

rnum = 0
for prediction in clf_n2dg.predict(x_oos) :
  rnum = rnum + 1
  cursor.execute("INSERT INTO gbm_predictions_n2dg (pnum,prob_willbetrue) values(%s,%s)",(rnum,prediction))
conn.commit()

rnum = 0
for prediction in clf_n1wg.predict(x_oos) :
  rnum = rnum + 1
  cursor.execute("INSERT INTO gbm_predictions_n1wg (pnum,prob_willbetrue) values(%s,%s)",(rnum,prediction))
conn.commit()

# select * from gbm_predictions_n1dg;
