url <- "https://raw.githubusercontent.com/rafalab/dslabs/master/inst/extdata/murders.csv"

#read the file directly from the URL
dat <- read_csv(url)
head(dat)

# to make a local copy of the file
download.file(url, "murders.csv")

# useful functions when downloading files from the internet
# creates a directory with a name that is unlikely not to be unique.
#tempdir()


# creates a character string likely to be a unique filename
#tempfile()

#creates a temporary name for the file
tmp_filename <- tempfile()

#download the file with the random name
download.file(url, tmp_filename)

# read the file in
dat <- read_csv(tmp_filename)

# erase the file
file.remove(tmp_filename)