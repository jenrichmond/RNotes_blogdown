---
title: IDHTG working with factors
author: ''
date: '2020-01-13'
slug: working-with-factors
categories: []
image: "img/portfolio/forcats.jpeg"
tags: []
output:
  html_document:
    keep_md: yes
    toc: true
---

I use read_csv to read data into R and it most conservatively assumes that when you have text in a variable you are dealing characters (not factors). Of course these things are often factors so you need to explicitly convert them if you want to use the factor in an analysis or have it appear the way you want in a ggplot. 

The forcats package will do this with `as_factor` 

##### load packages

```r
library(tidyverse)
library(ggbeeswarm)
library(janitor)
```

##### create a little df


```r
df <- data.frame("pp_no" = 1:16, 
                "delay" = c("short","long"), "condition" = c("easy", "easy", "difficult", "difficult"),
                "score" = c(82, 75, 76, 72, 86, 89, 85, 87, 87, 76, 78, 85, 97, 87, 94, 87))
```


### use as_factor() 

```r
df$delay <- as_factor(df$delay)
df$condition <- as_factor(df$condition)

#check variable types with glimpse

glimpse(df)
```

```
## Rows: 16
## Columns: 4
## $ pp_no     <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
## $ delay     <fct> short, long, short, long, short, long, short, long, short, l…
## $ condition <fct> easy, easy, difficult, difficult, easy, easy, difficult, dif…
## $ score     <dbl> 82, 75, 76, 72, 86, 89, 85, 87, 87, 76, 78, 85, 97, 87, 94, …
```

##### plot it


```r
df %>%
  ggplot(aes(x = delay, y = score)) +
  geom_quasirandom() +
  facet_wrap(~ condition) +
  ylim(50,100) +
  theme_classic()
```

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-4-1.png" width="672" />

Ideally I would like ggplot to order group (short, long) and condition (easy, difficult), but at the moment this is the opposite of what I want because the default factor ordering is alphbetical. Check factor levels with levels()

### use levels() 


```r
levels(df$delay)
```

```
## [1] "short" "long"
```

```r
levels(df$condition)
```

```
## [1] "easy"      "difficult"
```

### use fct_relevel() 

You can reorder factors by other factors and all kinds of other fancy things using the `forcats` package, [vignette here](https://forcats.tidyverse.org/), but most of the time I want to do it manually. 

The `fct_relevel()` function is useful. 

> REMEMBER: to manually reorder factors the function is called fct_relevel(), NOT fct_reorder()-- gets me everytime


```r
df$delay <- fct_relevel(df$delay, c("short", "long")) 

df$condition <- fct_relevel(df$condition, c("easy", "difficult"))
```

Check levels again to make sure it has done what you want.


```r
levels(df$delay)
```

```
## [1] "short" "long"
```

```r
levels(df$condition)
```

```
## [1] "easy"      "difficult"
```

##### replot with new factor levels


```r
df %>%
  ggplot(aes(x = delay, y = score)) +
  geom_quasirandom() +
  facet_wrap(~ condition) +
  ylim(50,100) +
  theme_classic()
```

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-10-1.png" width="672" />
