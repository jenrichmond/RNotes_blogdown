---
title: mutate + if else = new conditional variable
author: ''
date: '2019-08-21'
slug: mutate-and-if-else-to-create-new-variables
output:
  html_document:
    keep_md: yes
---

I keep googling [these slides](https://rstudio-pubs-static.s3.amazonaws.com/116317_e6922e81e72e4e3f83995485ce686c14.html#/1) by [David Ranzolin](@daranzolin) each time I try to combine mutate with ifelse to create a new variable that is conditional on values in other variables. 

<!--more-->

Most recently I needed to extract a Stimulus number from a variable called CommentName, and then turn those numbers into levels of Model and Emotion in separate columns. 

#### Ugly but functional code below

This chunk takes the cleanedup data, groups by Participant, Block, and Trial, pipes to a mutate function which adds a new column called Stimulus that lists the values in the 8th position [[8]] of the CommentName Variable (that is the comment that specifies the Model/Emotion condition). Then it pipes that into another mutate creating a new columns called Model and Emotion that include values of child/adult and happy/angry, depending on the Stimulus value.  


```r
trialtype <- cleanedup %>%
  group_by(Participant, Block, Trial) %>%
  
  mutate(Stimulus = CommentName[[8]]) %>%
  
  mutate(Model = ifelse(Stimulus == "426789", "child",
                    ifelse(Stimulus == "426790", "child",
                    ifelse(Stimulus == "426783", "adult",
                    ifelse(Stimulus == "426784", "adult", "no"))))) %>%
  
  mutate(Emotion = ifelse(Stimulus == "426789", "angry",
                    ifelse(Stimulus == "426790", "happy",
                    ifelse(Stimulus == "426783", "happy",
                    ifelse(Stimulus == "426784", "angry", "no")))))
```

#### update August 2019..... case_when

ifelse works fine for creating new conditional variables when all the information you need to create that variable is in 1 column. But in the TwoRooms data I have been dealing with recently, I have separate columns that contain FALSE or NA according to whether the kid failed because they didn't remember, they chose incorrectly, or they didn't justify their decision by referring to the future. In order to pass the task they kinda have to remember, then choose, then justify, so I need the failure reason to default to that order. If they remember, but then don't choose correctly and don't justfy, I need the failure reason to be "choice". If they dont remember, but choose correctly and but don't justify their decision by referring to the future (which would be weird), I need it to say they failed because of memory. 

[case_when](https://dplyr.tidyverse.org/reference/case_when.html) evaluates arguments in order, which is helpful. 

Here we create a new column using mutate, the values of which are either memory, choice, or justification, depending on whether P1memory, P1choice, or P1future (in that order) are == FALSE. SUPER helpful!!

```
whyfailP1 <- gatherP1fail %>%
  filter(pass == FALSE) %>%
  arrange(Group) %>%
  tidyr::pivot_wider(names_from = DV, values_from = pass) %>%
  mutate(failreason = case_when(P1memory == "FALSE" ~ "memory", 
                                P1choice == "FALSE" ~ "choice",
                                P1future == "FALSE" ~ "justification"))
                                
```
