---
title: lubridate first google
author: ''
date: '2020-09-17'
slug: lubridate-googling
image: "img/datenight.jpg"
output:
  html_document:
    keep_md: yes
---

I have set myself a challenge of learning to deal with dates in R. Nothing like setting a date for an R-Ladies Sydney event where you will teach other people to spur the motivation for learning how to use the `lubridate` package. 


The plan is to learn how to use the package and document my learning process along the way so that at the end of Oct I can tell everyone...

1. how to deal with dates in R and 
2. how to learn about a new package from the very beginning

So where to start? 

Google of course. Tonight I spent a little time looking for books, blogs, youtube videos, documentation, and twitter threads about lubridate. I have no idea whether any of these links will be useful, but they will be here for reference anyway. 

### 1. books

R4DS has a [chapter about dates/times](https://r4ds.had.co.nz/dates-and-times.html). 

[vanderbult bio stat](http://biostat.mc.vanderbilt.edu/wiki/pub/Main/ColeBeck/datestimes.pdf)

[Mike Mahoney lecture book](https://bookdown.org/mikemahoney218/LectureBook/working-with-dates-and-times.html)


### 2. blogs

[Julia Silge re lubridate and theatre](https://juliasilge.com/blog/lubridate-london-stage/)

Ooooo i got excited about this one and it derailed my googling for a bit because this blog post does exactly what i think a good blog tutorial should do. The dataset is key right? You need to find a dataset that requires you to use the thing you are trying to learn, because otherwise motivations for learning something new is pretty low.  In this case Julia's blog is about history and theatre- fun! 

Reading this blog derailed my google process by making me want to jump in and mimic her process right away. I need a cool dataset to play with. Maybe the penguins have dates? Covid testing rates over time would be interesting.... 

Wait wait wait, one step at a time Jen. Compile the resources you need, and then find a dataset to work with. 

Thanks for getting me excited about the process Julia!

Rebecca Barter's blogs are always good. This post from her Tranistioning to the tidyverse series has a [little lubridate mention](http://www.rebeccabarter.com/categories/lubridate/), definitely worth coming back to. 

Random links that may be useful...

- https://www.earthdatascience.org/courses/earth-analytics/time-series-data/date-class-in-r/

- https://blog.exploratory.io/5-most-practically-useful-operations-when-working-with-date-and-time-in-r-9f9eb8a17465


### 3. you tube

I didn't look very hard on youtube, this one might be ok...

https://www.youtube.com/watch?v=46UFzO1EgBo

### 4. package documentation

https://lubridate.tidyverse.org/

Interesting that, for me, package documentation is almost the last place I look for learning inspiration. Why is that.... to unpack later. 

### 5. twitter

I learn a lot about #rstats on twitter. People post about their blog posts, or data challenges and other kind souls help them out. Links to potentially useful threads below. 

[today](https://twitter.com/JenRichmondPhD/status/1229925408688111616)

[timezones](https://twitter.com/MilesMcBain/status/1194565470906503169)

[formats](https://twitter.com/fonti_kar/status/1254570510043643904)

[here/lubridate clash](https://twitter.com/kierisi/status/1245532577932414976)

[stamp](https://twitter.com/sharlagelfand/status/1244987516987588609)

[cheatsheet](https://twitter.com/icymi_r/status/1282962590461812736)

### 6. art

I found Allison's art re lubridate on twitter, but it is SO CUTE that it deserves its own category. 


![](https://github.com/allisonhorst/stats-illustrations/raw/master/rstats-artwork/lubridate.png)

![](https://github.com/allisonhorst/stats-illustrations/raw/master/rstats-artwork/lubridate_ymd.png)

## Issues to explore

- sometimes R reads dates in as dates, and other times not
  + how to make R recognise dates as dates
  + how to work with dates once you have date format
- how to use date components (year, month, day) in plots, btw label = TRUE seems awesome
- making your raw dates be automatically read as such, how to make your date data easy for others?
- clash with here::here, new version of lubridate won't have here() function?? that was the word from Hadley Apr 3 2020- check whether there has been a new release. 




