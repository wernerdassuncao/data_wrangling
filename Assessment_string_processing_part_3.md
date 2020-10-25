Assessment\_part1\_string\_processing\_part\_3
================
Werner Dassuncao
10/24/2020

## Assessment Part 1: String Processing Part 3

In this part of the assessment, you will answer several multiple choice
questions that review the concepts of string processing. You can answer
these questions without using R, although you may find it helpful to
experiment with commands in your console.

In the second part of the assessment on the next page, you will import a
real dataset and use string processing to clean it for analysis. This
will require you to write code in R.

Want even more practice with regular expressions? Complete the lessons
and exercises in the RegexOne External link online interactive
tutorial\!

## Question 2

You have the following table, schedule:

> schedule day staff Monday Mandy, Chris and Laura Tuesday Steve, Ruth
> and Frank

You want to turn this into a more useful data frame.

Which two commands would properly split the text in the “staff” column
into each individual name? Select ALL that apply.

``` r
schedule <- read_tsv('schedule.csv')
```

    ## Parsed with column specification:
    ## cols(
    ##   day = col_character(),
    ##   staff = col_character()
    ## )

``` r
schedule
```

    ## # A tibble: 2 x 2
    ##   day     staff                 
    ##   <chr>   <chr>                 
    ## 1 Monday  Mandy, Chris and Laura
    ## 2 Tuesday Steve, Ruth and Frank

 

WRONG OPTION

``` r
str_split(schedule$staff, ",|and")
```

    ## [[1]]
    ## [1] "M"       "y"       " Chris " " Laura" 
    ## 
    ## [[2]]
    ## [1] "Steve"  " Ruth " " Frank"

 

CORRECT OPTION

``` r
str_split(schedule$staff, ",| and ")
```

    ## [[1]]
    ## [1] "Mandy"  " Chris" "Laura" 
    ## 
    ## [[2]]
    ## [1] "Steve" " Ruth" "Frank"

 

CORRECT OPTION

``` r
str_split(schedule$staff, ",\\s|\\sand\\s?")
```

    ## [[1]]
    ## [1] "Mandy" "Chris" "Laura"
    ## 
    ## [[2]]
    ## [1] "Steve" "Ruth"  "Frank"

 

WRONG OPTION

``` r
str_split(schedule$staff, "\\s?(,|and)\\s?")
```

    ## [[1]]
    ## [1] "M"     "y"     "Chris" "Laura"
    ## 
    ## [[2]]
    ## [1] "Steve" "Ruth"  "Frank"

 

## Question 3

You have the following table, schedule:

> schedule day staff Monday Mandy, Chris and Laura Tuesday Steve, Ruth
> and Frank

What code would successfully turn your “Schedule” table into the
following tidy table?

> tidy day staff <chr> <chr> Monday Mandy Monday Chris Monday Laura
> Tuesday Steve Tuesday Ruth Tuesday Frank

CORRECT ANSWER:

``` r
tidy <- schedule %>% 
  mutate(staff = str_split(staff, ",\\s|\\sand\\s?")) %>% 
  unnest()
```

    ## Warning: `cols` is now required when using unnest().
    ## Please use `cols = c(staff)`

``` r
tidy
```

    ## # A tibble: 6 x 2
    ##   day     staff
    ##   <chr>   <chr>
    ## 1 Monday  Mandy
    ## 2 Monday  Chris
    ## 3 Monday  Laura
    ## 4 Tuesday Steve
    ## 5 Tuesday Ruth 
    ## 6 Tuesday Frank

 

Error during parsing: (code commented out)

``` r
# tidy <- separate(schedule, staff, into = c("s1","s2","s3"), sep = "([?])") %>%
#   gather(key = s, value = staff, s1:s3)
# 
# tidy
```

 

WRONG ANSWER:

``` r
tidy <- schedule %>% 
  mutate(staff = str_split(staff, ", | and ", simplify = TRUE)) %>% 
  unnest()
```

    ## Warning: `cols` is now required when using unnest().
    ## Please use `cols = c()`

``` r
tidy
```

    ## # A tibble: 2 x 2
    ##   day     staff[,1] [,2]  [,3] 
    ##   <chr>   <chr>     <chr> <chr>
    ## 1 Monday  Mandy     Chris Laura
    ## 2 Tuesday Steve     Ruth  Frank

   

## Question 4

Using the gapminder data, you want to recode countries longer than 12
letters in the region “Middle Africa” to their abbreviations in a new
column, “country\_short”. Which code would accomplish this?

Locating the countries with names larger than 12 letters:

``` r
long_names <- gapminder %>% 
  filter(region == 'Middle Africa' & nchar(as.character(country)) > 12)
head(long_names)
```

    ##                    country year infant_mortality life_expectancy fertility
    ## 1 Central African Republic 1960            165.5           37.43      5.84
    ## 2         Congo, Dem. Rep. 1960            174.0           43.90      6.00
    ## 3        Equatorial Guinea 1960               NA           37.69      5.51
    ## 4 Central African Republic 1961            162.9           37.89      5.87
    ## 5         Congo, Dem. Rep. 1961               NA           44.25      6.02
    ## 6        Equatorial Guinea 1961               NA           38.04      5.52
    ##   population        gdp continent        region
    ## 1    1503501  534982718    Africa Middle Africa
    ## 2   15248246 4992962083    Africa Middle Africa
    ## 3     252115         NA    Africa Middle Africa
    ## 4    1529229  561479896    Africa Middle Africa
    ## 5   15637715 4451156989    Africa Middle Africa
    ## 6     255100         NA    Africa Middle Africa

 

WRONG ANSWER (created a new column “recode(…)” not country\_short)

