library(tidyverse)

      # A collaborator sends you a file containing data for two years of average race finish times, "times.csv":
      #   
      #   age_group,2015_time,2015_participants,2016_time,2016_participants
      # 20,3:46,54,3:22,62
      # 30,3:50,60,3:43,58
      # 40,4:39,29,3:49,33
      # 50,4:48,10,4:59,14
      # You read in the data file:
      #   
      #   d <- read_csv("times.csv")
      # Which of the answers below best makes the data tidy?
  

filename <- "times.csv"
d <- read_csv("times.csv")

new_d <- gather(d, key = "key", value = "value", -age_group) %>%
  separate(col = key, into = c("year", "variable_name"), sep = "_") %>%
  spread(key = "variable_name", value = "value")
  



#Question 8



        # You are in the process of tidying some data on heights, hand length, and wingspan for basketball 
        # players in the draft. Currently, you have the following:
        #   
        #   > head(stats)
        # key               value
        # allen_height      75
        # allen_hand_length 8.25
        # allen_wingspan	  79.25
        # bamba_height      83.25
        # bamba_hand_length 9.75
        # bamba_wingspan    94
        # 
        # Select all of the correct commands below that would turn this data into a “tidy” format with 
        # columns "height", "hand_length" and "wingspan".


filename <- "stats.csv"
stats <- read_csv(filename)

tidy_stats <- stats %>%
  separate(col = key, into = c("player", "variable_name"), sep = "_", extra = "merge") %>%
  spread(key = variable_name, value = value)

tidy_stats


#question 9
library(tidyverse)
library(dslabs)

    # Examine the built-in dataset co2. 
    # This dataset comes with base R, not dslabs - just type co2 to access the dataset.
    # 
    # Is co2 tidy? Why or why not?
  
head(co2)
# ANSWER:
#   co2 is not tidy: to be tidy we would have to wrangle it to have three columns 
#   (year, month and value), and then each co2 observation would have a row.
# 


co2_wide <- data.frame(matrix(co2, ncol=12,byrow=TRUE))%>%
  setNames(1:12) %>%
  mutate(year = as.character(1959:1997))


# Question 10
#     Use the gather() function to make this dataset tidy. 
#     Call the column with the CO2 measurements co2 and call the month column month. 
#     Name the resulting object co2_tidy.
#     
#     Which code would return the correct tidy format?

tidy_co2 <- co2_wide %>%
  gather(key = month, value = co2, - year)

#or streamlined:

tidy_co2 <- gather(co2_wide, month, co2, -year)
head(tidy_co2)



# Question 11
#   Use co2_tidy to plot CO2 versus month with a different curve for each year:

tidy_co2 %>% ggplot (aes(as.numeric(month), co2, color = year)) + geom_line()
class(tidy_co2$month)

#generating a graph showing the increase in the yearly avg of co2 emissions
#ading a colum yearly average and storing the new data in "average"
average <- tidy_co2 %>%
  group_by(year) %>%
  mutate(year_avg = mean(co2)) %>%
  ungroup()
#plotting the line
average %>% ggplot(aes(as.numeric(year), year_avg)) + geom_line()







#Question 12


    # Load the admissions dataset from dslabs, which contains 
    # college admission information for men and women across six majors, 
    # and remove the applicants percentage column:

library(dslabs)
data(admissions)

dat <- admissions %>% select(-applicants)
    # 
    # Your goal is to get the data in the shape that has one row for each major, like this:
    #   
    #   major  men   women
    # A      62    82		
    # B      63    68		
    # C      37    34		
    # D      33    35		
    # E      28    24		
    # F       6     7	
    # Which command could help you to wrangle the data into the desired format?



dat_tidy <- 
  spread(dat, gender, admitted)



#Question 13

    # Now use the admissions dataset to create the object tmp, which has columns major, 
    # gender, key and value:

tmp <- gather(admissions, key, value, admitted:aplicants)
tmp

    # Combine the key and gender and create a new column called column_name to get 
    # a variable with the following values: 
    #   admitted_men, admitted_women, applicants_men and applicants_women. 
    # Save the new data as tmp2.
    # 
    # Which command could help you to wrangle the data into the desired format?


tmp2 <- unite(tmp, column_name, c(key,gender))

head(tmp)
head(tmp2)

# Explanation
# 
#     unite takes 3 arguments: 
#       (1) the data frame, 
#       (2) the name of the new column to create, and 
#       (3) a vector of the columns to unite with an underscore, in order.



###################################################################


#Question 14
      # 
      # Which function can reshape tmp2 to a table with six rows and five columns 
      # named 
      #   major, 
      #   admitted_men, 
      #   admitted_women, 
      #   applicants_men and 
      #   applicants_women?



test <- spread(tmp2, column_name, value)
test

