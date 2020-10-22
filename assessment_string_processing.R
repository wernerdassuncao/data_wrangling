library(rvest)
library(tidyverse)

setwd('/Users/werner/projects/R_data_wrangling')
path <- getwd()
list.files(path)

file_name <- "string_processing.csv"
full_path <- file.path(path, file_name)

question_4_data <- read_tsv(full_path)
class(question_4_data$Sales)

question_4_data

question_4_data %>% mutate_at(2:3, parse_number) #works
question_4_data %>% mutate_all(parse_number) #removes the contents of months
question_4_data %>% mutate_at(2:3, funs(str_replace_all(., c("\\$|,"),""))) %>%
  mutate_at(2:3, as.numeric)


