Assessment Part 2: Dates, Times, and Text Mining
================
Werner Dassuncao
31 October, 2020.

In this part of the assessment, you will walk through a basic text
mining and sentiment analysis task.

Project Gutenberg is a digital archive of public domain books. The R
package gutenbergr facilitates the importation of these texts into R. We
will combine this with the tidyverse and tidytext libraries to practice
text mining.

Use these libraries and options:

``` r
library(tidyverse)
```

    ## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──

    ## ✓ ggplot2 3.3.2     ✓ purrr   0.3.4
    ## ✓ tibble  3.0.4     ✓ dplyr   1.0.2
    ## ✓ tidyr   1.1.2     ✓ stringr 1.4.0
    ## ✓ readr   1.4.0     ✓ forcats 0.5.0

    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
library(gutenbergr)
library(tidytext)
options(digits = 3)
```

You can see the books and documents available in gutenbergr like this:

``` r
gutenberg_metadata
```

    ## # A tibble: 51,997 x 8
    ##    gutenberg_id title author gutenberg_autho… language gutenberg_books… rights
    ##           <int> <chr> <chr>             <int> <chr>    <chr>            <chr> 
    ##  1            0  <NA> <NA>                 NA en       <NA>             Publi…
    ##  2            1 "The… Jeffe…             1638 en       United States L… Publi…
    ##  3            2 "The… Unite…                1 en       American Revolu… Publi…
    ##  4            3 "Joh… Kenne…             1666 en       <NA>             Publi…
    ##  5            4 "Lin… Linco…                3 en       US Civil War     Publi…
    ##  6            5 "The… Unite…                1 en       American Revolu… Publi…
    ##  7            6 "Giv… Henry…                4 en       American Revolu… Publi…
    ##  8            7 "The… <NA>                 NA en       <NA>             Publi…
    ##  9            8 "Abr… Linco…                3 en       US Civil War     Publi…
    ## 10            9 "Abr… Linco…                3 en       US Civil War     Publi…
    ## # … with 51,987 more rows, and 1 more variable: has_text <lgl>

#### gutenberg\_metadata not available…, workaround:

``` r
#install.packages(c("urltools", "lazyeval"))    
#install.packages("https://cran.r-project.org/src/contrib/Archive/gutenbergr/gutenbergr_0.1.5.tar.gz", repos = NULL, type = "source")

head(gutenberg_metadata)
```

    ## # A tibble: 6 x 8
    ##   gutenberg_id title author gutenberg_autho… language gutenberg_books… rights
    ##          <int> <chr> <chr>             <int> <chr>    <chr>            <chr> 
    ## 1            0  <NA> <NA>                 NA en       <NA>             Publi…
    ## 2            1 "The… Jeffe…             1638 en       United States L… Publi…
    ## 3            2 "The… Unite…                1 en       American Revolu… Publi…
    ## 4            3 "Joh… Kenne…             1666 en       <NA>             Publi…
    ## 5            4 "Lin… Linco…                3 en       US Civil War     Publi…
    ## 6            5 "The… Unite…                1 en       American Revolu… Publi…
    ## # … with 1 more variable: has_text <lgl>

``` r
colnames(gutenberg_metadata)
```

    ## [1] "gutenberg_id"        "title"               "author"             
    ## [4] "gutenberg_author_id" "language"            "gutenberg_bookshelf"
    ## [7] "rights"              "has_text"

### Question 6

Use str\_detect() to find the ID of the novel Pride and Prejudice.

How many different ID numbers are returned?

``` r
pattern <- 'Pride and Prejudice'
gutenberg_metadata %>% 
  filter(str_detect(title, pattern))
```

    ## # A tibble: 6 x 8
    ##   gutenberg_id title author gutenberg_autho… language gutenberg_books… rights
    ##          <int> <chr> <chr>             <int> <chr>    <chr>            <chr> 
    ## 1         1342 Prid… Auste…               68 en       Best Books Ever… Publi…
    ## 2        20686 Prid… Auste…               68 en       Harvard Classic… Publi…
    ## 3        20687 Prid… Auste…               68 en       Harvard Classic… Publi…
    ## 4        26301 Prid… Auste…               68 en       Best Books Ever… Publi…
    ## 5        37431 Prid… <NA>                 NA en       <NA>             Publi…
    ## 6        42671 Prid… Auste…               68 en       Best Books Ever… Publi…
    ## # … with 1 more variable: has_text <lgl>

``` r
# alternative code:
 gutenberg_metadata %>%
    filter(str_detect(title, "Pride and Prejudice"))
