# Another common operation involving strings is recoding the names of categorical variables.
# Let’s say you have really long names for your levels and you will be displaying them in 
# plots, you might want to use shorter versions of these names. 
# For example, in character vectors with country names, you might want to change 
# “United States of America” to “USA” and “United Kingdom” to UK, and so on. 
# We can do this with case_when, although the tidyverse offers an option that is 
# specifically designed for this task: the recode function.

library(dslabs)
data("gapminder")
colnames(gapminder)


gapminder %>%
  filter(region == 'Caribbean') %>%
  ggplot(aes(year, life_expectancy, color = country)) +
  geom_line()


gapminder %>% filter(region=='Caribbean') %>%
  mutate(country=recode(country,
                        'Antigua and Barbuda' = 'Barbuda',
                        'Dominican Republic' = 'DR',
                        'St. Vincent and the Grenadines' = 'St. Vincent',
                        'Trinidad and Tobago' = 'Trinidad')) %>%
  ggplot(aes(year, life_expectancy,color=country)) +
  geom_line()

gapminder %>% filter(region == 'Caribbean' & year == min(year)) %>%
  summarize(country, year)











