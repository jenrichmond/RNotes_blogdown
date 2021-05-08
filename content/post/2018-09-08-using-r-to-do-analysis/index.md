---
title: using R for analysis
author: ''
date: '2018-09-08'
slug: using-r-for-analysis
categories: []
output:
  html_document:
    keep_md: yes
---

I am feeling more confident about my resolution to get rid of Excel and only use R for data wrangling and visualisation. Next steps... analysis. 

I'm starting simple (I presume) with t-tests. Mostly commonly I want to determine whether there is a difference in the performance of independent groups of kids, or a difference between kids' performance on two different conditions, or whether kids are just guessing (i.e. whether their performance differs significantly chance). 


So I need to learn how to do:

- independent samples t-tests
- paired samples t-tests
- one-sample t-tests

#### Where to start?

Lets see what the AMAZING [Dani Navarro](@djnavarro) says about t-tests in her free online stats resources [found here](https://compcogscisydney.org/psyr/). If you are looking for her whole "Learning Statistics with R book" (also free) [find it here](https://compcogscisydney.org/learning-statistics-with-r/). 

Note: Dani also suggests looking at Matthew Crumps book "Answering questions with data" which has adapted some of her content, [find it here](https://crumplab.github.io/statistics/)

The functions Dani describes in her book are part of a package she wrote to accompany the book called `lsr`. This package includes separate commands for different kinds of t-test.

Apparently R also comes with a function t.test() that has a paired = TRUE/FALSE argument so you can specify whether you want a paired or independent samples test. 

See AFL post for comparisons...


