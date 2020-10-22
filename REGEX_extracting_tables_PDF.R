library(dslabs)
library(tidyverse)

data("research_funding_rates")

research_funding_rates %>% 
  select("discipline",'success_rates_men','success_rates_women')

library(pdftools)
temp_file <- tempfile()

url <- paste0("https://www.pnas.org/content/suppl/2015/09/16/",
              "1510159112.DCSupplemental/pnas.201510159SI.pdf")
url
download.file(url, temp_file)
txt <- pdf_text(temp_file)
file.remove(temp_file)

#txt is a character vector, keeping the page that we want
raw_data_research_funding_rates <- txt[2]

data("raw_data_research_funding_rates")
raw_data_research_funding_rates

tab <- str_split(raw_data_research_funding_rates,'\n')
tab

tab <- tab[[1]]
tab[4]
the_names_1 <- tab[3]
the_names_2 <- tab[4]

#remove leading space and anything following the comma.
#get elements by splitting strings separated by space
#split only when there are 2 or more spaces to avoid splitting "success rates": \\s{2,}
the_names_1 <- the_names_1 %>%
  str_trim() %>%
  str_replace_all(",\\s.","") %>%
  str_split("\\s{2,}", simplify=TRUE)

the_names_1

#removing the extra spaces
the_names_2 <- the_names_2 %>%
  str_trim() %>%
  str_split("\\s+",simplify=TRUE)
the_names_2

#joining the 2 vectors with the column names
tmp_names <- str_c(rep(the_names_1, each=3), the_names_2[-1], sep='_')

#adding the 'discipline' column in the beginning
the_names <- c(the_names_2[1], tmp_names) %>%
  str_to_lower() %>%
  str_replace_all("\\s","_")

the_names

# Now we are ready to get the actual data. By examining the tab object, 
# we notice that the information is in lines 6 through 14. 
# We can use str_split again to achieve our goal:

new_research_funding_rates <- tab[6:14] %>%
  str_trim() %>%
  str_split("\\s{2,}",simplify=TRUE) %>%
  data.frame(stringsAsFactors=FALSE) %>%
  setNames(the_names) %>%
  mutate_at(-1,parse_number) 

new_research_funding_rates %>% as_tibble()


identical(research_funding_rates, new_research_funding_rates)
