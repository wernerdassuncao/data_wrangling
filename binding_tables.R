library(tidyverse)
library(dslabs)
data(murders)
######################################################
###########     BINDING COLUMNS           ############
######################################################
# The dplyr function bind_cols binds two objects by making them columns in a tibble. 
# For example, we quickly want to make a data frame consisting of numbers we can use.
#bind_cols => data.frame
bind_cols(a = 1:3, b = 4:6)
#another R-base function is CBIND, it can create different types of objects.

#Using bind_cols to bind different data frames.For example, here we break up 
#the tab data frame and then bind them back together:
head(tab)
tab_1 <- tab[, 1:3]
tab_2 <- tab[, 4:6]
tab_3 <- tab[, 7:8]
new_tab <- bind_cols(tab_1, tab_2, tab_3)
new_tab

######################################################
###########        BINDING ROWS           ############
######################################################
#The bind_rows function is similar to bind_cols, but binds rows instead of columns:
tab_1 <- tab[1:2,]
tab_2 <- tab[3:4,]
bind_rows(tab_1, tab_2)

######################################################
###########        SET OPERATORS           ###########


#----------------------------------------------------#
###########       ** INTERSECT  **         ###########
#Take intersections of vectors of any type, 
#such as numeric:
intersect(1:10, 6:15)

#or character:
intersect(letters[1:5], letters[3:7])

#Use dplyr version of intersect:
tab_1 <- tab[1:5,]
tab_2 <- tab[3:7,]
dplyr::intersect(tab_1, tab_2)

#----------------------------------------------------#
###########         ** UNION  **           ###########
#Similarly UNION takes the union of vector. For example:
union(1:10, 6:15)




#BONUS:
name <- "Werner Alencar Advincula Dassuncao"
#splitting the name by characters
name_size <- nchar(name)
first_half <- substring(name, 1, name_size/2-1)
second_half <- substring(name, name_size/2,name_size-1)
append(first_half,second_half, sep="")
#using UNION function with the FIRST_HALF and SECOND_HALF of my name
union(as.factor(first_half), as.factor(second_half))





#splitting the name by words
library(stringi)
word_count <- function (name) {
    str_count(name, " ") + 1 #counts the spaces in between the string + 1
}
#in case there are an odd number of words in a name:
#for 3 it will give the first the 2 first names...
n <- word_count(name)
first_half <- word(name, 1, n/2, sep = fixed(" "))
first_half
second_half <- word(name, n/2+1, n, sep = fixed(" "))
second_half

union(first_half, second_half)



######################################################













