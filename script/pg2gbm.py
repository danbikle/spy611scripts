#!/usr/bin/env python

# ~/spy611/script/pg2gbm.py

# ref:
# http://wiki.postgresql.org/wiki/Using_psycopg2_with_PostgreSQL

# I use this script to study psycopg2.
# I am not sure I will use psycopg2 yet.

import psycopg2
import sys
import pprint
 
def main():
  #Define our connection string
  conn_string = "host='localhost' dbname='madlib' user='madlib' password='madlib'"

  # print the connection string we will use to connect
  print "Connecting to database\n ->%s" % (conn_string)

  # get a connection, if a connect cannot be made an exception will be raised here
  conn = psycopg2.connect(conn_string)

  # conn.cursor will return a cursor object, you can use this cursor to perform queries
  cursor = conn.cursor()
  print "Connected!\n"

  # execute our Query
  cursor.execute("SELECT * FROM y_oos_n1dg")

  # retrieve the records from the database
  records = cursor.fetchall()

  y_oos_n1dg = []
  # try a loop:
  for myrec in records :
    # pprint.pprint(myrec[0])
    y_oos_n1dg.append(myrec[0])

  pprint.pprint(y_oos_n1dg)

  cursor.execute("SELECT * FROM x_oos_n1dg")
  records = cursor.fetchall()
  x_oos_n1dg = []
  for myrec in records :
    mylist = []
    for elmnt in myrec:
      mylist.append(elmnt)
      x_oos_n1dg.append(mylist)
  pprint.pprint(x_oos_n1dg[0])

if __name__ == "__main__":
  main()


