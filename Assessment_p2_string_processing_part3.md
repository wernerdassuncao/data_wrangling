Assessment Part 2: String Processing Part 3
================
Werner Dassuncao
26 October, 2020

## Import raw Brexit referendum polling data from Wikipedia:

``` r
library(rvest)
```

    ## Loading required package: xml2

``` r
library(tidyverse)
```

    ## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──

    ## ✓ ggplot2 3.3.2     ✓ purrr   0.3.4
    ## ✓ tibble  3.0.4     ✓ dplyr   1.0.2
    ## ✓ tidyr   1.1.2     ✓ stringr 1.4.0
    ## ✓ readr   1.4.0     ✓ forcats 0.5.0

    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## x dplyr::filter()         masks stats::filter()
    ## x readr::guess_encoding() masks rvest::guess_encoding()
    ## x dplyr::lag()            masks stats::lag()
    ## x purrr::pluck()          masks rvest::pluck()

``` r
library(stringr)
url <- "https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"
tab <- read_html(url) %>% 
  html_nodes("table")

polls <- tab[[5]] %>%
  html_table(fill = TRUE)
```

  You will use a variety of string processing techniques learned in this
section to reformat these data.

 

## Question 5

Some rows in this table do not contain polls. You can identify these by
the lack of the percent sign (%) in the Remain column.

Update polls by changing the column names to c(“dates”, “remain”,
“leave”, “undecided”, “lead”, “samplesize”, “pollster”,
“poll\_type”, “notes”) and only keeping rows that have a percent
sign (%) in the remain column.

``` r
polls <- polls %>%
  filter(str_detect(Remain, "%"))

colnames(polls) <-  c('dates', 'remain', 'leave', 'undecided', 'lead', 'samplesize', 'pollster', 'poll_type', 'notes')
head(polls)
```

    ##          dates remain leave undecided lead samplesize
    ## 1 23 June 2016  48.1% 51.9%       N/A 3.8% 33,577,342
    ## 2      23 June    52%   48%       N/A   4%      4,772
    ## 3      22 June    55%   45%       N/A  10%      4,700
    ## 4   20–22 June    51%   49%       N/A   2%      3,766
    ## 5   20–22 June    49%   46%        1%   3%      1,592
    ## 6   20–22 June    44%   45%        9%   1%      3,011
    ##                                                                   pollster
    ## 1 Results of the United Kingdom European Union membership referendum, 2016
    ## 2                                                                   YouGov
    ## 3                                                                  Populus
    ## 4                                                                   YouGov
    ## 5                                                               Ipsos MORI
    ## 6                                                                  Opinium
    ##            poll_type                                        notes
    ## 1 UK-wide referendum                                             
    ## 2             Online                              On the day poll
    ## 3             Online                                             
    ## 4             Online Includes Northern Ireland (turnout weighted)
    ## 5          Telephone                                             
    ## 6             Online

How many rows remain in the polls data frame?

``` r
nrow(polls)
```

    ## [1] 129

## Question 6

The remain and leave columns are both given in the format “48.1%”:
percentages out of 100% with a percent symbol.

Which of these commands converts the remain vector to a proportion
between 0 and 1? Check all correct answers.

