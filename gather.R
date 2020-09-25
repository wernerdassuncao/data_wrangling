library(tidyverse)
library(dslabs)
path <- system.file("extdata", package="dslabs")
filename <- file.path(path, "fertility-two-countries-example.csv")
wide_data <- read_csv(filename)

# Wide format:
#1. Each row includes several observations
#2. One of the variables is stored in the header

#GATHER function:
# 1st argument sets the column name that will hold the variable that is currently
# kept in the wide data column name;
# 2nd argument sets the column name for the column that will hold 
#the value on the column cells.



new_tidy_data <- gather(wide_data, year, fertility, '1960':'2015')
new_tidy_data

#or using the pipe: 
#new_tidy_data <- wide_data %>% gather(year, fertility, `1960`:`2015`)

new_tidy_data <- wide_data %>%
  gather(year, fertility, -country)
new_tidy_data


data("gapminder")
tidy_data <- gapminder %>%
  filter(country %in% c("South Korea", "Germany") & !is.na(fertility)) %>%
  select(country, year, fertility)

tidy_data


class(tidy_data$year) #integer
class(new_tidy_data$year) #character


new_tidy_data <- wide_data %>%
  gather(year, fertility, -country, convert = TRUE)
class(new_tidy_data$year) #integer

new_tidy_data %>% ggplot(aes(year, fertility, color = country)) +
  geom_point()

