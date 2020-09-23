#filename defined in "readr_readxl_packages.R"
#read.csv converts strings to factors

dat2 <- read.csv(filename, stringsAsFactors = FALSE)

class(dat2)

class(dat2$abb)
class(dat2$region)




# read.table
# read.csv
# read.delim