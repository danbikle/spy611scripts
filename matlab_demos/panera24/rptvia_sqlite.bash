#!/bin/bash

# /a/ks/b/matlab/panera24/rptvia_sqlite.bash

# I use this script to report via sqlite3.

# ref:
# http://www.sqlite.org/cvstrac/wiki?p=ImportingFiles

sqlite3 data/db.sqlite3 < rptvia_sqlite1.sql > data/sqlitewarnings.txt 2>&1

sqlite3  data/db.sqlite3<<EOF
SELECT COUNT(*) FROM nxt_prdctns;
.quit
EOF