``` r
dat <- gapminder %>% filter(region == "Middle Africa") %>% 
  mutate(recode(country, 
                "Central African Republic" = "CAR", 
                "Congo, Dem. Rep." = "DRC",
                "Equatorial Guinea" = "Eq. Guinea"))
head(dat)
```

    ##                    country year infant_mortality life_expectancy fertility
    ## 1                   Angola 1960            208.0           35.98      7.32
    ## 2                 Cameroon 1960            166.9           43.46      5.65
    ## 3 Central African Republic 1960            165.5           37.43      5.84
    ## 4                     Chad 1960               NA           40.95      6.25
    ## 5         Congo, Dem. Rep. 1960            174.0           43.90      6.00
    ## 6              Congo, Rep. 1960            110.6           48.25      5.88
    ##   population        gdp continent        region recode(...)
    ## 1    5270844         NA    Africa Middle Africa      Angola
    ## 2    5361367 2537944080    Africa Middle Africa    Cameroon
    ## 3    1503501  534982718    Africa Middle Africa         CAR
    ## 4    3002596  750173439    Africa Middle Africa        Chad
    ## 5   15248246 4992962083    Africa Middle Africa         DRC
    ## 6    1013581  626127041    Africa Middle Africa Congo, Rep.

 

WRONG ANSWER (not enough arguments, run error, commented out)

``` r
#dat <- gapminder %>% filter(region == "Middle Africa") %>% 
#  mutate(country_short = recode(country, 
#                                c("Central African Republic", "Congo, Dem. Rep.", "Equatorial Guinea"),
#                                c("CAR", "DRC", "Eq. Guinea")))
```

  WRONG ANSWER(recoded the actual names on the country column, we want a
new column called ‘country\_short’)

``` r
dat <- gapminder %>% filter(region == "Middle Africa") %>% 
  mutate(country = recode(country, 
                          "Central African Republic" = "CAR", 
                          "Congo, Dem. Rep." = "DRC",
                          "Equatorial Guinea" = "Eq. Guinea"))
head(dat)
```

    ##       country year infant_mortality life_expectancy fertility population
    ## 1      Angola 1960            208.0           35.98      7.32    5270844
    ## 2    Cameroon 1960            166.9           43.46      5.65    5361367
    ## 3         CAR 1960            165.5           37.43      5.84    1503501
    ## 4        Chad 1960               NA           40.95      6.25    3002596
    ## 5         DRC 1960            174.0           43.90      6.00   15248246
    ## 6 Congo, Rep. 1960            110.6           48.25      5.88    1013581
    ##          gdp continent        region
    ## 1         NA    Africa Middle Africa
    ## 2 2537944080    Africa Middle Africa
    ## 3  534982718    Africa Middle Africa
    ## 4  750173439    Africa Middle Africa
    ## 5 4992962083    Africa Middle Africa
    ## 6  626127041    Africa Middle Africa

  CORRECT ANSWER(adds a new column at the end “country\_short”)

``` r
dat <- gapminder %>% filter(region == "Middle Africa") %>% 
  mutate(country_short = recode(country, 
                                "Central African Republic" = "CAR", 
                                "Congo, Dem. Rep." = "DRC",
                                "Equatorial Guinea" = "Eq. Guinea"))
head(dat)
```

    ##                    country year infant_mortality life_expectancy fertility
    ## 1                   Angola 1960            208.0           35.98      7.32
    ## 2                 Cameroon 1960            166.9           43.46      5.65
    ## 3 Central African Republic 1960            165.5           37.43      5.84
    ## 4                     Chad 1960               NA           40.95      6.25
    ## 5         Congo, Dem. Rep. 1960            174.0           43.90      6.00
    ## 6              Congo, Rep. 1960            110.6           48.25      5.88
    ##   population        gdp continent        region country_short
    ## 1    5270844         NA    Africa Middle Africa        Angola
    ## 2    5361367 2537944080    Africa Middle Africa      Cameroon
    ## 3    1503501  534982718    Africa Middle Africa           CAR
    ## 4    3002596  750173439    Africa Middle Africa          Chad
    ## 5   15248246 4992962083    Africa Middle Africa           DRC
    ## 6    1013581  626127041    Africa Middle Africa   Congo, Rep.

## Including Plots

### Drawing a plot of Life Expectancy versus Infant Mortality in Middle Africa we can make the following observations:

1.  the higher the infant mortality, the lower the life expectancy
2.  the higher the life expectancy, the lower infant mortality

These two variables seem to have a inverse or negative correlation.

``` r
dat %>%
  ggplot(aes(life_expectancy, infant_mortality, color = country_short)) +
  geom_line() +
  labs(x = 'Life expectancy', y = 'Infant mortality', color = 'Country', title = "Middle Africa")
```

    ## Warning: Removed 57 row(s) containing missing values (geom_path).

![](Assessment_string_processing_part_3_files/figure-gfm/Middle%20Africa-1.png)<!-- -->

 

### As a comparison we can generate a similar plot for western european countries:

``` r
gapminder %>% filter(region == 'Western Europe') %>%
  ggplot(aes(life_expectancy, infant_mortality, color = country)) +
  geom_line() +
  labs(x = 'Life expectancy', y = 'Infant mortality', color = 'Country', title = "Western Europe")
```

    ## Warning: Removed 9 row(s) containing missing values (geom_path).

![](Assessment_string_processing_part_3_files/figure-gfm/Western%20Europe-1.png)<!-- -->

## Final note:

Interesting to observe a similar behavior of the variables in Middle
Africa and Western Europe. It is worth noting that the nature of the
relationship seems more “**curved**” in Europe than what we observe in
Africa.
