library(tidyverse)
library(dslabs)
path <- system.file("extdata", package="dslabs")
filename <- "life-expectancy-and-fertility-two-countries-example.csv"
filename <- file.path(path, filename)

raw_dat <- read_csv(filename)
select(raw_dat, 1:5)

dat <- raw_dat %>% gather(key, value, -country)

head(dat)

dat$key[1:5]

#first attempt to fix the key values into 2 columns
dat %>% separate(key, c("year", "variable_name"), "_")




var_names <- c("year", "first_variable_name", "second_variable_name")
#creates two columns:
dat %>% separate(key, var_names, fill = "right")

#better solution to "merge" the values:
dat %>% separate(key, c("year", "variable_name"), extra = "merge")



#creating a column for each variable:
dat %>%
  separate(key, c("year", "variable_name"), extra = "merge") %>%
  spread(variable_name, value)


################################
########## UNITE ###############
################################


dat %>%
  separate(key, var_names, fill = "right")

#uniting the 2nd and 3rd columns, then spreading the columns and renaming fertility_NA:

dat %>%
  separate(key, var_names, fill = "right") %>%
  unite(variable_name, first_variable_name, second_variable_name) %>%
  spread(variable_name, value) %>%
  rename(fertility = fertility_NA)



