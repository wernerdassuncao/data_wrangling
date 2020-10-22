df1 <- data.frame('x' = c('a','a'), 'y' = c('b','a'))

df2 <- data.frame('x' = c('a','a'), 'y' = c('a','b'))

setdiff(df1,df2)



library(Lahman)
# Batting df with offensive statistics for all baseball player over several seasons
top <- Batting %>%
  filter(yearID==2016) %>%
  arrange(desc(HR)) %>%     #arrange by descending HR count
  slice(1:10)         #take entries 1-10

top %>% as_tibble()

#table with demographic information for all players
Master %>% as_tibble()

#Question 5

# Use the correct join or bind function to create a combined table of the names and 
# statistics of the top 10 home run (HR) hitters for 2016. 
# This table should have the 
# player ID, first name, last name, and number of HR for the top 10 players. 
# Name this data frame top_names.
# 
# Identify the join or bind that fills the blank in this code to create the correct table:


top_names <- top %>% left_join(Master) %>%
  select(playerID, nameFirst, nameLast, HR)

#Salaries for the players
Salaries %>% as_tibble()

#Question 6
# Inspect the Salaries data frame. Filter this data frame to the 2016 salaries, 
# then use the correct bind join function to add a salary column to the 
# top_names data frame from the previous question. 
# Name the new data frame top_salary. Use this code framework:
top
top_salary <- Salaries %>% 
  filter(yearID==2016) %>% right_join(top_names) %>%
  select(playerID, nameFirst, nameLast, HR, salary)
top_salary



#Question 7

# Inspect the AwardsPlayers table. Filter awards to include only the year 2016.
# How many players from the top 10 home run hitters won at least one award in 2016?
# Use a set operator.
awards_df <- AwardsPlayers %>% filter(yearID == "2016")
intersect(top$playerID,awards_df$playerID)



# How many players won an award in 2016 but were not one of the 
# top 10 home run hitters in 2016?
length(setdiff(awards_df$playerID,top$playerID))















  
  
