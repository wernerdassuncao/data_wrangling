#exercises 21.5

#one
co2_wide <- data.frame(matrix(co2, ncol = 12, byrow = TRUE)) %>%
  setNames(1:12) %>%
  mutate(year = as.character(1959:1997))

co2_wide

# Use the gather function to wrangle this into a tidy dataset. 
# Call the column with the CO2 measurements co2 and call the 
# month column month. Call the resulting object co2_tidy.

co2_tidy <- co2_wide %>% 
  gather(month, co2, -year, convert = TRUE)

co2_tidy


#ploting CO2 versus month with a different curve for each year using this code:

co2_tidy %>% ggplot(aes(month, co2, color = year)) + geom_line()

class(co2_tidy$month)


# exercise 4
load(admissions)
dat <- admissions %>% select(-applicants)
dat

# If we think of an observation as a major, and that each observation 
# has two variables (men admitted percentage and women admitted 
# percentage) then this is not tidy. Use the spread function to wrangle
# into tidy shape: one row for each major.

new_dat <- dat %>%
  spread(gender, admitted)

new_dat


#exercise 5
# 5. Now we will try a more advanced wrangling challenge. 
# We want to wrangle the admissions data so that for each major we 
# have 4 observations: admitted_men, admitted_women, applicants_men 
# and applicants_women. The trick we perform here is actually quite 
# common: first gather to generate an intermediate data frame and 
# then spread to obtain the tidy data we want. We will go step by 
# step in this and the next two exercises.
# 
# Use the gather function to create a tmp data.frame with a column 
# containing the type of observation admitted or applicants. 
# Call the new columns key and value.
head(admissions)

tmp <- admissions %>%
  gather(key, value, -gender)

tmp

tmp %>% spread(major, key)





