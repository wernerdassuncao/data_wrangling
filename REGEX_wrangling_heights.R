# ^     beginning of the string
# ([4-7])   any digit between 4-7
# \\x*    zero or more of x
# '\\s*   zero or more blank spaces after the '
# (\\d+   one or more digits,
#   \\.?        none or once time(".")
#   \\d*)   zero or more digits
                      
#$    end of the string

pattern <- "^([4-7])\\x*'\\s*(\\d+\\.?\\d*)$"

library(english)

words_to_numbers <- function(s){
  s <- str_to_lower(s)
  for (i in 0:11)
    s <- str_replace_all(s, words(i), as.character(i))
  s
}
words_to_numbers(s)
words(1)
words(10)

