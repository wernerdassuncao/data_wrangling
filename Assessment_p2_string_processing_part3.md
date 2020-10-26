Assessment Part 2: String Processing Part 3
================
Werner Dassuncao
25 October, 2020

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

#Correct
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
#Correct
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

polls
```

    ##              dates remain leave undecided lead samplesize
    ## 1     23 June 2016  48.1% 51.9%         0 3.8% 33,577,342
    ## 2          23 June    52%   48%         0   4%      4,772
    ## 3          22 June    55%   45%         0  10%      4,700
    ## 4       20–22 June    51%   49%         0   2%      3,766
    ## 5       20–22 June    49%   46%        1%   3%      1,592
    ## 6       20–22 June    44%   45%        9%   1%      3,011
    ## 7       17–22 June    54%   46%         0   8%      1,032
    ## 8       17–22 June    48%   42%       11%   6%      1,032
    ## 9       16–22 June    41%   43%       16%   2%      2,320
    ## 10         20 June    45%   44%       11%   1%      1,003
    ## 11      18–19 June    42%   44%       13%   2%      1,652
    ## 12      16–19 June    53%   46%        2%   7%        800
    ## 13      17–18 June    45%   42%       13%   3%      1,004
    ## 14      16–17 June    44%   43%        9%   1%      1,694
    ## 15      14–17 June    44%   44%       12%  N/A      2,006
    ## 16      15–16 June    42%   44%        9%   2%      1,734
    ## 17         15 June    42%   45%       13%   3%      1,104
    ## 18      10–15 June    37%   47%       16%  10%      1,468
    ## 19      10–15 June    46%   43%       11%   3%      1,064
    ## 20      11–14 June    43%   49%        3%   6%      1,257
    ## 21      12–13 June    39%   46%       15%   7%      1,905
    ## 22      10–13 June    45%   50%        5%   5%      1,000
    ## 23      10–13 June    44%   49%        7%   5%      2,001
    ## 24       9–13 June    46%   45%        9%   1%      1,002
    ## 25       7–13 June    40%   47%       13%   7%      2,497
    ## 26       9–12 June    48%   49%        3%   1%        800
    ## 27  16 May–12 June    53%   47%         0   6%        N/A
    ## 28       9–10 June    42%   43%       11%   1%      1,671
    ## 29       7–10 June    44%   42%       13%   2%      2,009
    ## 30        8–9 June    45%   55%         0  10%      2,052
    ## 31        5–6 June    43%   42%       11%   1%      2,001
    ## 32        3–5 June    43%   48%        9%   5%      2,047
    ## 33        2–5 June    48%   47%        5%   1%        800
    ## 34        1–3 June    41%   45%       11%   4%      3,405
    ## 35   31 May–3 June    43%   41%       16%   2%      2,007
    ## 36   31 May–3 June    40%   43%       16%   3%      2,007
    ## 37       30–31 May    41%   41%       13%  N/A      1,735
    ## 38       27–29 May    42%   45%       15%   3%      1,004
    ## 39       27–29 May    44%   47%        9%   3%      2,052
    ## 40       25–29 May    51%   46%        3%   5%        800
    ## 41       20–25 May    44%   45%       12%   1%      1,638
    ## 42          24 May    44%   38%       18%   6%      1,013
    ## 43       23–24 May    41%   41%       13%  N/A      1,756
    ## 44       19–23 May    41%   43%       16%   2%      1,213
    ## 45       20–22 May    45%   45%       10%  N/A      2,003
    ## 46       18–22 May    55%   42%        3%  13%        800
    ## 47       17–19 May    44%   40%       14%   4%      2,008
    ## 48       16–17 May    44%   40%       12%   4%      1,648
    ## 49       14–17 May    52%   41%        7%  11%      1,000
    ## 50       14–16 May    55%   37%        5%  18%      1,002
    ## 51       13–15 May    47%   39%       14%   8%      1,002
    ## 52       13–15 May    43%   47%       10%   4%      2,048
    ## 53       11–15 May    55%   40%        5%  15%        800
    ## 54       10–12 May    38%   41%       21%   3%      1,222
    ## 55   29 Apr–12 May    36%   39%       22%   3%        996
    ## 56   29 Apr–12 May    38%   40%       16%   2%      1,973
    ## 57         6–8 May    44%   46%       11%   2%      2,005
    ## 58         4–6 May    42%   40%       13%   2%      3,378
    ## 59    29 Apr–3 May    44%   45%       11%   1%      2,040
    ## 60       27–29 Apr    43%   46%       11%   3%      2,029
    ## 61       26–29 Apr    42%   41%       14%   1%      2,005
    ## 62       27–29 Apr    49%   51%         0   2%      2,000
    ## 63       26–28 Apr    39%   36%       26%   3%      1,221
    ## 64       25–26 Apr    41%   42%       13%   1%      1,650
    ## 65       25–26 Apr    45%   38%       17%   7%      1,003
    ## 66       22–26 Apr    43%   45%       13%   2%      2,001
    ## 67       22–24 Apr    44%   46%       10%   2%      2,001
    ## 68       20–24 Apr    51%   43%        6%   8%        800
    ## 69       16–19 Apr    51%   40%        9%   9%      1,002
    ## 70       16–18 Apr    49%   39%        8%  10%      1,026
    ## 71       15–17 Apr    48%   41%       11%   7%      1,003
    ## 72       15–17 Apr    43%   44%       13%   1%      2,008
    ## 73       13–17 Apr    53%   41%        6%  12%        800
    ## 74       12–14 Apr    38%   34%       28%   4%      1,198
    ## 75       12–14 Apr    40%   39%       16%   1%      3,371
    ## 76       11–12 Apr    39%   39%       17%  N/A      1,693
    ## 77        7–11 Apr    35%   35%       30%  N/A      1,198
    ## 78        8–10 Apr    45%   38%       17%   7%      1,002
    ## 79        8–10 Apr    42%   45%       12%   3%      2,030
    ## 80         6–7 Apr    40%   38%       16%   2%      1,612
    ## 81    29 Mar–4 Apr    39%   38%       18%   1%      3,754
    ## 82         1–3 Apr    44%   43%       13%   1%      2,007
    ## 83    29 Mar–3 Apr    51%   44%        5%   7%        800
    ## 84    29 Mar–1 Apr    39%   43%       18%   4%      1,966
    ## 85       24–29 Mar    35%   35%       30%  N/A      1,193
    ## 86       24–29 Mar    41%   45%       14%   4%      1,518
    ## 87       24–28 Mar    51%   49%         0   2%      2,002
    ## 88       22–24 Mar    45%   43%       12%   2%      1,970
    ## 89       19–22 Mar    49%   41%       10%   8%      1,023
    ## 90       17–22 Mar    40%   37%       19%   3%      1,688
    ## 91       18–20 Mar    48%   41%       11%   7%      1,002
    ## 92       18–20 Mar    41%   43%       17%   2%      2,000
    ## 93       17–19 Mar    46%   35%       19%  11%      1,006
    ## 94       11–14 Mar    47%   49%        4%   2%        823
    ## 95       11–13 Mar    43%   41%       16%   2%      2,031
    ## 96        4–11 Mar    45%   40%       16%   5%      2,282
    ## 97        2–10 Mar    48%   45%        7%   3%      4,047
    ## 98         4–6 Mar    49%   35%       15%  14%        966
    ## 99         4–6 Mar    40%   41%       19%   1%      2,051
    ## 100        2–3 Mar    40%   37%       18%   3%      1,695
    ## 101        1–2 Mar    40%   35%       19%   5%      1,705
    ## 102   29 Feb–1 Mar    39%   37%       19%   2%      2,233
    ## 103      26–29 Feb    41%   41%       18%  N/A      2,003
    ## 104      26–28 Feb    39%   45%       18%   6%      2,071
    ## 105      26–28 Feb    48%   37%       15%  11%      1,002
    ## 106      24–25 Feb    48%   52%         0   4%      2,014
    ## 107      21–23 Feb    37%   38%       25%   1%      3,482
    ## 108      17–23 Feb    38%   36%       25%   2%      1,517
    ## 109      19–22 Feb    42%   40%       17%   2%      2,021
    ## 110      19–22 Feb    51%   39%       10%  12%      1,000
    ## 111      13–20 Feb    45%   32%       23%  13%        938
    ## 112      18–19 Feb    40%   41%       19%   1%      1,033
    ## 113      13–16 Feb    54%   36%       10%  18%        497
    ## 114      11–15 Feb    36%   39%       25%   3%      1,079
    ## 115      12–14 Feb    43%   39%       18%   4%      2,001
    ## 116      11–14 Feb    49%   41%       10%   8%      1,105
    ## 117        5–7 Feb    41%   42%       17%   1%      2,018
    ## 118        3–4 Feb    36%   45%       19%   9%      1,675
    ## 119      29–31 Jan    42%   39%       19%   3%      2,002
    ## 120      27–28 Jan    38%   42%       20%   4%      1,735
    ## 121      23–25 Jan    55%   36%        9%  19%        513
    ## 122      21–25 Jan    44%   42%       14%   2%      1,511
    ## 123      22–24 Jan    54%   36%       10%  18%      1,006
    ## 124      22–24 Jan    41%   41%       18%  N/A      2,010
    ## 125      20–21 Jan    52%   48%         0   4%      2,015
    ## 126      15–17 Jan    42%   40%       17%   2%      2,023
    ## 127      15–16 Jan    38%   40%       22%   2%      1,017
    ## 128       8–14 Jan    42%   45%       12%   3%      2,087
    ## 129       8–10 Jan    44%   38%       18%   6%      2,055
    ##                                                                     pollster
    ## 1   Results of the United Kingdom European Union membership referendum, 2016
    ## 2                                                                     YouGov
    ## 3                                                                    Populus
    ## 4                                                                     YouGov
    ## 5                                                                 Ipsos MORI
    ## 6                                                                    Opinium
    ## 7                                                                     ComRes
    ## 8                                                                     ComRes
    ## 9                                                                        TNS
    ## 10                                                        Survation/IG Group
    ## 11                                                                    YouGov
    ## 12                                                             ORB/Telegraph
    ## 13                                                                 Survation
    ## 14                                                                    YouGov
    ## 15                                                                   Opinium
    ## 16                                                                    YouGov
    ## 17                                                                 Survation
    ## 18                                                              BMG Research
    ## 19                                                              BMG Research
    ## 20                                                                Ipsos MORI
    ## 21                                                                    YouGov
    ## 22                                                                       ICM
    ## 23                                                                       ICM
    ## 24                                                                    ComRes
    ## 25                                                                       TNS
    ## 26                                                                       ORB
    ## 27                                                                    NATCEN
    ## 28                                                                    YouGov
    ## 29                                                                   Opinium
    ## 30                                                                       ORB
    ## 31                                                                    YouGov
    ## 32                                                                       ICM
    ## 33                                                                       ORB
    ## 34                                                                    YouGov
    ## 35                                                                   Opinium
    ## 36                                                                   Opinium
    ## 37                                                                    YouGov
    ## 38                                                                       ICM
    ## 39                                                                       ICM
    ## 40                                                                       ORB
    ## 41                                                              BMG Research
    ## 42                                                                 Survation
    ## 43                                                                    YouGov
    ## 44                                                                       TNS
    ## 45                                                                       ICM
    ## 46                                                                       ORB
    ## 47                                                                   Opinium
    ## 48                                                                    YouGov
    ## 49                                                                    ComRes
    ## 50                                                                Ipsos MORI
    ## 51                                                                       ICM
    ## 52                                                                       ICM
    ## 53                                                                       ORB
    ## 54                                                                       TNS
    ## 55                                                                    YouGov
    ## 56                                                                    YouGov
    ## 57                                                                       ICM
    ## 58                                                                    YouGov
    ## 59                                                                       ICM
    ## 60                                                                       ICM
    ## 61                                                                   Opinium
    ## 62                                                                       ORB
    ## 63                                                                       TNS
    ## 64                                                                    YouGov
    ## 65                                                                 Survation
    ## 66                                                              BMG Research
    ## 67                                                                       ICM
    ## 68                                                                       ORB
    ## 69                                                                    ComRes
    ## 70                                                                Ipsos MORI
    ## 71                                                                       ICM
    ## 72                                                                       ICM
    ## 73                                                                       ORB
    ## 74                                                                       TNS
    ## 75                                                                    YouGov
    ## 76                                                                    YouGov
    ## 77                                                                       TNS
    ## 78                                                                    ComRes
    ## 79                                                                       ICM
    ## 80                                                                    YouGov
    ## 81                                                                    YouGov
    ## 82                                                                       ICM
    ## 83                                                                       ORB
    ## 84                                                                   Opinium
    ## 85                                                                       TNS
    ## 86                                                              BMG Research
    ## 87                                                                       ORB
    ## 88                                                                       ICM
    ## 89                                                                Ipsos MORI
    ## 90                                                                    YouGov
    ## 91                                                                    ComRes
    ## 92                                                                       ICM
    ## 93                                                                 Survation
    ## 94                                                                       ORB
    ## 95                                                                       ICM
    ## 96                                         Greenberg Quinlan Rosner Research
    ## 97                                          Populus/Number Cruncher Politics
    ## 98                                          Populus/Number Cruncher Politics
    ## 99                                                                       ICM
    ## 100                                                                   YouGov
    ## 101                                                                   YouGov
    ## 102                                                                   YouGov
    ## 103                                                                      ICM
    ## 104                                         Populus/Number Cruncher Politics
    ## 105                                         Populus/Number Cruncher Politics
    ## 106                                                                      ORB
    ## 107                                                                   YouGov
    ## 108                                                             BMG Research
    ## 109                                                                      ICM
    ## 110                                                                   ComRes
    ## 111                                                                Survation
    ## 112                                                                  Opinium
    ## 113                                                               Ipsos MORI
    ## 114                                                                      TNS
    ## 115                                                                      ICM
    ## 116                                                                   ComRes
    ## 117                                                                      ICM
    ## 118                                                         YouGov/The Times
    ## 119                                                                      ICM
    ## 120                                                                   YouGov
    ## 121                                                               Ipsos MORI
    ## 122                                                             BMG Research
    ## 123                                                                   ComRes
    ## 124                                                                      ICM
    ## 125                                                                      ORB
    ## 126                                                                      ICM
    ## 127                                                                Survation
    ## 128                                                                Panelbase
    ## 129                                                                      ICM
    ##              poll_type
    ## 1   UK-wide referendum
    ## 2               Online
    ## 3               Online
    ## 4               Online
    ## 5            Telephone
    ## 6               Online
    ## 7            Telephone
    ## 8            Telephone
    ## 9               Online
    ## 10           Telephone
    ## 11              Online
    ## 12           Telephone
    ## 13           Telephone
    ## 14              Online
    ## 15              Online
    ## 16              Online
    ## 17           Telephone
    ## 18              Online
    ## 19           Telephone
    ## 20           Telephone
    ## 21              Online
    ## 22           Telephone
    ## 23              Online
    ## 24           Telephone
    ## 25              Online
    ## 26           Telephone
    ## 27    Online/Telephone
    ## 28              Online
    ## 29              Online
    ## 30              Online
    ## 31              Online
    ## 32              Online
    ## 33           Telephone
    ## 34              Online
    ## 35              Online
    ## 36              Online
    ## 37              Online
    ## 38           Telephone
    ## 39              Online
    ## 40           Telephone
    ## 41              Online
    ## 42           Telephone
    ## 43              Online
    ## 44              Online
    ## 45              Online
    ## 46           Telephone
    ## 47              Online
    ## 48              Online
    ## 49           Telephone
    ## 50           Telephone
    ## 51           Telephone
    ## 52              Online
    ## 53           Telephone
    ## 54              Online
    ## 55           Telephone
    ## 56              Online
    ## 57              Online
    ## 58              Online
    ## 59              Online
    ## 60              Online
    ## 61              Online
    ## 62              Online
    ## 63              Online
    ## 64              Online
    ## 65           Telephone
    ## 66              Online
    ## 67              Online
    ## 68           Telephone
    ## 69           Telephone
    ## 70           Telephone
    ## 71           Telephone
    ## 72              Online
    ## 73           Telephone
    ## 74              Online
    ## 75              Online
    ## 76              Online
    ## 77              Online
    ## 78           Telephone
    ## 79              Online
    ## 80              Online
    ## 81              Online
    ## 82              Online
    ## 83           Telephone
    ## 84              Online
    ## 85              Online
    ## 86              Online
    ## 87              Online
    ## 88              Online
    ## 89           Telephone
    ## 90              Online
    ## 91           Telephone
    ## 92              Online
    ## 93           Telephone
    ## 94           Telephone
    ## 95              Online
    ## 96              Online
    ## 97              Online
    ## 98           Telephone
    ## 99              Online
    ## 100             Online
    ## 101             Online
    ## 102             Online
    ## 103             Online
    ## 104             Online
    ## 105          Telephone
    ## 106             Online
    ## 107             Online
    ## 108             Online
    ## 109             Online
    ## 110          Telephone
    ## 111          Telephone
    ## 112             Online
    ## 113          Telephone
    ## 114             Online
    ## 115             Online
    ## 116          Telephone
    ## 117             Online
    ## 118             Online
    ## 119             Online
    ## 120             Online
    ## 121          Telephone
    ## 122             Online
    ## 123          Telephone
    ## 124             Online
    ## 125             Online
    ## 126             Online
    ## 127             Online
    ## 128             Online
    ## 129             Online
    ##                                                                                                                            notes
    ## 1                                                                                                                               
    ## 2                                                                                                                On the day poll
    ## 3                                                                                                                               
    ## 4                                                                                   Includes Northern Ireland (turnout weighted)
    ## 5                                                                                                                               
    ## 6                                                                                                                               
    ## 7                                                                         Those expressing a voting intention (turnout weighted)
    ## 8                                                                                               All UK adults (turnout weighted)
    ## 9                                                                                                                               
    ## 10                                                                                                                              
    ## 11                                                                                                                              
    ## 12                                                                                                          Definite voters only
    ## 13                                                                                                                              
    ## 14                                                                                                                              
    ## 15                                                                          Most fieldwork conducted before the death of Jo Cox.
    ## 16                                                                                                                              
    ## 17                                                                                                                              
    ## 18                                                                                                                              
    ## 19                                                                                                                              
    ## 20                                                                                                                              
    ## 21                                                                                                                              
    ## 22  Final ICM polls.[27] Only include those "definite" to vote. Paired telephone/online polls by otherwise identical methodology
    ## 23  Final ICM polls.[27] Only include those "definite" to vote. Paired telephone/online polls by otherwise identical methodology
    ## 24                                                                                                                              
    ## 25                                                                                                                              
    ## 26                                                                                        Measures only those "definite" to vote
    ## 27                                                       Primarily online, those who failed to respond were followed up by phone
    ## 28                                                                                                                              
    ## 29                                                                                                                              
    ## 30                                                                                       Weighted according to "definite" voters
    ## 31                                                                                                        Remainder "won't vote"
    ## 32                                                                                                                              
    ## 33                                                                                      Weighted according to "definite" to vote
    ## 34                                                                                                                              
    ## 35                                                                                               Weighted by new methodology[28]
    ## 36                                                                                          Weighted by previous methodology[29]
    ## 37                                                                                                                              
    ## 38                                                              Paired telephone/online polls by otherwise identical methodology
    ## 39                                                              Paired telephone/online polls by otherwise identical methodology
    ## 40                                                                                                                              
    ## 41                                                                                                                              
    ## 42                                                                                                                              
    ## 43                                                                                                                              
    ## 44                                                                                                                              
    ## 45                                                                                                                              
    ## 46                                                 Poll was said to reflect the private polling conducted for the government[30]
    ## 47                                                                                                                              
    ## 48                                                                                                                              
    ## 49                                                                                                                              
    ## 50                                                                                                                              
    ## 51                                                              Paired telephone/online polls by otherwise identical methodology
    ## 52                                                              Paired telephone/online polls by otherwise identical methodology
    ## 53                                                                                                                              
    ## 54                                                                                                                              
    ## 55                                                                                                                              
    ## 56                                                                                                                              
    ## 57                                                                                                                              
    ## 58                                                                                                        Remainder "won't vote"
    ## 59                                                                                                                              
    ## 60                                                                                                                              
    ## 61                                          24% of respondents preferred not to say; the stated percentages are of the other 76%
    ## 62                                                                                                                              
    ## 63                                                                                                                              
    ## 64                                                                                                        Remainder "won't vote"
    ## 65                                                                                                                              
    ## 66                                                                                                                              
    ## 67                                                                                                                              
    ## 68                                                                                                                              
    ## 69                                                                                                                              
    ## 70                                                                                                                              
    ## 71                                                              Paired telephone/online polls by otherwise identical methodology
    ## 72                                                              Paired telephone/online polls by otherwise identical methodology
    ## 73                                                                                                                              
    ## 74                                                                                                                              
    ## 75                                                                                                        Remainder "won't vote"
    ## 76                                                                                                        Remainder "won't vote"
    ## 77                                                                                                                              
    ## 78                                                                                                                              
    ## 79                                                                                                                              
    ## 80                                                                                                        Remainder "won't vote"
    ## 81                                                                                                        Remainder "won't vote"
    ## 82                                                                                                                              
    ## 83                                                                                                                              
    ## 84                                                                                                                              
    ## 85                                                                                                                              
    ## 86                                                                                                     Includes Northern Ireland
    ## 87                                                                                                                              
    ## 88                                                                          Original poll is no longer available on ICM Unlimted
    ## 89                                                                                                                              
    ## 90                                                                                                        Remainder "won't vote"
    ## 91                                                                                                                              
    ## 92                                                                                                                              
    ## 93                                                                                                     Includes Northern Ireland
    ## 94                                                                                                                              
    ## 95                                                                                                                              
    ## 96                                                                                                                              
    ## 97                                                                                                                              
    ## 98                                                                                                                              
    ## 99                                                                                                                              
    ## 100                                                                                                                             
    ## 101                                                                                                                             
    ## 102                                                                                                                             
    ## 103                                                                                                                             
    ## 104                                                                                                                             
    ## 105                                                                                                                             
    ## 106                                                                                                                             
    ## 107                                                                                                                             
    ## 108                                                                                                    Includes Northern Ireland
    ## 109                                                                                                                             
    ## 110                                                                                                                             
    ## 111                                                                                                                             
    ## 112                                   Conducted before the conclusion of the negotiations; exact time frame was not communicated
    ## 113                                                                                                                             
    ## 114                                                                                                                             
    ## 115                                                                         Original poll is no longer available on ICM Unlimted
    ## 116                                                                                                                             
    ## 117                                                                                                                             
    ## 118                                                                                                                             
    ## 119                                                                                                                             
    ## 120                                                                                                                             
    ## 121                                                                                                                             
    ## 122                                                                                                    Includes Northern Ireland
    ## 123                                                                                                                             
    ## 124                                                                                                                             
    ## 125                                                                                                                             
    ## 126                                                                                                                             
    ## 127                                                                                                    Includes Northern Ireland
    ## 128                                                                                                                             
    ## 129

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
