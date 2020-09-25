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


filename <- "stats.tsv"
stats <- read_csv(filename)

tidy_stats <- stats %>%
  separate(col = key, into = c("player", "variable_name"), sep = "_") %>%
  spread(key = variable_name, value = value)

  
  