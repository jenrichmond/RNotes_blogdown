---
title: lesser known stars of the tidyverse
author: ''
date: '2018-08-30'
slug: lesser-known-stars-of-the-tidyverse
categories: []
output:
  html_document:
    keep_md: yes
---

[Emily Robinson](@robinson_es) writes a great blog called www.hookedondata.org. She talked at the 2018 New York R conference recently and shared some of her favourite (less well known) stars of the Tidyverse. Here are her slides www.tiny.cc/nyrtalk and my notes...



### 1.use `as_tibble()`

Tibble = modern dataframe. Use instead of printing your dataset to the console.

`as_tibble()` will only print the first 10 rows and columns that fit on the screen. 

### 2. examine your NAs

`is.na()` returns TRUE or FALSE, TRUE is 1 and FALSE is 0, which means you can use sum to count the number of NAs in a given variable. 

> summarise(numberNA = sum(is.na(variable))

What about all variables? Purrr can help. `map_df()` maps a function across all variables and gives a dataframe (hence the df) back.   The dot says this is where the column/function should go; the tilde ~ stands for anonymous function. 

> map_df(~sum(is.na(.)))

What if cells are empty rather than NA? You can convert empty cells to NA using `na.if()`

> na_if("") 

### 3. look at numeric variables

Look just a numeric columns with `select_if(is.numeric)` then pipe in to a `skim()` to get mean, SD, missing, and little histograms. 


### 4. examine data in a single column

When you have more than 1 piece of information in a column, using stringr package `str_split(column, ",")` to split the string at the point where the , is.

In ggplot, mhen x axis labels are all bunchy, use `coord_flip()` to fip the graph on its side. Also if you want to sort the bars, use `fct_reorder()` from `forcat` to sort by n. 

### 5. make a mimimal reproducible example

When you want help, if it helpful to helpers if you create a minimal reproudicule example so that they can see and run the code using your data. 

Optional. Use `as.tribble()` to make a fake data set, if there is a reason you can't show helpers real data. 

1. Use `reprex()` to find problems that may prevent helpers from running your code for reasons that aren't related to why your code won't run for you. 

2. Use `reprex()` to post your question/issue

## Emily's favourite resources

1. www.r4ds.co.nz R for Data Science

2. Twitter #rstats

3. Rstats cheat sheets 

4. www.DataCamp.com
