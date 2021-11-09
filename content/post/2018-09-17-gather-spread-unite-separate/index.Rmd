---
title: gather spread unite separate
author: ''
date: '2018-09-17'
slug: gather-spread-unite-separate
categories: []
output:
  html_document:
    keep_md: yes
---

This content has appeared before in a dirty data post, but I still find myself googling these functions. So they deserve a post of their own. The `tidyr` package has several functions that allow you to reshape your data. They are surprisely useful; I have found myself gathering a lot, mostly to get data from "SPSS format" into something that ggplot will handle. I have also discovered the flexibility with which you can spread the data on a particular variable, do a set of computations, and then gather it back for plotting.... handy. 

#### From wide to long

Use gather(data, key, value, …)

data = the dataframe you want to morph from wide to long

key = the name of the new column that is levels of what is represented in the wide format as many columns

value = the name of the column that will contain the values

… = columns to gather, or leave (use -column to gather all except that one)


Kudos to Garrick Aden-Buie for creating these gganimation gif to illustrate tidyr processes

https://raw.githubusercontent.com/gadenbuie/tidy-animated-verbs/master/images/tidyr-spread-gather.gif

#### From long to wide

Use spread(data, key, value)

data = the dataframe you want to morph from long to wide

key = the name of the column that contains the key

value = the name of the column contains the values

#### Separate one column into many

Use separate(data, col, into)

data = dataframe

col = name of column to separate

into = character vector of new column [note- these need quotes]

separate(treatments, year_no, c(“year”, “month”))

separate() assumes you want to split on a space, period, forward slash or dash. You can give it an extra argument sep = “-” to specify what to separate on.

#### Unite many columns into one

Use unite(data, col, …)

data = dataframe

col = name of column to separate

… = bare names of columns to unite

