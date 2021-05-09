---
title: idhtg how to use colour palettes with ggplot
author: ''
date: '2020-10-22'
slug: idhtg-how-to-use-colour-palettes-with-ggplot
image: "img/brewer.jpeg"
output:
  html_document:
    keep_md: yes
---

If I had a dollar for everytime I have googled how to change the colours in my ggplot...it is clearly time for a "I don't have to google" post about it. 



```r
library(tidyverse)
library(palmerpenguins)
library(RColorBrewer)
library(harrypotter)

penguins <- penguins
```

# make a couple of basic plots

When dealing with geom_point(), you can use colour to change the colour of the points. For geom_col(), you need to use fill; colour will change the border around your bars. 

### Plot 1: scatter plot flipper length by body mass, colour by species

```r
penguin_point <- penguins %>%
  ggplot(aes(x = flipper_length_mm, y = body_mass_g, colour = species)) +
  geom_point()

penguin_point
```

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-2-1.png" width="672" />


### Plot 2: mean body mass by sex and species, fill by sex 


```r
mean_mass <- penguins %>%
  na.omit() %>%
  group_by(species, sex) %>% 
  summarise(mean_mass = mean(body_mass_g, na.rm = TRUE)) 
```

```
## `summarise()` has grouped output by 'species'. You can override using the `.groups` argument.
```

```r
penguin_col <- mean_mass %>%
  ggplot(aes(x = sex, y = mean_mass, fill = sex)) +
  geom_col() +
  facet_wrap(~ species) 

penguin_col 
```

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-3-1.png" width="672" />


# use RColourBrewer to automatically change the colours

Useful [RColourBrewer blog post](https://www.datanovia.com/en/blog/the-a-z-of-rcolorbrewer-palette/#:~:text=RColorBrewer%20is%20an%20R%20package,and%20in%20R%20base%20plots.) for reference.

See all the palettes using display.brewer.all()


```r
display.brewer.all()
```

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-4-1.png" width="672" />


This package includes 3 types of palettes: 

- sequential (low to high)
- qualitative (best for categorical data)
- diverging (extremes on the ends)


Most of the time I am looking to colour categorical variables so those in the middle work best.


```r
penguin_point +
 scale_color_brewer(palette = "Dark2")
```

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-5-1.png" width="672" />


```r
penguin_col +
  scale_fill_brewer(palette = "Paired")
```

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-6-1.png" width="672" />

# use RColourBrewer to manually change the colours

When you are using scale_fill_brewer() or scale_colour_brewer(), R automatically assumes you want the first colours in the palette, but how do you choose individual colours?

You can look at the colours in a particular palette using display.brewer.pal() and get the hexidecimal values corresponding to each colour using brewer.pal()


```r
# View a single RColorBrewer palette by specifying its name
display.brewer.pal(n = 8, name = 'Dark2')
```

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-7-1.png" width="672" />

```r
# Hexadecimal color specification 
brewer.pal(n = 8, name = "Dark2")
```

```
## [1] "#1B9E77" "#D95F02" "#7570B3" "#E7298A" "#66A61E" "#E6AB02" "#A6761D"
## [8] "#666666"
```

Then can use scale_colour_manual() to choose particular colours, as you would if you were naming colours. Just use the hexidecimal values instead. 

 

```r
penguin_point +
 scale_color_manual(values = c("red", "blue", "green"))
```

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-8-1.png" width="672" />
 


```r
penguin_point +
 scale_color_manual(values = c("#E7298A", "#66A61E", "#E6AB02"))
```

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-9-1.png" width="672" />



```r
penguin_col +
  scale_fill_manual(values = c("purple", "orange"))
```

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-10-1.png" width="672" />


```r
brewer.pal(8, "Paired")
```

```
## [1] "#A6CEE3" "#1F78B4" "#B2DF8A" "#33A02C" "#FB9A99" "#E31A1C" "#FDBF6F"
## [8] "#FF7F00"
```

```r
penguin_col +
  scale_fill_manual(values = c("#B2DF8A", "#33A02C"))
```

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-11-1.png" width="672" />



# Other palette options to explore

[wesanderson inspired palettes](https://github.com/karthik/wesanderson)

[harrypotter inspired palettes](https://github.com/aljrico/harrypotter)

[NZ bird inspired palettes](https://g-thomson.github.io/Manu/)

Or use this [blog from Anna Henschel](https://github.com/annahensch/R-tutorials/blob/master/ggplot-on-fire.md) to make your own palette!


