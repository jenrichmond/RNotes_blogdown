---
title: creating data using rep()
author: ''
date: '2018-09-07'
slug: creating-data-using-rep
categories: []
output:
  html_document:
    keep_md: yes
---

The frequency with which my data is missing important information when it gets to R is a bit embarrassing. I'm sure as I learn what kind of information R needs I'll get better at this but for the moment using functions like `rep()` to create variables like trial number or block has been super useful. 

Alison Smith has a great blog called [Very Statisticious](https://aosmith.rbind.io/) and her post about simulating data is super helpful. [Find it here](https://aosmith.rbind.io/2018/08/29/getting-started-simulating-data/)

Some code that is probably going to be useful in the future: 

To get AAABBB use

```
rep(letters[1:2], each = 3)

```
To get 1 through 8, repeated 3 times use

```
rep(1:8, times = 3)

```
Also I recently used this code to get information about trialtype/condition out of an ugly and very untidy CommentName variable

```
mutate(Stimulus = CommentName[[8]]) 
```

This creates a new variable called Stimulus that grabs the 8th value of CommentName and fills the column with it. Note this only works after grouping by Participant, Block, Bin. 







