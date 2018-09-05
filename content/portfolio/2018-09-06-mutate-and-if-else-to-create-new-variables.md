---
title: mutate + if else = new conditional variable
author: ''
date: '2018-09-07'
slug: mutate-and-if-else-to-create-new-variables
categories: []
tags: []
---

I keep googling [these slides](https://rstudio-pubs-static.s3.amazonaws.com/116317_e6922e81e72e4e3f83995485ce686c14.html#/1) by [David Ranzolin](@daranzolin) each time I try to combine mutate with ifelse to create a new variable that is conditional on values in other variables. 

Most recently I needed to extract a Stimulus number from a variable called CommentName, and then turn those numbers into levels of Model and Emotion in separate columns. 

#### Ugly but functional code below

This chunk takes the cleanedup data, groups by Participant, Block, and Trial, pipes to a mutate function which adds a new column called Stimulus that lists the values in the 8th position [[8]] of the CommentName Variable (that is the comment that specifies the Model/Emotion condition). Then it pipes that into another mutate creating a new columns called Model and Emotion that include values of child/adult and happy/angry, depending on the Stimulus value.  

```{r}
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
