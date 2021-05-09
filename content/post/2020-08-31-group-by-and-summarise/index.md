---
title: group_by and summarise
author: ''
date: '2020-08-31'
slug: group-by-and-summarise
categories: []
image: "img/penguin.png"
output:
  html_document:
    keep_md: yes
---


Some students have been asking me how they can calcuate means and standard errors by condition. Here is a quick example using the palmer penguin data. 

Details of the palmer penguin data, with art by Allison Horst, can be [found here](https://github.com/allisonhorst/palmerpenguins).

![](https://github.com/allisonhorst/palmerpenguins/raw/master/man/figures/lter_penguins.png)

### load packages



```r
library(palmerpenguins) 
library(tidyverse)
```
### read in data

```r
penguins <- penguins

glimpse(penguins)
```

```
## Rows: 344
## Columns: 8
## $ species           <fct> Adelie, Adelie, Adelie, Adelie, Adelie, Adelie, Adel…
## $ island            <fct> Torgersen, Torgersen, Torgersen, Torgersen, Torgerse…
## $ bill_length_mm    <dbl> 39.1, 39.5, 40.3, NA, 36.7, 39.3, 38.9, 39.2, 34.1, …
## $ bill_depth_mm     <dbl> 18.7, 17.4, 18.0, NA, 19.3, 20.6, 17.8, 19.6, 18.1, …
## $ flipper_length_mm <int> 181, 186, 195, NA, 193, 190, 181, 195, 193, 190, 186…
## $ body_mass_g       <int> 3750, 3800, 3250, NA, 3450, 3650, 3625, 4675, 3475, …
## $ sex               <fct> male, female, female, NA, female, male, female, male…
## $ year              <int> 2007, 2007, 2007, 2007, 2007, 2007, 2007, 2007, 2007…
```

### use group_by() and summarise() to get standard error by condition (aka species)

```r
penguins %>%
  group_by(species) %>%
  summarise(mean = mean(flipper_length_mm, na.rm = TRUE), 
            n = n(), 
            stdev = sd(flipper_length_mm, na.rm = TRUE), 
            stderr = stdev/sqrt(n)) 
```

```
## # A tibble: 3 x 5
##   species    mean     n stdev stderr
##   <fct>     <dbl> <int> <dbl>  <dbl>
## 1 Adelie     190.   152  6.54  0.530
## 2 Chinstrap  196.    68  7.13  0.865
## 3 Gentoo     217.   124  6.48  0.582
```





