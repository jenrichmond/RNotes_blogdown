---
title: infinite moon reader
author: ''
date: '2019-01-03'
slug: infinite-moon-reader
categories: []
tags: []
output:
  html_document:
    keep_md: yes
---
 
I saw an intriguing tweet this afternoon.  

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">🧙
♂️Live preview for R Markdown!<br><br>TIL that you can have a live preview of your <a href="https://twitter.com/hashtag/rstats?src=hash&amp;ref_src=twsrc%5Etfw">#rstats</a> Markdown docs!<br>Just use the infinite_moon_reader function from the xaringan package.<br>It works for all single-HTML-file outputs and even comes with a pre-made RStudio Addin!</p>&mdash; Jozef Hajnala (@jozefhajnala) <a href="https://twitter.com/jozefhajnala/status/1080535862541279232?ref_src=twsrc%5Etfw">January 2, 2019</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


When [Charles](@cantabile) was visiting for #RCurious in June, she had written her slides in `xaringan` and was raving about infinite moon reader. I assumed it was something far too fancy for us Curious types. But this tweet has me interested. 

Is this infinite moon reader thing magical or all hype? 
What does it mean by live preview? Maybe I don't have to `blogdown::serve_site()` in order to see updates on my post.


```r
knitr::include_graphics("CopyOfmoon.jpg")
```

<img src="CopyOfmoon.jpg" width="177" />



### How to use infinite moon reader

> NOTE: here I am talking about blogging etc, not about xaringan slides (which is definitely on my 2019 to learn list)

#### Step 1. 

Install the xaringan package and load it.

```
install_packages("xaringan")
library(xaringan)
```

#### Step 2. 

Open a rmd document that you are working on and in the console call `xaringan::inf_mr()` i.e. infinite moon reader. 

#### Step 3. 

Write something and use Ctrl/Command-S to save it. Your document will update automatically in the Viewer pane. 

### What's the big deal? 

Doesn't `blogdown::serve_site()` do that anyway?

Yes, when you are working in blogdown and save, it runs `blogdown::serve_site()` and updates the Viewer pane. But that is not true of all markdown instances. In `radix` or when you are just doing an analysis in a markdown document, knitting the file can be slow. 

By having `xaringan::inf_mr()` running in the console, you can have the same functionality of `blogdown::serve_site()` on all markdown documents. And you can use it in blogdown too, so you don't need different knitting tricks for different situations. 

### Is there a downside? 

While `inf_mr()` is occupying your console, it is out of action for other things. But as [Charles](@cantabile) says, that might not be a bad thing, when you are actually trying to put words on the page. 

