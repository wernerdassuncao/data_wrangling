library(tidyverse)
library(dslabs)
path <- system.file("extdata", package="dslabs")
filename <- file.path(path, "fertility-two-countries-example.csv")
wide_data <- read_csv(filename)

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

