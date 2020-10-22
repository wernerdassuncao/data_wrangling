library(stringr)
library(tidyverse)
not_inches <- function(x, smallest=50,tallest=84){
  inches <- suppressWarnings(as.numeric(x))
  ind <- is.na(inches) | inches < smallest | inches > tallest
  ind
}
length(x)
length(not_inches(x))


s <- c("70","5 ft","4'11","",".","Six feet")
s
pattern <- "\\d|ft" #any numeric character or the text "ft"
str_view_all(s,pattern)

#Question 5

animals <- c('cat','puppy','Moose','MONKEY')
pattern <- "[a-z]"
str_detect(animals,pattern)

#Question 6
pattern <- "[A-Z]$"
str_detect(animals,pattern)

#Question 7
pattern <- "[a-z]{4,5}"
str_detect(animals,pattern)


animals <- c("moose", "monkey", "meerkat", "mountain lion")
animals


#Question 8

str_detect(animals, "mo*") #looks for an “m” followed by zero or more “o” characters.
str_detect(animals, "mo?") #looks for an “m” followed by zero or one “o” characters.
str_detect(animals, "mo+")
str_detect(animals, "moo*")


#Question 9
universities <- c("U. Kentucky","Univ New Hampshire","Univ. of Massachusetts",
                  "University Georgia","U California","California State University")
universities

pattern <- "^Univ\\.?\\s|^U\\.?\\s"
universities %>% str_replace(pattern,"University") %>% 
  str_replace('University of |^University', 'University of ')



#Question 10

problems <- c("5.3", "5,5", "6 1", "5 .11", "5, 12")
pattern_with_groups <- "^([4-7])[,\\.](\\d*)$"
str_replace(problems, pattern_with_groups, "\\1'\\2")
#result:
#[1] "5'3"   "5'5"   "6 1"   "5 .11" "5, 12"


#Question 11

problems <- c("5.3", "5,5", "6 1", "5 .11", "5, 12")
pattern_with_groups <- "^([4-7])[,\\.\\s](\\d*)$"
str_replace(problems, pattern_with_groups, "\\1'\\2")
#output :
#[1] "5'3"   "5'5"   "6'1"   "5 .11" "5, 12"



#Question 12
# In our example, we use the following code to detect height entries that do not match
# our pattern of x’y”:
converted <- problems %>% 
str_replace("feet|foot|ft", "'") %>% 
str_replace("inches|in|''|\"", "") %>% 
str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2")

converted


pattern <- "^[4-7]\\s*'\\s*\\d{1,2}$"
index <- str_detect(converted, pattern)
converted[!index]


# Which answer best describes the differences between the regex string we use as an 
# argument in str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2") and the 
# regex string in pattern <- "^[4-7]\\s*'\\s*\\d{1,2}$"?

#answer:
# The regex used in str_replace() looks for either a comma, period or space between 
# the feet and inches digits, while the pattern regex just looks for an apostrophe; 
# the regex in str_replace allows for none or more digits to be entered as inches, 
# while the pattern regex only allows for one or two digits.



# Question 13
# 
# You notice a few entries that are not being properly converted using your 
# str_replace() and str_detect() code:
  
  
yes <- c("5 feet 7inches", "5 7")
no <- c("5ft 9 inches", "5 ft 9 inches")
s <- c(yes, no)

converted <- s %>% 
  str_replace("\\s*(feet|foot|ft)\\s*", "'") %>% 
  str_replace("\\s*(inches|in|''|\")\\s*", "") %>% 
  str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2")

converted


pattern <- "^[4-7]\\s*'\\s*\\d{1,2}$"
str_detect(converted, pattern)
#[1]  TRUE TRUE FALSE FALSE


# It seems like the problem may be due to spaces around the words feet|foot|ft and 
# inches|in. What is another way you could fix this problem?

converted <- s %>% 
  str_replace("\\s*(feet|foot|ft)\\s*", "'") %>% 
  str_replace("\\s*(inches|in|''|\")\\s*", "") %>% 
  str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2")






