---
title: Use map to read many csv files
author: ''
date: '2018-09-06'
slug: use-map-to-read-many-csv-files
categories: []
tags: []
---


Dipping my toes in purrr here and replicating options from a [super useful blog post](https://serialmentor.com/blog/2016/6/13/reading-and-combining-many-tidy-data-files-in-R) I found by [ClausWilke](@clauswilke) 



<!--more-->

#### How to use map() to read in and bind together several .csv files

##### Option 1 

The simplest option; use when your .csv files contain ID/participant and all live your working directory

Get list of .csv files called files. The code below looks for files that have .csv as part of the filename in the the working directory 


```r
files <- dir(pattern = "*.csv")
files
```

```
## character(0)
```
The code below takes that list of files, pipes it to a map function that runs read_csv on each file, then pipes that to a  rbind function that reduces those many files into a one dataframe called data. 









