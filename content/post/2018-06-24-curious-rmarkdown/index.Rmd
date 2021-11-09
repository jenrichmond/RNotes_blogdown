---
title: curious
author: Jen Richmond
date: '2018-06-24'
slug: curious-rmarkdown
categories: []
tags: 
 - tips
output:
  html_document:
    keep_md: yes
---

What a treat it was to finally meet [Charles Gray](https://twitter.com/cantabile) when she was in Sydney last week. She ran her R-Curious workshop for us and I picked up so many useful markdown tips. 


We worked from an Rmarkdown document in the workshop so we could edit the code and add our own notes but we could also how Charles had used specific markdown formatting to produce the document. 

Because it was a "lets start at the very beginning" workshop, made me realise that when you teach yourself how to code, there are basic (but quite useful) that you don't end up learning via osmosis. Markdown notation might be one of those things. 

<iframe width="560" height="315" src="https://www.youtube.com/embed/dbsJ2DZoiQI?start=10" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

## Markdown tips for the R-Curious

### 1. Make headings using hashtags 

Use a single # for big headings, two ## for smaller headings and three ### for even smaller headings

# Big heading
## Smaller heading
### Even smaller heading

### 2. Link to websites

Using a combination of square and round brackets. Put the text you want to appear in the doc in square brackets and the url in round brackets 

`[text for the link](url to link to)`

i.e.

`[Hadley Wickham RforDataScience](http://r4ds.had.co.nz/)`

[Hadley Wickham RforDataScience](http://r4ds.had.co.nz/)

### 3. Insert bullets with a dash

- Levels of bullets 
    - can be achieved with 
        - EXACTLY 4 spaces on each indent

### 4. Make package names appear highlighted by putting them in backticks (same key as ~)

i.e
Load `tidyverse` by using the function `library(tidyverse)`

### 5. Italicise and bold

Change the formatting to italics but putting things them in `*singleasteriks*` or bold by putting them in `**doubleasteriks**`


### 6. RStudio navigation tips I didn’t know about

- View a script outline by toggling the grey stack of wonky pancakes at the top right of the script window (along from Run)
- Switch projects from the top right pull down above the environment pane. 


