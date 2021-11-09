---
title: next up anova
author: ''
date: '2018-09-12'
slug: next-up-anova
categories: []
output:
  html_document:
    keep_md: yes
---

In the kind of research that we do, t-tests can only take you so far. Most often we design factorial experiments where we are interested in both main effects and interactions.  Because we work with infants and young children, who are both expensive to recruit/test and notoriously variable in their behaviour, we try to design experiments that use within-subjects designs; each child gives us more than one data point and we need to use repeated-measures analyses. 

Next I need learn how to conduct ANOVA in R. 

Notes from "Learning Statistics with R book" [find it here](https://compcogscisydney.org/learning-statistics-with-r/).

#### Using the aov() function 

The `aov()` function expects two things

1. the formula- specify which variable is your outcome and which are your grouping variables

2. the data- which dataframe are you analysing

##### An example

In a clinical trial where you are looking to see if the drug improved mood scores you might specify...

```
aov(formula = mood ~ drug, data = clinicaltrial)

```

As always,you can shortcut that by saying

```
aov(mood ~ drug, clinicaltrial)

```

Or by specifying which variables to analyse using data$column .

```
aov(clinicaltrial$mood ~ clinicaltrial$drug)

```

It is a good idea to assign your analysis to an object...

```
myANOVA <- aov(mood ~ drug, clinicaltrial)

```

... so that you can then use print(myANOVA) to get terms, sums of squares, degrees of freedom, or probably more usfully, use summary(myANOVA) to get F and p values.  


#### Effect size

Need to get effect sizes? In the `lsr` package there is a function called `etasquared()`. To get eta or partial eta squared values to report in your paper...

```
etasquared(myANOVA)
``` 

#### So you have a significant effect, what now?

If there are more than 2 groups, you need to do follow up analyses to determine what is going on. 

Option 1.  

Create subsets of data and do t-tests on all combinations. 

Option 2

Conduct pairwise t-tests: R has a function `pairwise.t.test()` but apparently you can't just hand it an aov object and have it know what to do with it. So, the very kind Dani has created another function in the `lsr` package called `posthocPairwiseT()` that, given your myANOVA object will just run all the tests for you. 

Note: the default correction is Holm, so if you don't specify a correction it will do that by default. If you don't want correction you need to specify p.adjust.method = "none"

###### Corrections for multiple comparisons
We all know that many many t-tests can get you into trouble. If you are going to do it, you should correct for the fact that you are doing it. 

**Bonferroni corrections**

So nice! the `posthocPairwiseT()` has an argument so you can call to say p.adjust.method = "bonferroni"

```
posthocPairwiseR(myANOVA, p.adjust.method = "bonferroni")
```
**Holm corrections**

I'm going to be honest and say my stats education has let me down. I have NEVER heard of a Holm correction, but according to Dani it is the best one, so what is it? Apparently it acts like you are doing your multiple tests sequentially and sorts your p-values.  The biggest one stays the same, the next one is doubled, then the third is tripled. It has the benefit of having a lower Type II error rate than Bonferroni but the same Type I error rate. NOTE to SELF: no need to ever use Bonferroni again. 

Again in `lsr` Holm is the default, so you don't have to specify a p.adjust.method

```
posthocPairwiseR(myANOVA)
```

Next post... ANOVA assumptions

