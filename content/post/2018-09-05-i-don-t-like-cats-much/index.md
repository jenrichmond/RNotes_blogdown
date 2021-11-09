---
title: I don’t like cats much
author: Jen Richmond
date: '2018-09-05'
slug: i-don-t-like-cats-much
output:
  html_document:
    keep_md: yes
---

I don't love cats. I am not a member of @RCatLadies. So the fact that Tidyverse packages for dealing with factors and functional programming have cat-related names (`forcats` and `purrr`) does not endear them to me. 

I knew there was a time when I would encounter an R problem that needed the power of for loops, so when I asked the Twittersphere whether there was an alternative (hopefully a tidyverse one) that would allow me to avoid loops a little longer, I was a bit disappointed to hear that it is the `purrr` package. 

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">I think the time has come, I might not be able to avoid <a href="https://twitter.com/hashtag/forloops?src=hash&amp;ref_src=twsrc%5Etfw">#forloops</a> anymore. I want to run the same set of <a href="https://twitter.com/hashtag/dplyr?src=hash&amp;ref_src=twsrc%5Etfw">#dplyr</a> operations (rename, select, filter etc) on a set of dataframes I have datapastaed into <a href="https://twitter.com/hashtag/rstats?src=hash&amp;ref_src=twsrc%5Etfw">#rstats</a>. Is there a way to say &quot;do this&quot; to files P001-P032 without using a loop?</p>&mdash; Dr Jenny Richmond (@JenRichmondPhD) <a href="https://twitter.com/JenRichmondPhD/status/1036830278629519360?ref_src=twsrc%5Etfw">September 4, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


Apparently the `map()` function in `purrr` is going to be my friend, but at the moment it is completely bewildering. I thought it might be helpful to paste all the links that the lovely rstats people on Twitter sent me so that I can keep them in one place. 

If you want to learn `purrr` this is what the Twitter experts suggest. 

### Useful purrr related blog posts/resources

#### Tips from [Alison Hill](@apreshill)

Alison's fave `purrr` learning resources are all from #rladies. I need to check out resources from

[Jennifer Thompson](@jent103) https://github.com/jenniferthompson/RLadiesIntroToPurrr

[Jenny Bryan](@JennyBryan)
https://jennybc.github.io/purrr-tutorial/ 

[Charlotte Wickham](@CVWickham)
https://github.com/cwickham/purrr-tutorial

also see: http://rstd.io/row-work 

#### Tips from [Jared Wilber](@jdwlbr)
Jared Wilber suggests that [Amber Thomas](@ProQuesAsker) resources are good
https://amber.rbind.io/blog/2018/03/26/purrr_iterations/

#### Tips from [Tom Kelly](@tomkXY)
Tom Kelly pointed me towards the @swcarpentry resources

https://swcarpentry.github.io/r-novice-inflammation/03-loops-R/index.html
https://swcarpentry.github.io/r-novice-inflammation/15-supp-loops-in-depth/


#### [Miles McBain](@MilesMcBain) says...

You can use dplyr::bind_rows() instead of reduce(rbind()). BUT if you want them all in one frame at the end you probably just want purrr::map_dfr(), which is a map and bind combo function. So many options! that's actually half the problem with going #noloops. My most commonly used fns in purrr are map(), pmap(), walk(), iwalk() and every() maybe that helps narrow it down a bit.

#### [Hendrik vanB](@hendrikvanb) says... 

This feels like an ideal purrr::map() use case.  E.g., assuming .csv files:

```
purrr::map(filepaths, function(x) {
  readr::read_csv(x) %>%
    rename(...) %>%
    select(...)  %>%
    filter(...) %>%
    etc.
})
```

#### [James Goldie](@rensa_co) says...
I use similar patterns a lot! You can:

1) map over the filename vector, immediately joining the dfs into 1 df using map_dfr and then doing your operations on the result

```
map_dfr(filepaths, read_csv) %>%
  select(...)
```  
2) map over the filename vector, doing your operations on each one inside map and then joining the result

```
map_dfr(filepaths, function(x) {
  read_csv(x) %>%
  select(...)
})
```

3) split a dataframe up into a list of dfs and map over that

```
bigdataframe %>%
  split(list(bigdataframe$group1)) %>%
  map(function(df) {
    select(...)
  })
```

#### my own googling
A little Google searching turned out this post from [Claus Wilke](@clauswilke) that outlines how to use map() to run read_csv for many files

https://serialmentor.com/blog/2016/6/13/reading-and-combining-many-tidy-data-files-in-R

Stay tuned for more purrr related posts...
