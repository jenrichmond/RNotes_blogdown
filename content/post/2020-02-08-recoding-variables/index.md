---
title: IDHTG recoding variables
author: ''
date: '2020-02-08'
slug: recoding-variables
image: "img/portfolio/mutate.jpeg"
categories: []
tags: []
output:
  html_document:
    keep_md: yes
    toc: true
---

I don't often deal with questionnaire data in R, but Ariana and I have started trying import her qualtrics data into R and to write a script to score her measures. The first step is to recode the variables to make it possible to add up scores on subscales. 

##### load packages


```r
library(tidyverse)
```


##### make a little dataframe

```r
df <- data.frame("pp_no" = 1:12, 
                "sectionA_1" = c("Strongly Agree","Agree", "Disagree","Strongly Disagree"),
                "sectionA_2" = c("Strongly Agree","Agree", "Disagree","Strongly Disagree"),
                "sectionB_1" = c("Frequently","Sometimes", "Infrequently"),
                "sectionB_2" = c("Frequently","Sometimes", "Infrequently"))
```

### Option 1: use `mutate()` and `case_when()`

My first intuition is to use `case_when()`, which I have [written about before](http://jenrichmond.rbind.io/post/mutate-and-if-else-to-create-new-variables/). This option creates a new column for the first variable, recoding the response options into numeric values 1-4.


```r
df %>%
      mutate(sectionA_1_cw = case_when(sectionA_1 == "Strongly Agree" ~ 4,
                                  sectionA_1 == "Agree" ~ 3,
                                  sectionA_1 == "Disagree" ~ 2,
                                  sectionA_1 == "Strongly Disagree" ~ 1))
```

```
##    pp_no        sectionA_1        sectionA_2   sectionB_1   sectionB_2
## 1      1    Strongly Agree    Strongly Agree   Frequently   Frequently
## 2      2             Agree             Agree    Sometimes    Sometimes
## 3      3          Disagree          Disagree Infrequently Infrequently
## 4      4 Strongly Disagree Strongly Disagree   Frequently   Frequently
## 5      5    Strongly Agree    Strongly Agree    Sometimes    Sometimes
## 6      6             Agree             Agree Infrequently Infrequently
## 7      7          Disagree          Disagree   Frequently   Frequently
## 8      8 Strongly Disagree Strongly Disagree    Sometimes    Sometimes
## 9      9    Strongly Agree    Strongly Agree Infrequently Infrequently
## 10    10             Agree             Agree   Frequently   Frequently
## 11    11          Disagree          Disagree    Sometimes    Sometimes
## 12    12 Strongly Disagree Strongly Disagree Infrequently Infrequently
##    sectionA_1_cw
## 1              4
## 2              3
## 3              2
## 4              1
## 5              4
## 6              3
## 7              2
## 8              1
## 9              4
## 10             3
## 11             2
## 12             1
```

### Option 2a: use `mutate()` and `recode()`

`case_when()` can take pretty complicated arguments, and evaluates them in an ordered way, which might be more than you need. Perhaps `recode()` from dplyr is a simpler option. 


```r
df %>%
  mutate(sectionA_1_rc = recode(sectionA_1, "Strongly Agree" = "4",
                          "Agree" = "3",
                          "Disagree" = "2",
                       "Strongly Disagree" = "1", .default = "NA"))
```

```
##    pp_no        sectionA_1        sectionA_2   sectionB_1   sectionB_2
## 1      1    Strongly Agree    Strongly Agree   Frequently   Frequently
## 2      2             Agree             Agree    Sometimes    Sometimes
## 3      3          Disagree          Disagree Infrequently Infrequently
## 4      4 Strongly Disagree Strongly Disagree   Frequently   Frequently
## 5      5    Strongly Agree    Strongly Agree    Sometimes    Sometimes
## 6      6             Agree             Agree Infrequently Infrequently
## 7      7          Disagree          Disagree   Frequently   Frequently
## 8      8 Strongly Disagree Strongly Disagree    Sometimes    Sometimes
## 9      9    Strongly Agree    Strongly Agree Infrequently Infrequently
## 10    10             Agree             Agree   Frequently   Frequently
## 11    11          Disagree          Disagree    Sometimes    Sometimes
## 12    12 Strongly Disagree Strongly Disagree Infrequently Infrequently
##    sectionA_1_rc
## 1              4
## 2              3
## 3              2
## 4              1
## 5              4
## 6              3
## 7              2
## 8              1
## 9              4
## 10             3
## 11             2
## 12             1
```

Seems like `case_when()` and `recode()` work similarly, but by making a new variable for every recoded one, the df will end up twice as wide as it needs to be. There is a solution to that : transmute. If you `transmute()` rather than `mutate()`, you can recode the variable and drop the old one in one step. Lets try that. 


```r
df %>%
  transmute(sectionA_1_rc = recode(sectionA_1, "Strongly Agree" = "4",
                          "Agree" = "3",
                          "Disagree" = "2",
                       "Strongly Disagree" = "1", .default = "NA"))
```

```
##    sectionA_1_rc
## 1              4
## 2              3
## 3              2
## 4              1
## 5              4
## 6              3
## 7              2
## 8              1
## 9              4
## 10             3
## 11             2
## 12             1
```

Yikes! that is a bit drastic! It drops all the variables except the one you have recoded. If you are recoding all the variables in one go, that might work.  But maybe a better solution would be to mutate and replace the variable you are recoding, rather than naming it something new. 


```r
df %>%
  mutate(sectionA_1 = recode(sectionA_1, "Strongly Agree" = "4",
                          "Agree" = "3",
                          "Disagree" = "2",
                       "Strongly Disagree" = "1", .default = "NA"))
```

```
##    pp_no sectionA_1        sectionA_2   sectionB_1   sectionB_2
## 1      1          4    Strongly Agree   Frequently   Frequently
## 2      2          3             Agree    Sometimes    Sometimes
## 3      3          2          Disagree Infrequently Infrequently
## 4      4          1 Strongly Disagree   Frequently   Frequently
## 5      5          4    Strongly Agree    Sometimes    Sometimes
## 6      6          3             Agree Infrequently Infrequently
## 7      7          2          Disagree   Frequently   Frequently
## 8      8          1 Strongly Disagree    Sometimes    Sometimes
## 9      9          4    Strongly Agree Infrequently Infrequently
## 10    10          3             Agree   Frequently   Frequently
## 11    11          2          Disagree    Sometimes    Sometimes
## 12    12          1 Strongly Disagree Infrequently Infrequently
```

### dplyr "scoped" verbs (_all, _at, _if)

The questions for each scale tend to have the same response options, so it should be possible to mutate all the variables that share features in one go. This is where scoped verbs in dplyr come in. 

I am not the first person to write about these. I found blog posts by [Rebecca Barter](http://www.rebeccabarter.com/blog/2019-01-23_scoped-verbs/) and [Suzan Baert](https://suzan.rbind.io/2018/02/dplyr-tutorial-2/) really useful. Thanks @RLadies! 

##### Mutate options

- `mutate_all()` affects every variable

- `mutate_at()` affects variables selected with a character vector or `vars()`

- `mutate_if()` affects variables selected with a predicate function

### Option 2b: use `mutate_at()` and `recode()`

In this situation, I think `mutate_at()` is going to be most useful. To select particular variables, use the `vars()` function and `starts_with()`, `ends_with()`, or `contains()` to specify which variables to apply the function to. Here the function we want to apply to each variable starting with section_A_ is `recode()`, so we specify that using ~ .Then set up the recode mappings, and specify that "NA" should be used as default if a match can't be made. 

When I look at this code, it reads... mutate only the variables starting with section A_, apply the recode function to all of them, recoding Strongly Agree as 4 etc etc, putting NA in if you can't make a match. 


```r
df %>%
  mutate_at(vars(starts_with("sectionA_")), ~ recode(., "Strongly Agree" = "4",
                          "Agree" = "3",
                          "Disagree" = "2",
                       "Strongly Disagree" = "1", .default = "NA")) 
```

```
##    pp_no sectionA_1 sectionA_2   sectionB_1   sectionB_2
## 1      1          4          4   Frequently   Frequently
## 2      2          3          3    Sometimes    Sometimes
## 3      3          2          2 Infrequently Infrequently
## 4      4          1          1   Frequently   Frequently
## 5      5          4          4    Sometimes    Sometimes
## 6      6          3          3 Infrequently Infrequently
## 7      7          2          2   Frequently   Frequently
## 8      8          1          1    Sometimes    Sometimes
## 9      9          4          4 Infrequently Infrequently
## 10    10          3          3   Frequently   Frequently
## 11    11          2          2    Sometimes    Sometimes
## 12    12          1          1 Infrequently Infrequently
```

Then you can %>% another series of recoding for other variables in the df. 


```r
df %>%
  mutate_at(vars(starts_with("sectionA_")), ~ recode(., "Strongly Agree" = "4",
                          "Agree" = "3",
                          "Disagree" = "2",
                       "Strongly Disagree" = "1", .default = "NA")) %>%
  mutate_at(vars(starts_with("sectionB_")), ~ recode(., "Frequently" = "3",
                          "Sometimes" = "2",
                          "Infrequently" = "0",
                        .default = "NA"))
```

```
##    pp_no sectionA_1 sectionA_2 sectionB_1 sectionB_2
## 1      1          4          4          3          3
## 2      2          3          3          2          2
## 3      3          2          2          0          0
## 4      4          1          1          3          3
## 5      5          4          4          2          2
## 6      6          3          3          0          0
## 7      7          2          2          3          3
## 8      8          1          1          2          2
## 9      9          4          4          0          0
## 10    10          3          3          3          3
## 11    11          2          2          2          2
## 12    12          1          1          0          0
```

Done!