``` r
# Incorrect
as.numeric(str_remove(polls$remain, "%"))
```

    ##   [1] 48.1 52.0 55.0 51.0 49.0 44.0 54.0 48.0 41.0 45.0 42.0 53.0 45.0 44.0 44.0
    ##  [16] 42.0 42.0 37.0 46.0 43.0 39.0 45.0 44.0 46.0 40.0 48.0 53.0 42.0 44.0 45.0
    ##  [31] 43.0 43.0 48.0 41.0 43.0 40.0 41.0 42.0 44.0 51.0 44.0 44.0 41.0 41.0 45.0
    ##  [46] 55.0 44.0 44.0 52.0 55.0 47.0 43.0 55.0 38.0 36.0 38.0 44.0 42.0 44.0 43.0
    ##  [61] 42.0 49.0 39.0 41.0 45.0 43.0 44.0 51.0 51.0 49.0 48.0 43.0 53.0 38.0 40.0
    ##  [76] 39.0 35.0 45.0 42.0 40.0 39.0 44.0 51.0 39.0 35.0 41.0 51.0 45.0 49.0 40.0
    ##  [91] 48.0 41.0 46.0 47.0 43.0 45.0 48.0 49.0 40.0 40.0 40.0 39.0 41.0 39.0 48.0
    ## [106] 48.0 37.0 38.0 42.0 51.0 45.0 40.0 54.0 36.0 43.0 49.0 41.0 36.0 42.0 38.0
    ## [121] 55.0 44.0 54.0 41.0 52.0 42.0 38.0 42.0 44.0

``` r
# Incorrect
as.numeric(polls$remain)/100
```

    ## Warning: NAs introduced by coercion

    ##   [1] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
    ##  [26] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
    ##  [51] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
    ##  [76] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
    ## [101] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
    ## [126] NA NA NA NA

``` r
# Incorrect
parse_number(polls$remain)
```

    ##   [1] 48.1 52.0 55.0 51.0 49.0 44.0 54.0 48.0 41.0 45.0 42.0 53.0 45.0 44.0 44.0
    ##  [16] 42.0 42.0 37.0 46.0 43.0 39.0 45.0 44.0 46.0 40.0 48.0 53.0 42.0 44.0 45.0
    ##  [31] 43.0 43.0 48.0 41.0 43.0 40.0 41.0 42.0 44.0 51.0 44.0 44.0 41.0 41.0 45.0
    ##  [46] 55.0 44.0 44.0 52.0 55.0 47.0 43.0 55.0 38.0 36.0 38.0 44.0 42.0 44.0 43.0
    ##  [61] 42.0 49.0 39.0 41.0 45.0 43.0 44.0 51.0 51.0 49.0 48.0 43.0 53.0 38.0 40.0
    ##  [76] 39.0 35.0 45.0 42.0 40.0 39.0 44.0 51.0 39.0 35.0 41.0 51.0 45.0 49.0 40.0
    ##  [91] 48.0 41.0 46.0 47.0 43.0 45.0 48.0 49.0 40.0 40.0 40.0 39.0 41.0 39.0 48.0
    ## [106] 48.0 37.0 38.0 42.0 51.0 45.0 40.0 54.0 36.0 43.0 49.0 41.0 36.0 42.0 38.0
    ## [121] 55.0 44.0 54.0 41.0 52.0 42.0 38.0 42.0 44.0

``` r
#non-numeric argument to binary operator: commented out
#str_remove(polls$remain, "%")/100
```

``` r
# Correct
as.numeric(str_replace(polls$remain, "%", ""))/100
```

    ##   [1] 0.481 0.520 0.550 0.510 0.490 0.440 0.540 0.480 0.410 0.450 0.420 0.530
    ##  [13] 0.450 0.440 0.440 0.420 0.420 0.370 0.460 0.430 0.390 0.450 0.440 0.460
    ##  [25] 0.400 0.480 0.530 0.420 0.440 0.450 0.430 0.430 0.480 0.410 0.430 0.400
    ##  [37] 0.410 0.420 0.440 0.510 0.440 0.440 0.410 0.410 0.450 0.550 0.440 0.440
    ##  [49] 0.520 0.550 0.470 0.430 0.550 0.380 0.360 0.380 0.440 0.420 0.440 0.430
    ##  [61] 0.420 0.490 0.390 0.410 0.450 0.430 0.440 0.510 0.510 0.490 0.480 0.430
    ##  [73] 0.530 0.380 0.400 0.390 0.350 0.450 0.420 0.400 0.390 0.440 0.510 0.390
    ##  [85] 0.350 0.410 0.510 0.450 0.490 0.400 0.480 0.410 0.460 0.470 0.430 0.450
    ##  [97] 0.480 0.490 0.400 0.400 0.400 0.390 0.410 0.390 0.480 0.480 0.370 0.380
    ## [109] 0.420 0.510 0.450 0.400 0.540 0.360 0.430 0.490 0.410 0.360 0.420 0.380
    ## [121] 0.550 0.440 0.540 0.410 0.520 0.420 0.380 0.420 0.440

