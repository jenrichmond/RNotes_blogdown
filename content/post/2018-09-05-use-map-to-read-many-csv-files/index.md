---
title: Use map to read many csv files
author: ''
date: '2018-09-06'
slug: use-map-to-read-many-csv-files
output:
  html_document:
    keep_md: yes
---


Dipping my toes in purrr here and replicating options from a [super useful blog post](https://serialmentor.com/blog/2016/6/13/reading-and-combining-many-tidy-data-files-in-R) I found by [ClausWilke](@clauswilke) 



#### How to use map() to read in and bind together several .csv files

##### Option 1 

The simplest option; use when your .csv files contain ID/participant and all live your working directory

Get list of .csv files called files. The code below looks for files that have .csv as part of the filename in the the working directory 


```r
files <- dir(pattern = "*.csv")
files
```
The code below takes that list of files, pipes it to a map function that runs read_csv on each file, then pipes that to a  rbind function that reduces those many files into a one dataframe called data. 


```r
data1 <- files %>%
  map(read_csv) %>% 
  reduce(rbind)
```

NOTE this method doesn't retain any info from individual files, so it is important that the individual .csv files contain an ID column like participant already. 

##### Option 2A

This is bit more complicated, use when your .csv files contain ID/participant and all live in a subfolder (i.e. Datafiles) of your working directory

The code below does the same but is useful if you want to specify where the data is. 

First define the stuff:

- data_path = where the data is 
- files = the names in that directory 

Then use those values to import data in same way. 


```r
data_path <- "./Datafiles"   
files <- dir(data_path, pattern = "*clean.csv") 

data2A <- files %>%
  map(~ read_csv(file.path(data_path, .))) %>% 
  reduce(rbind)
```

##### Option 2B

This is the same as above, except for spelling out the function(x). The ~ above is jsut a shortcut for the anonymous function(x).


```r
data_path <- "./Datafiles"   
files <- dir(data_path, pattern = "*clean.csv") 


data2B <- files %>%
  map(function(x) read_csv(file.path(data_path, x))) %>%  
  reduce(rbind)
```

##### Option 3

This is more complicated but is essential if your .csv files don't contain an ID/participant column yet. 

To keep info about each .csv, define the stuff (data_path and files), then use dataframe() to create a dataframe containing the a single variable = files, pipe that to a mutate function creating a new variable that contains each file's contents. Yes this is crazy, it actually puts the entire contents of the file in a single variable.  Use unnest() to turn that crazy single column into a useful thing. 


```r
data_path <- "./Datafiles"   
files <- dir(data_path, pattern = "*clean.csv") 

data3 <- data_frame(filename = files) %>%
  mutate(file_contents = map(filename,      
           ~ read_csv(file.path(data_path, .))) 
  )

data3useful <- unnest(data3)
```


**NOTE**

- when .csv files have a Participant/ID variable it is easiest to use Option 1. 

- when .csv files come straight from `datapasta` and don't include participant info, need to use Option 3. 

# update with a concrete example
