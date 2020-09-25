library(dslabs)
library(tidyverse) # includes readr
library(readxl)

# inspect the first 3 lines
read_lines("murders.csv", n_max = 3)

#read file in CSV format
dat <- read_csv(filename)

# read using full path
dat <- read_csv(fullpath)
head(dat)
class(dat$region)

# Ex:
path <- system.file("extdata", package = "dslabs")
files <- list.files(path)
files


filename <- "murders.csv"
filename1 <- "life-expectancy-and-fertility-two-countries-example.csv"
filename2 <- "fertility-two-countries-example.csv"
dat=read.csv(file.path(path, filename))
dat1=read.csv(file.path(path, filename1))
dat2=read.csv(file.path(path, filename2))


#Examples of copying file to a directory:
# getwd()
# [1] "C:/Users/UNIVERSITY/Documents/Analyses/HarvardX-Wrangling"
# filename <- "murders.csv"
# path <- system.file("extdata", package = "dslabs")

# 1:
setwd("data")
file.copy(file.path(path, filename), getwd())

# 2
file.copy(file.path(path, "murders.csv"), file.path(getwd(), "data"))


# 3
file.location <- file.path(system.file("extdata", package = "dslabs"), "murders.csv")
file.destination <- file.path(getwd(), "data")
file.copy(file.location, file.destination)



#creating a directory 
dir.create("werner")
new_path <- file.path(getwd(), "werner")

new_path



# FUNCTION  FORMAT      TYPICAL SUFFIX
#read_table (white space separated values, txt)
#read_csv (comma separated values, csv)
#read_csv2 (semicolon separated values, csv)
#read_tsv (tab delimited separated values, tsv)
#read_delim (general text file format, must define delimiter, txt)


#read_excel (auto detect the format, xls, slsx)
#read_xls (original format, xls)
#read_xlsx (new format, xlsx)
