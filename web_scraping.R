# import a webpage into R
library(rvest)
url <- "https://en.wikipedia.org/wiki/Murder_in_the_United_States_by_state"
h <- read_html(url)
class(h)
h

tab <- h %>% html_nodes("table")

tab <- tab[[2]]
tab
tab <- tab %>% html_table
class(tab)
tail(tab)
tab <- tab %>% setNames(c("state", "population", "total", "murders", "gun_murders", "gun_ownership", "total_rate", "murder_rate", "gun_murder_rate"))
head(tab)

###################################################
############        CSS Selectors       ###########
#++++++++++++++++++++++++++++++++++++++++++++++++++
url <- "http://www.foodnetwork.com/recipes/alton-brown/guacamole-recipe-1940609"
h <- read_html(url)
h

#using css.selector.gatget chrome extension to get the css SELECTOR for the component
recipe <- h %>% html_node(".o-AssetTitle__a-HeadlineText") %>% html_text()
prep_time <- h %>% html_node(".m-RecipeInfo__a-Description--Total") %>% html_text()
ingredients <- h %>% html_nodes(".o-Ingredients__a-Ingredient") %>% html_text()

guacamole <- list(recipe, prep_time, ingredients)
guacamole


#now creating a function to grab any recipe from The Food Network:
get_recipe <- function(url){
  h <- read_html(url)
  recipe <- h %>% html_node(".o-AssetTitle__a-HeadlineText") %>% html_text()
  prep_time <- h %>% html_node(".m-RecipeInfo__a-Description--Total") %>% html_text()
  ingredients <- h %>% html_nodes(".o-Ingredients__a-Ingredient") %>% html_text()
  return(list(recipe=recipe, prep_time=prep_time, ingredients = ingredients))
}

get_recipe('https://www.foodnetwork.com/recipes/ree-drummond/cauliflower-mac-and-cheese-4608962')

get_recipe("https://www.foodnetwork.com/recipes/guy-fieri/cuban-pork-chops-with-mojo-recipe-1947717")




# There are several other powerful tools provided by rvest. 
# For example, the functions 
#   html_form(), 
#   set_values(), and 
#   submit_form() 
# permit you to query a webpage from R. 
# This is a more advanced topic not covered here.