``` r
# Correct
parse_number(polls$remain)/100
```

    ##   [1] 0.481 0.520 0.550 0.510 0.490 0.440 0.540 0.480 0.410 0.450 0.420 0.530
    ##  [13] 0.450 0.440 0.440 0.420 0.420 0.370 0.460 0.430 0.390 0.450 0.440 0.460
    ##  [25] 0.400 0.480 0.530 0.420 0.440 0.450 0.430 0.430 0.480 0.410 0.430 0.400
    ##  [37] 0.410 0.420 0.440 0.510 0.440 0.440 0.410 0.410 0.450 0.550 0.440 0.440
    ##  [49] 0.520 0.550 0.470 0.430 0.550 0.380 0.360 0.380 0.440 0.420 0.440 0.430
    ##  [61] 0.420 0.490 0.390 0.410 0.450 0.430 0.440 0.510 0.510 0.490 0.480 0.430
    ##  [73] 0.530 0.380 0.400 0.390 0.350 0.450 0.420 0.400 0.390 0.440 0.510 0.390
    ##  [85] 0.350 0.410 0.510 0.450 0.490 0.400 0.480 0.410 0.460 0.470 0.430 0.450
    ##  [97] 0.480 0.490 0.400 0.400 0.400 0.390 0.410 0.390 0.480 0.480 0.370 0.380
    ## [109] 0.420 0.510 0.450 0.400 0.540 0.360 0.430 0.490 0.410 0.360 0.420 0.380
    ## [121] 0.550 0.440 0.540 0.410 0.520 0.420 0.380 0.420 0.440

 

## Question 7

The undecided column has some “N/A” values. These “N/A”s are only
present when the remain and leave columns total 100%, so they should
actually be zeros.

Use a function from stringr to convert “N/A” in the undecided column to
0. The format of your command should be function\_name(polls$undecided,
“arg1”, “arg2”).

What function replaces function\_name?

``` r
polls <- polls %>%
  mutate(undecided = str_replace_all(undecided, "N/A", "0"))

head(polls)
```

    ##          dates remain leave undecided lead samplesize
    ## 1 23 June 2016  48.1% 51.9%         0 3.8% 33,577,342
    ## 2      23 June    52%   48%         0   4%      4,772
    ## 3      22 June    55%   45%         0  10%      4,700
    ## 4   20–22 June    51%   49%         0   2%      3,766
    ## 5   20–22 June    49%   46%        1%   3%      1,592
    ## 6   20–22 June    44%   45%        9%   1%      3,011
    ##                                                                   pollster
    ## 1 Results of the United Kingdom European Union membership referendum, 2016
    ## 2                                                                   YouGov
    ## 3                                                                  Populus
    ## 4                                                                   YouGov
    ## 5                                                               Ipsos MORI
    ## 6                                                                  Opinium
    ##            poll_type                                        notes
    ## 1 UK-wide referendum                                             
    ## 2             Online                              On the day poll
    ## 3             Online                                             
    ## 4             Online Includes Northern Ireland (turnout weighted)
    ## 5          Telephone                                             
    ## 6             Online

What argument replaces arg1? Omit the quotation marks.

Answer: “N/A”

What argument replaces arg2? Omit the quotation marks.

Answer: 0

   

## Question 8

The dates column contains the range of dates over which the poll was
conducted. The format is “8-10 Jan” where the poll had a start date of
2016-01-08 and end date of 2016-01-10. Some polls go across month
boundaries (16 May-12 June).

