---
title: more wrangling tips
author: ''
date: '2018-09-11'
slug: more-wrangling-tips
categories: []
output:
  html_document:
    keep_md: yes
---

It is definitely true that it takes much longer to get your data ready for analysis than it does to actually analyse it. Apparently up to 80% of the data analysis time is spent wrangling data (and cursing and swearing). 


<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Did you know up to 80% of data analysis is spent on the process of cleaning and preparing data? - cf. Wickham, 2014 and Dasu and Johnson, 2003<br>So here is an excellent approach to data wrangling in <a href="https://twitter.com/hashtag/rstats?src=hash&amp;ref_src=twsrc%5Etfw">#rstats</a> <a href="https://t.co/tqogwNSSjN">https://t.co/tqogwNSSjN</a></p>&mdash; Miguel Á. Armengol (@miguearmengol) <a href="https://twitter.com/miguearmengol/status/1039242840184905728?ref_src=twsrc%5Etfw">September 10, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Here is another [great wrangling resource](http://rpubs.com/bradleyboehmke/data_processing), this time by [Bradley Boehmke](@bradleyboehmke). 

And if you need a rationale for why it is a good idea to acquire some wrangling skills, a quote by [Jenny Bryan](@JennyBryan)

> "Classroom data are like teddy bears and real data are like a grizzly bear with salmon blood dripping out its mouth" 

##### A few things I didn't already know about `tidyr` and `dplyr`

1. In addition to gather() and spread(), the `tidyr` package can also be used to separate() i.e. pull parts of a single variable apart into separate columns and unite() i.e. combine several columns into one. 

2. When using filter() from `dplyr`, specify group membership using %in%. Also distinct() will remove duplicate rows and slice(3:5) will subset by particular rows. 

3. When using `dplyr` summarise(), sometimes you want to count the number of participants but n() will give you the number of observations. There is an n_distinct() function that might be useful in counting the number of participants. 


