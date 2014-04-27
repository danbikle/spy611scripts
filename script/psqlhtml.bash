#! /bin/bash

# ~/spy611/script/psqlhtml.bash

# This is a simple wrapper script which connects me to both the madlib schema and database.

PGPASSWORD=madlib psql -Hh 127.0.0.1 -U madlib -d madlib -p 5432 -P pager=no $@

exit