The end date of the poll will always be one or two digits, followed by a
space, followed by the month as one or more letters (either capital or
lowercase). In these data, all month abbreviations or names have 3, 4 or
5 letters.

Write a regular expression to extract the end day and month from dates.
Insert it into the skeleton code below:

``` r
#temp <- str_extract_all(polls$dates, ____________)
#end_date <- sapply(temp, function(x) x[length(x)]) # take last element (handles polls that cross month boundaries)
#end_date
```

Which of the following regular expressions correctly extracts the end
day and month when inserted into the blank in the code above? Check all
correct answers.

``` r
#"\\d?\\s[a-zA-Z]?"
pattern4 <- "\\d+\\s[a-zA-Z]+"
#"\\d+\\s[A-Z]+"
pattern3 <- "[0-9]+\\s[a-zA-Z]+"
pattern2 <- "\\d{1,2}\\s[a-zA-Z]+"
#"\\d{1,2}[a-zA-Z]+"
pattern1 <- "\\d+\\s[a-zA-Z]{3,5}"
```

``` r
temp <- str_extract_all(polls$dates, pattern1)
end_date <- sapply(temp, function(x) x[length(x)]) # take last element (handles polls that cross month boundaries)
end_date
```

    ##   [1] "23 June" "23 June" "22 June" "22 June" "22 June" "22 June" "22 June"
    ##   [8] "22 June" "22 June" "20 June" "19 June" "19 June" "18 June" "17 June"
    ##  [15] "17 June" "16 June" "15 June" "15 June" "15 June" "14 June" "13 June"
    ##  [22] "13 June" "13 June" "13 June" "13 June" "12 June" "12 June" "10 June"
    ##  [29] "10 June" "9 June"  "6 June"  "5 June"  "5 June"  "3 June"  "3 June" 
    ##  [36] "3 June"  "31 May"  "29 May"  "29 May"  "29 May"  "25 May"  "24 May" 
    ##  [43] "24 May"  "23 May"  "22 May"  "22 May"  "19 May"  "17 May"  "17 May" 
    ##  [50] "16 May"  "15 May"  "15 May"  "15 May"  "12 May"  "12 May"  "12 May" 
    ##  [57] "8 May"   "6 May"   "3 May"   "29 Apr"  "29 Apr"  "29 Apr"  "28 Apr" 
    ##  [64] "26 Apr"  "26 Apr"  "26 Apr"  "24 Apr"  "24 Apr"  "19 Apr"  "18 Apr" 
    ##  [71] "17 Apr"  "17 Apr"  "17 Apr"  "14 Apr"  "14 Apr"  "12 Apr"  "11 Apr" 
    ##  [78] "10 Apr"  "10 Apr"  "7 Apr"   "4 Apr"   "3 Apr"   "3 Apr"   "1 Apr"  
    ##  [85] "29 Mar"  "29 Mar"  "28 Mar"  "24 Mar"  "22 Mar"  "22 Mar"  "20 Mar" 
    ##  [92] "20 Mar"  "19 Mar"  "14 Mar"  "13 Mar"  "11 Mar"  "10 Mar"  "6 Mar"  
    ##  [99] "6 Mar"   "3 Mar"   "2 Mar"   "1 Mar"   "29 Feb"  "28 Feb"  "28 Feb" 
    ## [106] "25 Feb"  "23 Feb"  "23 Feb"  "22 Feb"  "22 Feb"  "20 Feb"  "19 Feb" 
    ## [113] "16 Feb"  "15 Feb"  "14 Feb"  "14 Feb"  "7 Feb"   "4 Feb"   "31 Jan" 
    ## [120] "28 Jan"  "25 Jan"  "25 Jan"  "24 Jan"  "24 Jan"  "21 Jan"  "17 Jan" 
    ## [127] "16 Jan"  "14 Jan"  "10 Jan"

Final note: All patterns 1-4 are usable for grabbing the end day and
month
