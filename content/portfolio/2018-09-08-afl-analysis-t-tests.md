---
title: AFL analysis (t-tests)
author: ''
date: '2018-09-08'
slug: afl-analysis-t-tests
categories: []
tags:
  - analysis
  - ttest
---

### TAKE HOME MESSAGE

Here is what I learned about t-tests from doing the analysis below.

#### From the `lsr` package
I like that the `lsr` has separate functions for each kind of t-test. I can see how that will make it easier for students to think about the differences between each test, and the arguments that each one requires. 
The output from the `lsr` is also REALLY nice. It includes useful things like Cohens D by default. Important to make sure you are working with a dataframe though. The code is old and doesn't deal with tibbles. 

```
oneSampleTTest(dataframe$testcolumn, mu=100)

pairedSamplesTTest(~ variable1 + variable2, dataframe) #note if data is long you also need to specify "id"

independentSamplesTTest(outcome ~ group, dataframe)
```
#### Using standard `t.test` method

```
t.test(dataframe$testcolumn, mu = 100)
t.test(dataframe$variable1, dataframe$variable2, paired=TRUE)
t.test(dataframe$outcome ~ dataframe$group, paired=FALSE)
```
### Analysing the AFL data

#### Load packages
```
library(tidyverse)
library(lsr)
```
```{r include=FALSE}
library(tidyverse)
library(lsr)
```

#### Read the data
Note: `lsr` package does not like tibbles. Best to use read.csv or as.dataframe to make sure you are working with a df. 

```{r}
afl <- read.csv("afl.csv")

homeawaygames <- afl %>%
  select(home_score, away_score, game_type, attendance)
```

```{r}
names(homeawaygames)
```

### AFL data questions

#### Question 1: does the home team score more than 100 points on average each game? 

Maybe we know that the average AFL team score around 100 points in a game. Do home teams score more than 100?

##### The `lsr` one sample t test

```{r}
oneSampleTTest(homeawaygames$home_score, mu=100)
```
Interesting, on average yes, the home team does score more than 100. What about the away team?

```{r}
oneSampleTTest(homeawaygames$away_score, mu=100)
```
Also significant, but this was a 2 sided test, so this significant result tells us that on average the away team scores significantly less than 100 points. 

##### The t.test one sample t test
The format is mostly the same for the t.test version; output not as nice. 
```{r}
t.test(homeawaygames$home_score, mu = 100)
t.test(homeawaygames$away_score, mu = 100)
```


#### Question 2- do teams playing at home score more than teams playing away? 

In the afl dataset, each game (like participant) gives a score for the home team and the away team. In that sense the score data is paired.

##### The `lsr` paired samples t test

The `lsr` package pairedSamplesTest() function looks a bit different if the data is wide vs long. If the data is wide, you need to just tell in the names of the variables to compare and the data set. 

```
WideTest <- pairedSamplesTTest(
  formula = ~ variable1 + variable2, 
  data = dataframe 
)
```
Paired samples t test the `lsr` way (longform)
```{r}
pairedSamplesTTest(
formula = ~ home_score + away_score, 
data = homeawaygames 
)
```

Paired samples t test the `lsr` way (shortform)

```{r}
pairedSamplesTTest(~ home_score + away_score, homeawaygames)
```
Take home message, home teams score more points that away teams. 

NOTE: If the data is long, you also need to tell it the 'ID' column. 
```
LongTest <- pairedSamplesTTest(
  formula = ~ variable1 + variable2, 
  data = dataframe, 
  id = "id" 
)
```
#####  The `t.test` paired samples t test 

Alternatively the basic t.test function does the same with less digestable output. 

```
t.test(y1, y2, paired=TRUE)

```
```{r}
t.test(homeawaygames$home_score, homeawaygames$away_score, paired=TRUE)

```
t.test output definitely not as nice. 

#### Question 3: Is attendance higher at finals games than regular season games? 

Lets group by game type and calculate the mean number of people attending finals vs regular games. Seems like attendance is higher for finals. Is that significant? 

```{r}
homeawaygames %>% 
  group_by(game_type) %>%
  summarise(meanpeople = mean(attendance)) %>%
  ggplot(aes(x = game_type, y= meanpeople)) +
  geom_col()
```

##### The `lsr` independent samples t test 

R t-test uses the Welch method (for unequal variance) by default. Need to change var.equal = TRUE to use Student t-test method. 

```
independentSamplesTTest(
  formula = outcome ~ group, 
  data = dataframe
  var.equal = FALSE
)
```

Independent samples t test the `lsr` way (longform)

```{r}
independentSamplesTTest(
  formula = attendance ~ game_type, 
  data = homeawaygames,
  var.equal = FALSE
)
```

Independent samples t test the `lsr` way (shortform)

```{r}
independentSamplesTTest(attendance ~ game_type, homeawaygames)
```

#####  The `t.test` independent samples t test 

Alternatively the basic t.test function does the same with less digestable output. y1 = outcome, y= group.

```
t.test(y1 ~ y2, paired=FALSE)

```
```{r}
t.test(homeawaygames$attendance ~ homeawaygames$game_type, paired=FALSE, var.equal = FALSE)

```

