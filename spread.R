library(tidyverse)
library(dslabs)
path <- system.file("extdata", package="dslabs")
filename <- file.path(path, "fertility-two-countries-example.csv")
wide_data <- read_csv(filename)

# SPREAD function
# 1st argument: which variable will be used as the column name
# 2nd argument: which variable to use to fill out the cells

#previous code from gather.R 
new_tidy_data <- wide_data %>%
  gather(year, fertility, -country, convert = TRUE)

#code
new_wide_data <- new_tidy_data %>% spread(year, fertility)
select(new_wide_data, country, '1960':'1967')

