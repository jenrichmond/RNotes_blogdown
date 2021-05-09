---
title: making memes in R
author: ''
date: '2019-07-27'
slug: making-memes-in-r
image: "img/kitty.jpg"
categories: []
tags: []
output:
  html_document:
    keep_md: yes
---



I having been prepping for my lightning talk at the R-Ladies Sydney Birthday this weekend and learning about all the packages that you can use to make memes in R. I'm going going to talk about my favourite option (which is the `memery` package), but here is what I learned about other packages. 

## Option 1: `memer` 

The `memer` package by [Sam Tyner](https://github.com/sctyner/) is a tidyverse compatible package that allows you to replace text in popular memes with your own. 

Check out the [memer vignette](https://github.com/sctyner/memer) here. 

### install the package


```r
devtools::install_github("sctyner/memer")
```

### load the package, get a list of available memes


```r
library(memer)
meme_list()
```

```
##  [1] "AllTheThings"       "AmericanChopper"    "AncientAliens"     
##  [4] "BatmanRobin"        "DistractedBf"       "EvilKermit"        
##  [7] "ExpandingBrain"     "FirstWorldProbs"    "FryNotSure"        
## [10] "HotlineDrake"       "IsThisAPigeon"      "NoneOfMyBusiness"  
## [13] "CheersLeo"          "OneDoesNotSimply"   "DosEquisMan"       
## [16] "OffRamp"            "OprahGiveaway"      "Philosoraptor"     
## [19] "PicardFacePalm"     "PicardWTH"          "Purples"           
## [22] "PutItPatrick"       "Rainbow"            "ShiaJustDoIt"      
## [25] "Spongebob"          "SuccessKid"         "ThatWouldBeGreat"  
## [28] "TheRockDriving"     "ThinkAboutIt"       "TrumpBillSigning"  
## [31] "TwoButtonsAnxiety"  "WhatIfIToldYou"     "CondescendingWonka"
## [34] "YoDawg"             "Y-U-NOguy"
```

### choose a meme

```r
meme_get("OprahGiveaway") 
```

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-3-1.png" width="250" />

### replace the text with your own

```r
meme_get("OprahGiveaway") %>%
  meme_text_bottom("Happy Birthday \n R-Ladies Sydney!")
```

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-4-1.png" width="250" />

Some memes of the memes that come with the `memer` package have more than 1 text field. Thank you Mr Trump. 


```r
meme_get("TrumpBillSigning") %>% 
  meme_text_trump("R-Ladies Sydney", "Happy Birthday")
```

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-5-1.png" width="250" />

If you have the `rtweet` package and a twitter token set up, you can tweet your meme straight from R using the meme_tweet() function. I didn't work that out... yet. 


##Option 2: `meme`

You can use the `meme` package by [GuangchuangYu](https://github.com/GuangchuangYu/) to add meme text to any image. 

Check out the [meme vignette](https://cran.r-project.org/web/packages/meme/vignettes/meme.html) here. 


### install package


```r
devtools::install_github("GuangchuangYu/meme")
```

> note: I had much more difficulty making this package work. You need to have the `sysfonts` package, and if on a Mac, it might help to install XQuartz. See [issue here](https://github.com/GuangchuangYu/hexSticker/issues/18)

### load the package


```r
library(meme)
```

> note: both the `meme` package and the `memery` package below have a meme() function. Use package::function to specify which one you want to use. 

### load an image, then add the text

The example from the vignette loads an image that is in the meme package (using the `system.file()` function) and adds text on top. 


```r
pic1 <- system.file("success.jpg", package="meme")

meme::meme(pic1, "code", "all the things!") 
```

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-8-1.png" width="672" />

But you can load any image and add text to it. 


```r
meme::meme("kitten.jpg", "am i in your way?") 
```

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-9-1.png" width="672" />

A bit like ggsave() you can use meme_save() to save memes to jpg or png. 


```r
library(tidyverse) #so you can pipe
```


```r
meme::meme("kitten.jpg", "am i in your way?") %>%
  meme_save("kitty.jpg")
```

#Option 3: `memery` 

The `memery` package by [Matthew Leonawicz](https://github.com/leonawicz) ended up being my favourite option because it is easy to make basic memes as above, but you can also make memed gifs, integrate ggplots AND there is a shiny app associated with it. 

Check out the [memery vignette here](https://cran.r-project.org/web/packages/memery/vignettes/memery.html). 


### install the package

```r
install.packages("memery")
```

### load the package


```r
library(memery)
```
> note: both the `meme` package and the `memery` package have a meme() function. Use package::function to specify which one you want to use. 

### define the image, text, and put them together

The example in the vignette first loads a picture from the package (again using the `system.file()` function)


```r
pic <- system.file("philosoraptor.jpg", package = "memery")
```

Then defines a list of text possibilities. 

```r
txt <- c("What to call my R package?", "Perhaps...")
```

Then the makes a meme by putting the pic and text together, and saves to jpg, all in one step. 

> reknitting my blog and this is now throwing an error "Error in showtext_begin_internal(record = FALSE) : no active graphics device"


```r
memery::meme(pic, txt[1], "dino1.jpg")
```

You can also get the pic from the internet. 


```r
web <- "https://imgflip.com/s/meme/Philosoraptor.jpg"

memery::meme(web, txt[2], "dino2.png")
```


It is super easy to add meme text to your own image.  If your list of text possibilities is 2 items long and you don't specify which to use (as above txt[1]), it will by default put text at the top and bottom. Here we use the kitten.jpg image again.

```r
txt2 <- c("Am I in your way?", "I'm too cute to work!")

memery::meme("kitten.jpg", txt2, "kitty1.jpg")
```


You can also change the colour and shadow of the text by defining a list of clrs (colours), and then calling col (for colour) and shadow.

```r
clrs <- c("blue", "pink")

memery::meme("kitten.jpg", txt2, "kitty2.jpg", col = clrs[1], shadow = clrs[2])
```

![](/post/2019-07-27-making-memes-in-r_files/kitty2.jpg)

### make memed gifs

The `memery` package also has a meme_gif() function will take a gif link and overlay meme text on it. 


```r
img <- "https://media.giphy.com/media/OUwzqE4ZOk5Bm/giphy.gif"

lab <- c("memery", "magic")

pos <- list(w = rep(0.9, 2), h = rep(0.3, 2), x = rep(0.5, 2), y = c(0.9, 0.75))

meme_gif(img, lab, "HP.gif", size = c(1.5, 0.75), label_pos = pos, fps = 20)
```

I didn't really work out the size and position on this one and I'm not sure why the frames are flickery, so it needs some work. But you get the idea. 


### `memery` also has a shiny app

The `memery` package has a shiny app that you can call using memeApp(). It is designed to demo the package. [Read about it here](https://cran.r-project.org/web/packages/memery/vignettes/memery.html). 


#Option 4: Are you looking for a meme project ? 

In my googling, I also found another [package called `meme`](https://github.com/leeper/meme) by Thomas Leeper that is not currently being maintained. It uses the memecaptain API and the link to those meme templates is currently broken. If you are looking for a super fun project, this meme package is [looking for a new maintainer](https://github.com/leeper/meme/issues/6)!








