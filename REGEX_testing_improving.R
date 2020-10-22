library(stringr)


# function to detect entries with problems
not_inches_or_cm <- function(x, smallest = 50, tallest = 84){
  inches <- suppressWarnings(as.numeric(x))
  ind <- !is.na(inches) &
    ((inches >= smallest & inches <= tallest) |
       (inches/2.54 >= smallest & inches/2.54 <= tallest))
  !ind
}

# identify entries with problems
problems <- reported_heights %>% 
  filter(not_inches_or_cm(height)) %>%
  .$height
length(problems)

converted <- problems %>% 
  str_replace("feet|foot|ft", "'") %>% #convert feet symbols to '
  str_replace("inches|in|''|\"", "") %>%  #remove inches symbols
  str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2") ##change format

# find proportion of entries that fit the pattern after reformatting
pattern <- "^[4-7]\\s*'\\s*\\d{1,2}$"
index <- str_detect(converted, pattern)
mean(index)

converted[!index]    # show problems

############ ADDITIONAL CODING FOR REGEX ##########


# Four clear patterns arise:
#   
#   Many students measuring exactly 5 or 6 feet did not enter any inches, 
#   for example 6', and our pattern requires that inches be included.
# Some students measuring exactly 5 or 6 feet entered just that number.
# Some of the inches were entered with decimal points. For example 5'7.5''. 
# Our pattern only looks for two digits.
# Some entries have spaces at the end, for example 5 ' 9.
# Although not as common, we also see the following problems:
# 
# Some entries are in meters and some of these use European decimals: 1.6, 1,70.
# Two students added cm.
# A student spelled out the numbers: Five foot eight inches.
# It is not necessarily clear that it is worth writing code to handle these 
# last three cases since they might be rare enough. However, some of them 
# provide us with an opportunity to learn a few more regex techniques, 
# so we will build a fix.
# 
# For case 1, if we add a '0 after the first digit, for example, convert all 6 to 6'0, 
# then our previously defined pattern will match. This can be done using groups:

yes <- c("5", "6", "5")
no <- c("5'", "5''", "5'4")
s <- c(yes, no)
str_replace(s, "^([4-7])$", "\\1'0")
#> [1] "5'0" "6'0" "5'0" "5'"  "5''" "5'4"

# The pattern says it has to start (^) with a digit between 4 and 7 and end there ($). 
# The parenthesis defines the group that we pass as \\1 to generate the replacement 
# regex string.
# 
# We can adapt this code slightly to handle the case 2 as well, which covers the 
# entry 5'. Note 5' is left untouched. This is because the extra ' makes the pattern 
# not match since we have to end with a 5 or 6. We want to permit the 5 or 6 to be
# followed by 0 or 1 feet sign. So we can simply add '{0,1} after the ' to do this. 
# However, we can use the none or once special character ?. As we saw above, this is 
# different from * which is none or more. We now see that the fourth case is also 
# converted:
  
str_replace(s, "^([56])'?$", "\\1'0")
#> [1] "5'0" "6'0" "5'0" "5'0" "5''" "5'4"
# Here we only permit 5 and 6, but not 4 and 7. This is because 5 and 6 feet tall 
# is quite common, so we assume those that typed 5 or 6 really meant 60 or 72 inches. 
# However, 4 and 7 feet tall are so rare that, although we accept 84 as a valid entry, 
# we assume 7 was entered in error.
# 
# We can use quantifiers to deal with case 3. These entries are not matched because the 
# inches include decimals and our pattern does not permit this. We need to allow the 
# second group to include decimals not just digits. This means we must permit zero or 
# one period . then zero or more digits. So we will be using both ? and *. Also remember 
# that, for this particular case, the period needs to be escaped since it is a special 
# character (it means any character except line break). Here is a simple example of how 
# we can use *.
# 
# So we can adapt our pattern, currently ^[4-7]\\s*'\\s*\\d{1,2}$ to permit a decimal at 
# the end:

pattern <- "^[4-7]\\s*'\\s*(\\d+\\.?\\d*)$"
# Case 4, meters using commas, we can approach similarly to how we converted the 
# x.y to x'y. A difference is that we require that the first digit be 1 or 2:

yes <- c("1,7", "1, 8", "2, " )
no <- c("5,8", "5,3,2", "1.7")
s <- c(yes, no)
str_replace(s, "^([12])\\s*,\\s*(\\d*)$", "\\1\\.\\2")
#> [1] "1.7"   "1.8"   "2."    "5,8"   "5,3,2" "1.7"
# We will later check if the entries are meters using their numeric values. 
# We will come back to the case study after introducing two widely used functions 
# in string processing that will come in handy when developing our final solution 
# for the self-reported heights.









