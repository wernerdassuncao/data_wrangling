library(tidyverse)
library(dslabs)
data(murders)

#Population size table
head(murders)


#Electoral votes table
data(polls_us_election_2016)
head(results_us_election_2016)

#We can not just concatenate these two tables since the order of the states is different

identical(results_us_election_2016$state, murders$state)


##########  JOIN ###########

#remove the OTHERS column and rename ELECTORAL_VOTES so that the tables fit on the page:

tab <- left_join(murders, results_us_election_2016, by="state") %>%
  select(-others) %>% rename(ev = electoral_votes)

dim(tab)

#making a plot to explore the relationship within the data:
library(ggrepel)

tab %>% ggplot(aes(population/10^6, ev, label = abb))+
  geom_point() +
  geom_text_repel() +
  scale_x_continuous(trans = "log2") +
  scale_y_continuous(trans = "log2") +
  geom_smooth(method = "lm", se = FALSE)
  

#making subsets of the tables above:
tab_1 <- slice(murders, 1:6) %>% select(state,population)
tab_1



tab_2 <- results_us_election_2016 %>% 
  filter(state %in% c("Alabama", "Alaska", "Arizona", 
                      "California", "Connecticut", "Delaware")) %>%
  select(state, electoral_votes) %>%
  rename(ev = electoral_votes)
tab_2  

######################################################
###########         LEFT JOIN            #############
######################################################
# Suppose we want a table like tab_1, but adding electoral votes to 
# whatever states we have available. For this, we use left_join with 
# tab_1 as the first argument. We specify which column to use to 
# match with the by argument.
left_join(tab_1, tab_2, by="state")
#or
tab_1 %>% left_join(tab_2, by="state")

######################################################
##########          RIGHT JOIN            ############
######################################################
# If instead of a table with the same rows as first table, 
# we want one with the same rows as second table, 
# we can use right_join:
tab_1 %>% right_join(tab_2, by="state")

######################################################
#############       INNER JOIN        ################
######################################################
# If we want to keep only the rows that have information 
# in both tables, we use inner_join. 
# You can think of this as an intersection:
inner_join(tab_1, tab_2, by="state")


######################################################
#############       FULL JOIN         ################
######################################################
# If we want to keep all the rows and fill the missing parts with NAs,
# we can use full_join. You can think of this as a union:
full_join(tab_1, tab_2, by="state")


######################################################
#############       SEMI JOIN         ################
######################################################
# The semi_join function lets us keep the part of first table for which 
# we have information in the second. 
# It does not add the columns of the second:
semi_join(tab_1,tab_2,by="state")


#identical(inner_join(tab_1,tab_2,by="state"),semi_join(tab_1,tab_2,by="state"))


######################################################
#############       ANTI JOIN         ################
######################################################
# The function anti_join is the opposite of semi_join. 
# It keeps the elements of the first table for which 
# there is no information in the second:
anti_join(tab_1,tab_2,by="state")










# import US murders data
library(tidyverse)
library(ggrepel)
library(dslabs)
ds_theme_set()
data(murders)
head(murders)

# import US election results data
data(polls_us_election_2016)
head(results_us_election_2016)
identical(results_us_election_2016$state, murders$state)

# join the murders table and US election results table
tab <- left_join(murders, results_us_election_2016, by = "state")
head(tab)

# plot electoral votes versus population
tab %>% ggplot(aes(population/10^6, electoral_votes, label = abb)) +
  geom_point() +
  geom_text_repel() + 
  scale_x_continuous(trans = "log2") +
  scale_y_continuous(trans = "log2") +
  geom_smooth(method = "lm", se = FALSE)

# make two smaller tables to demonstrate joins
tab1 <- slice(murders, 1:6) %>% select(state, population)
tab1
tab2 <- slice(results_us_election_2016, c(1:3, 5, 7:8)) %>% select(state, electoral_votes)
tab2

# experiment with different joins
left_join(tab1, tab2)
tab1 %>% left_join(tab2)
tab1 %>% right_join(tab2)
inner_join(tab1, tab2)
semi_join(tab1, tab2)
anti_join(tab1, tab2)
















