---
title: things i googled this week
author: ''
date: '2018-10-08'
slug: things-i-googled-this-week
categories: []
tags: []
output:
  html_document:
    keep_md: yes
---


How would we learn R if not for google? Here are some things I googled this week (and mostly not for the first time). 

##### 1. how to install a package from github.

95% of the time, packages I want are on CRAN and I can just use the `install.packages` function to install them. 

```
install.packages("nameofthepackage")

````

Occasionally though, I see something cool and new on Twitter and need to install from github. Everytime I forget that you need to use devtools. 

```
library(devtools)
install_github("authorname/packagename")

```

##### 2. how to read data from github.

Sometimes data in a .csv file is hosted on github and it is faster to just read it from there than to download the .csv and then read it back in. 

In github, click the "Raw" button and then copy the url link.  Use the `geturl` function from the `RCurl` package. 

```
dataframe <- read.csv(text=getURL("URLlink_from_github_raw.csv"), header = T)
```

UPDATE: I learned from a [Dave Robinson's Tidy Tuesday Screencast](http://varianceexplained.org/r/tidy-tuesday-college-major/) this week that the read_csv will read from a github url with even less code. 

```
dataframe <- read_csv("URLlink_from_github_raw.csv", header = T)
```
##### 3. how to get p values to be listed NOT in scientific notation.

just add... 

```
options(scipen =999)
```

...to the top of the analysis chunk

##### 4. how to get ggplots out of R.

After each plot chunk, add

```
ggsave(nameoffigure.png)

```

to make the figure save as a png to the working directory. 

##### 5. how to get a pivot table

Pivot tables might me what I miss about excel the most. Sometimes you just want to eyeball a data set in a way that breaks down the observations into a table where you can cross variables and count them or average them. 

How to do that in R?

If you want to know just how many observations belong to a single category the `table()` function is nice. 

```
table(dataframe$variablename)

```
How many flowers of each species make up the iris dataset?


```r
table(iris$Species)
```

```
## 
##     setosa versicolor  virginica 
##         50         50         50
```


If you want to compute something rather than just counting observations, combining group_by and summarise is a good option. 

```r
iris %>%
  group_by(Species) %>%
  summarise(mean_Petal = mean(Petal.Length), 
            count_flowers= n())
```

```
## # A tibble: 3 x 3
##   Species    mean_Petal count_flowers
##   <fct>           <dbl>         <int>
## 1 setosa           1.46            50
## 2 versicolor       4.26            50
## 3 virginica        5.55            50
```