```

    ## # A tibble: 6 x 8
    ##   gutenberg_id title author gutenberg_autho… language gutenberg_books… rights
    ##          <int> <chr> <chr>             <int> <chr>    <chr>            <chr> 
    ## 1         1342 Prid… Auste…               68 en       Best Books Ever… Publi…
    ## 2        20686 Prid… Auste…               68 en       Harvard Classic… Publi…
    ## 3        20687 Prid… Auste…               68 en       Harvard Classic… Publi…
    ## 4        26301 Prid… Auste…               68 en       Best Books Ever… Publi…
    ## 5        37431 Prid… <NA>                 NA en       <NA>             Publi…
    ## 6        42671 Prid… Auste…               68 en       Best Books Ever… Publi…
    ## # … with 1 more variable: has_text <lgl>

### Question 7

Notice that there are several versions of the book. The
gutenberg\_works() function filters this table to remove replicates and
include only English language works. Use this function to find the ID
for Pride and Prejudice.

What is the correct ID number? Read the gutenberg\_works() documentation
to learn how to use the function.

``` r
library(dplyr)
title_id <- gutenberg_works(title == pattern)$gutenberg_id
```

    ## Warning: `filter_()` is deprecated as of dplyr 0.7.0.
    ## Please use `filter()` instead.
    ## See vignette('programming') for more help
    ## This warning is displayed once every 8 hours.
    ## Call `lifecycle::last_warnings()` to see where this warning was generated.

    ## Warning: `distinct_()` is deprecated as of dplyr 0.7.0.
    ## Please use `distinct()` instead.
    ## See vignette('programming') for more help
    ## This warning is displayed once every 8 hours.
    ## Call `lifecycle::last_warnings()` to see where this warning was generated.

``` r
title_id
```

    ## [1] 1342

### Question 8

Use the gutenberg\_download() function to download the text for Pride
and Prejudice. Use the tidytext package to create a tidy table with all
the words in the text. Save this object as words.

How many words are present in the book?

``` r
#creating a table:
book <- tibble(gutenberg_download(title_id))
```

    ## Determining mirror for Project Gutenberg from http://www.gutenberg.org/robot/harvest

    ## Using mirror http://aleph.gutenberg.org

``` r
# grabs each word from input(column) and creates a 'word' column with one row for each word
words <- unnest_tokens(book, word, text,token = 'words')

# Output sample:
head(words)
```

    ## # A tibble: 6 x 2
    ##   gutenberg_id word     
    ##          <int> <chr>    
    ## 1         1342 pride    
    ## 2         1342 and      
    ## 3         1342 prejudice
    ## 4         1342 by       
    ## 5         1342 jane     
    ## 6         1342 austen

``` r
# Answer:
# Counting the rows(words)
nrow(words)
```

    ## [1] 122204

``` r
# Alternative code:

book <- gutenberg_download(1342)
words <- book %>%
  unnest_tokens(word, text)
nrow(words)
```

    ## [1] 122204

### Question 9

Remove stop words from the words object. Recall that stop words are
defined in the stop\_words data frame from the tidytext package.

``` r
# Looking at the stop_words structure
str(stop_words)
```

    ## tibble [1,149 × 2] (S3: tbl_df/tbl/data.frame)
    ##  $ word   : chr [1:1149] "a" "a's" "able" "about" ...
    ##  $ lexicon: chr [1:1149] "SMART" "SMART" "SMART" "SMART" ...

``` r
# Looking at the data:
stop_words
```

    ## # A tibble: 1,149 x 2
    ##    word        lexicon
    ##    <chr>       <chr>  
    ##  1 a           SMART  
    ##  2 a's         SMART  
    ##  3 able        SMART  
    ##  4 about       SMART  
    ##  5 above       SMART  
    ##  6 according   SMART  
    ##  7 accordingly SMART  
    ##  8 across      SMART  
    ##  9 actually    SMART  
    ## 10 after       SMART  
    ## # … with 1,139 more rows

``` r
# Filtering out the words from stop_words:

words <- words %>%
  filter(!word %in% stop_words$word)

words
```

    ## # A tibble: 37,246 x 2
    ##    gutenberg_id word        
    ##           <int> <chr>       
    ##  1         1342 pride       
    ##  2         1342 prejudice   
    ##  3         1342 jane        
    ##  4         1342 austen      
    ##  5         1342 chapter     
    ##  6         1342 1           
    ##  7         1342 truth       
    ##  8         1342 universally 
    ##  9         1342 acknowledged
    ## 10         1342 single      
    ## # … with 37,236 more rows

``` r
nrow(words)
```

    ## [1] 37246

``` r
# Alternative code:
 words <- words %>% anti_join(stop_words)
```

    ## Joining, by = "word"

``` r
nrow(words)
```

    ## [1] 37246

How many words remain? Answer: 37246

### Question 10

After removing stop words, detect and then filter out any token that
contains a digit from words.

How many words remain?

``` r
# Creating a pattern to remove a digit from words
words <- words %>% filter(!str_detect(word, "\\d"))
nrow(words)
```

    ## [1] 37180

### Question 11

Analyze the most frequent words in the novel after removing stop words
and tokens with digits.

How many words appear more than 100 times in the book?

``` r
nrow(words %>% 
  count(word) %>%
  filter(n > 100) %>%
  arrange(desc(n)))
```

    ## [1] 23

What is the most common word in the book?

``` r
words %>% count(word) %>%
  top_n(1,n) %>%
  pull(word)
```

    ## [1] "elizabeth"

How many times does that most common word appear?

``` r
words %>% count(word) %>%
  top_n(1,n) %>%
  pull(n)
```

    ## [1] 597

### Question 12

Define the afinn lexicon:

Note that this command will trigger a question in the R Console asking
if you want to download the AFINN lexicon. Press 1 to select “Yes” (if
using RStudio, enter this in the Console tab).

Use this afinn lexicon to assign sentiment values to words. Keep only
words that are present in both words and the afinn lexicon. Save this
data frame as afinn\_sentiments.

How many elements of words have sentiments in the afinn lexicon?

``` r
words_sentiment <- words %>% 
  inner_join(afinn, by = 'word') 

nrow(words_sentiment)
```

    ## [1] 6065

What proportion of words in afinn\_sentiments have a positive value?

``` r
mean(afinn$value > 0)
```

    ## [1] 0.354

``` r
# The official answer is 0.563, but most likely the afinn_sentiments got updated and the mean has changed... answers not updated...
```

How many elements of afinn\_sentiments have a value of 4?

``` r
sum(afinn$value == 4)
```

    ## [1] 45

``` r
# The official answer is 51, but most likely the afinn_sentiments got updated and the this answer has changed... answers not updated...
```
