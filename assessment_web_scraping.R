library(rvest)

url <- "https://web.archive.org/web/20181024132313/http://www.stevetheump.com/Payrolls.htm"
h <- read_html(url)


# We learned that tables in html are associated with the table node.  
# Use the html_nodes() function and the table node type to extract the first table. 
# Store it in an object nodes:
nodes <- html_nodes(h, "table")
length(nodes)

# The html_nodes() function returns a list of objects of class xml_node. 
# We can see the content of each one using, for example, the html_text() function. 
# You can see the content for an arbitrarily picked component like this:
html_text(nodes[[8]])


# If the content of this object is an html table, we can use the html_table() 
# function to convert it to a data frame:
html_table(nodes[[8]])


# Question 1
# Many tables on this page are team payroll tables, with columns for rank, 
# team, and one or more money values.
# Convert the first four tables in nodes to data frames and inspect them.
# Which of the first four nodes are tables of team payroll?
t1 <- html_table(nodes[[1]])
t2 <- html_table(nodes[[2]])
t3 <- html_table(nodes[[3]])
t4 <- html_table(nodes[[4]])
t1 # no
t2 #yes
t3 #yes
t4 #no

#smart way:
sapply(nodes[1:4], html_table)

# Question 2
# For the last 3 components of nodes, which of the following are true? 
#   (Check all correct answers.)
html_table(nodes[length(nodes)-2])
html_table(nodes[length(nodes)-1])
html_table(nodes[length(nodes)])




# Question 3
# Create a table called tab_1 using entry 10 of nodes. Create a table called tab_2 
# using entry 19 of nodes.
# 
# Note that the column names should be c("Team", "Payroll", "Average"). 
# You can see that these column names are actually in the first data row of each table, 
# and that tab_1 has an extra first column No. that should be removed so that 
# the column names for both tables match.
# 
# Remove the extra column in tab_1, remove the first row of each dataset, 
# and change the column names for each table to c("Team", "Payroll", "Average"). 
# Use a full_join() by the Team to combine these two tables.
# 
# How many rows are in the joined data table?
library(tidyverse)  
tab_1 <- html_table(nodes[[10]])
tab_1 <- tab_1 %>% as_tibble()
tab_2 <- html_table(nodes[[19]])
tab_2 <- tab_2 %>% as_tibble()


tab_1 <- tab_1[,2:4]    #remove 1st column also: 
tab_1 <- tab_1[2:31,]   #remove 1st row
tab_2 <- tab_2[2:31,]   #remove 1st row

col_names <- c('Team','Payroll','Average')
names(tab_1)<- col_names
names(tab_2)<- col_names

new_table <- full_join(tab_1, tab_2, by='Team')
new_table

#offical answer:
# tab_1 <- html_table(nodes[[10]])
# tab_2 <- html_table(nodes[[19]])
# col_names <- c("Team", "Payroll", "Average")
# tab_1 <- tab_1[-1, -1]
# tab_2 <- tab_2[-1,]
# names(tab_2) <- col_names
# names(tab_1) <- col_names
# full_join(tab_1,tab_2, by = "Team")


# Question 4 
The Wikipedia page on opinion polling for the Brexit referendum External link, 
in which the United Kingdom voted to leave the European Union in June 2016, 
contains several tables. One table contains the results of all polls regarding 
the referendum over 2016:
Wikipedia table of Brexit poll results in 2016. The name of the first column 
is "Date(s) conducted". There are several other columns, including percentages 
of poll respondents choosing "Remain" or "Leave", the pollster, and the poll type 
(online/telephone).
Use the rvest library to read the HTML from this Wikipedia page 
(make sure to copy both lines of the URL):
  
  
library(rvest)
library(tidyverse)
url<-"https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"  

h <- read_html(url)  
tab <- html_nodes(h, 'table')
length(tab)
tab[1,2]

#official answer also has wrong result!!!
# tab <- read_html(url) %>% html_nodes("table")
# length(tab)


# Question 5
# 
# Inspect the first several html tables using html_table() with the argument
# fill=TRUE (you can read about this argument in the documentation). 
# Find the first table that has 9 columns with the first column named "Date(s) conducted".
# 
# What is the first table number to have 9 columns where the 
# first column is named "Date(s) conducted"?
# length(tab)




tab[[5]] %>% html_table(fill=TRUE) %>% names()













