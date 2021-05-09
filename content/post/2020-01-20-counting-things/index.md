---
title: IDHTG counting things
author: ''
date: '2020-01-20'
slug: counting-things
categories: []
image: "img/portfolio/count.jpeg"
tags: []
output:
  html_document:
    keep_md: yes
    toc: true
---

Sometimes things that are really easy to do in excel are not so intuitive in R. Like counting things. Because most of the time I am working with data in long format, you can end up with hundreds of observations, so functions like length() aren't useful. Today I just wanted to check how many participants were in this dataset and it took me some significant googling. 

##### load packages

```r
library(tidyverse)
library(ggbeeswarm)
library(janitor)
```

##### create a little df


```r
df <- data.frame("pp_no" = 1:16, 
                 "group" = c("control", "control","control","control", "exp", "exp", "exp", "exp"),
                "delay" = c("short","long"), 
                "condition" = c("easy", "easy", "difficult", "difficult"),
                "score" = c(82, 75, 76, 72, 86, 89, 85, 87, 87, 76, 78, 85, 97, 87, 94, 87))
```


### count distinct values

Having data in long format makes it difficult to count things because values repeat. You are really wanting to count how many distinct values there are. My intuition is to use the `distinct()` function from dplyr, but it SELECTS distinct rows, but doesn't count them. 

It is the `n_distinct()` function will give you a count of the distinct values in a variable

```r
n_distinct(df$pp_no)
```

```
## [1] 16
```

In order to count the number of participants in each group, you need to combine `group_by` and summarise, with n_distinct like this


```r
df %>%
  group_by(group) %>%
  summarise(pp_count = n_distinct(pp_no))
```

```
## # A tibble: 2 x 2
##   group   pp_count
##   <chr>      <int>
## 1 control        8
## 2 exp            8
```


### counting by levels 

The other counting thing I do a lot if counting observations by group (or other categorical variable). Although there is a few lines of code, combining `group_by()` and `summarise()` is useful because you create a df that can combines both the count and other summary stats.

#### option 1: group_by x summarise

```r
df %>%
  group_by(delay) %>%
  summarise(count = n(), mean_score = mean(score))
```

```
## # A tibble: 2 x 3
##   delay count mean_score
##   <chr> <int>      <dbl>
## 1 long      8       82.2
## 2 short     8       85.6
```

#### option 2: table() 

If you just want a fast count, `table()` by categorical variable will count observations by condition

```r
table(df$delay)
```

```
## 
##  long short 
##     8     8
```

#### option 3: janitor::tabyl

When things are less evenly distributed `janitor::tabyl()` is useful because it gives % as well as n

```r
janitor::tabyl(df$delay)
```

```
##  df$delay n percent
##      long 8     0.5
##     short 8     0.5
```

