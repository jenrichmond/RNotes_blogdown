---
title: Just Three Things
author: ''
date: '2019-02-19'
slug: just-three-things
categories: []
tags: []
output:
  html_document:
    keep_md: yes
---

I love me a good \#rstats screencast. [David Robinson](@drob) has been screencasting his \#TidyTuesday efforts for the past few months and while it is GREAT to [watch a master at work](https://www.youtube.com/channel/UCeiiqmVK07qhY-wvg3IZiZQ), I just don’t have time to watch someone code for an hour, in order to extract a handful of tips.

So when I saw [Nick Tierney](@nj_tierney) tweet about posting short videos that contain Just Three Things, I thought “that is a GREAT idea.”

<blockquote class="twitter-tweet" data-lang="en">
<p lang="en" dir="ltr">
A little while ago I showed <a href="https://twitter.com/_inundata?ref_src=twsrc%5Etfw">(**\_inundata?**)</a> scales::percent, and he said something along the lines of:<br><br>“There should be a high quality screencast where someone shows a couple of <a href="https://twitter.com/hashtag/rstats?src=hash&amp;ref_src=twsrc%5Etfw">\#rstats</a> tricks and that's it.”<br><br>Not sure about high-quality, but here is a thing!<a href="https://t.co/cKRsHQaCVB">https://t.co/cKRsHQaCVB</a>
</p>
— Nicholas Tierney ((**nj\_tierney?**)) <a href="https://twitter.com/nj_tierney/status/1097382536483811330?ref_src=twsrc%5Etfw">February 18, 2019</a>
</blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

The question is which 3 things will I start with?

Here is the video

``` r
blogdown::shortcode("youtube", "vWvtFSQXTLE")
```

{{% youtube "vWvtFSQXTLE" %}}

## 1. janitor::clean\_names()

The `janitor` package is full of helpful tricks and `clean_names` is one of things that is at the top of every one of my analyses by default. It automatically converts all of your variable names to lower case, and puts underscores in the gaps. Awesome.

Generally, I call tidyverse and use read\_csv to get the data in and then check the variable names with names()

#### First load packages

``` r
library(tidyverse)
library(janitor)
```

#### Then read the data and check names

``` r
beaches <- read_csv("sydneybeaches.csv")
```

    ## 
    ## ── Column specification ────────────────────────────────────────────────────────
    ## cols(
    ##   BeachId = col_double(),
    ##   Region = col_character(),
    ##   Council = col_character(),
    ##   Site = col_character(),
    ##   Longitude = col_double(),
    ##   Latitude = col_double(),
    ##   Date = col_character(),
    ##   `Enterococci (cfu/100ml)` = col_double()
    ## )

The variable names in the beaches data are not horrible, but the capital letters are a bit of a pain and the enterococci variable- well that one is bad news

#### Then clean\_names() and use names() to check them

``` r
cleanbeaches <- clean_names(beaches)

names(cleanbeaches)
```

    ## [1] "beach_id"              "region"                "council"              
    ## [4] "site"                  "longitude"             "latitude"             
    ## [7] "date"                  "enterococci_cfu_100ml"

The enterococci\_cfu\_100ml variable is still not something you would want to type too often but it is definitely better!

## 2. Eat your pancakes

I am a markdown girl and love how the stack of “pancakes” in the top right of your markdown document will give you an outline of your document by levels of heading. It makes it super easy to navigate your way around a long analysis document.

Did you know that you can do the same thing in a R script?

When you are writing notes to yourself in a script, you use hash to demarcate pieces of text that comments rather than code. Simply put 4+ dashes at the end of your comment and it will appear in your pancake list.

**\# this is a heading I want to appear in my pancake list, 4+dashes —-**

## 3. hotkeys

As you get better at R, there are occasions where it woould be good for your fingers to keep up with your brain. Hotkeys help you write code faster.

Ones I use a lot (note: these are mac versions)

> The pipe = Shift-Command-M %&gt;%

> A new markdown chunk = Option-Command-I

> Run the chunk you are in = Command-Enter

There are [heaps of hotkeys](https://support.rstudio.com/hc/en-us/articles/200711853-Keyboard-Shortcuts) built into Studio, but you can [customise them](https://support.rstudio.com/hc/en-us/articles/206382178?version=1.1.383&mode=desktop) or make your own.
