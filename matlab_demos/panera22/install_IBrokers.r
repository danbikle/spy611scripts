# install_IBrokers.r

# Demo:
# /usr/bin/R -f install_IBrokers.r

# I use this script to install IBrokers into my R env.
# I want IBrokers to reside in a directory called rpackages.
# I dont want IBrokers to reside under /usr/

install.packages("IBrokers", lib="rpackages", repos="http://cran.us.r-project.org")
