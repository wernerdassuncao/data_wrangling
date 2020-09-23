#see working directory
getwd()

# change your working directory
#setwd() EXAMPLE:::
WD <- getwd()
if (!is.null(WD)) setwd(WD)



#set path to the location for raw data files in the dslabs package and list files
path <- "murders.csv"
fullpath <- file.path(path, filename)
fullpath

#set path to the location for raw data files in the dslabs package and list files
path <- system.file("extdata", package="dslabs")
list.files(path)


#generate a full path to a file
filename <- "murders.csv"
fullpath <- file.path(path, filename)
fullpath


# copy file from dslabs package to your working directory
file.copy(fullpath, getwd())

# check if file exists
file.exists(filename)
