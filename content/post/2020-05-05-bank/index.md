---
title: Spending in COVID
author: 'Jen Richmond'
date: '2020-05-05'
slug: bank
image: "img/portfolio/april.png"
output:
  html_document:
    keep_md: yes
---





There is no doubt that COVID19 has massively disrupted how we spend our time and money. In this post, I update code inspired by [this R-bloggers blog](https://www.r-bloggers.com/analyse-your-bank-statements-using-r/) to look at how much less money we have been spending on eating in the last month, compared to April 2019. 

Download a copy of your bank transactions in csv format. 

#### Load packages

```r
library(tidyverse)
library(janitor)
library(lubridate)
```


#### Read in data

Clean and rename, select just date, description, debit amount, add new column for class with default value = "Other"

```r
items <- read_csv("data_new.csv") %>%
  clean_names() %>%
  rename(desc = narrative, 
         debit = debit_amount, 
         credit = credit_amount) %>%
  select(date, desc, debit) %>%
  mutate(class = "Other")
```


#### Build regular expression strings for categories

Mostly just interested in food changes between April 2019 and April 2020. Scan transaction desc for phrases that relate to food and transport. 

```r
# Build simple regexp strings

coffeelunch <- "MOORE|T2|Grams|CAKE|LAKSA|SUBWAY|STOCK|BURGER|XCEL|Penny|KETTLE|POP|Ground|GOMEZ|FUNG|VILLAGE|Campos|Estate|ANTONIO|MCDONALDS|Gelatissimo|COFFEE|CAFE|PICCOLO|MADENTZOGLOU|YACOCO|LAYERED|LITTLE ME|Marionette|Bohaus|BAYLEAF|SOCIETY|GRAMS|HEY|Courtyard|CHARLIE'S|TROPICAL|Lounge|GUSTO|ATOMIC|Coffee|Campus|Navitas|X74|LENTIL|Espresso|Poke|Bakery|SHED|CANS|PICKLE|Hungry|FORMAGGI|BAKERY|KURTOSH|Fratelli|Buffalo|Cow|Burgers|ANDERSEN'S|Chargrill|ICHI-BAN|COCO|ARC|Cafe|Boulangerie|UNIVERSITY|Erciyes|WOOD|AMBLE|Messina|Catering|Bake"

dinnerout <- "SUSHI|MAMAK|KTCHN|BLUEBOTTLES|Little L|Bavarian|Homestead|RESTAURANT|Ringer|THAI|Mamak|Gomez|BIERHAUS|CREPERIE |MESSINA|DOMINOS|GELATISSIMO|Osteria|TwoFatIndian|Dining|WOK|Rooftop|Pizza|Beresford|JOES|STINKING|COOKHOUSE|CLUB|Club|PASTA|FISH|FOUR|TOKYO|BISTRO|CLOVE|Arthur|HANGAR|FUSION|LUMI|ROCKPOOL|EATERY|Paddington|FRANK|BAT|Brauhaus|SHINABURO|JADE|NAKAJIMA|ITALIAN|INDIAN|TAVERN|Foodora|WPIZZA|SALUD|BETTYS|COFFS|Milky|BREW|PIZZA"


groceries <- "WW|COLES|WOOLWORTHS|Harris|MALONEYS|FRESH|CATERING|DELI|MARYDIAS|SEAFOOD|CAKE|BAKERS|IGA|SWEET|HOA|FARM|COUNTDOWN|WORLD|BUTCHRY|MARKET|FOODWORKS|ALDI|FOOD|HFM|PLAZA|Fine Foods|BALDICO|HILLVIEWFIN|KINGSMORE"
```

#### Use grepl to assign class value to each transaction

grepl is a weird thing. I think this checks if the value in `items$desc` matches something in the regexp defined for groceries (for example) and if it does puts Groceries in the `items$class` column

```r
#assign values to class column based on regexp
   
items$class <-  
  ifelse(grepl(coffeelunch, items$desc),"CoffeeLunch",
      ifelse(grepl(dinnerout, items$desc),"Dinnerout",
                   ifelse(grepl(groceries, items$desc),"Groceries",
                                   "Other")))
```


#### Remove NAs and fix dates

```r
list_items <- na.omit(items) 

list_items$date <- dmy(list_items$date)

list_items <- list_items %>%
  mutate(year = year(date), month = month(date), day = day(date))
```

#### Filter just April 

Filter data for just April 2019 and 2020, make class and year factor. 


```r
april_list_items <- list_items %>%
  filter(month == 4)


april_list_items$class <- as.factor(april_list_items$class)
april_list_items$year <- as.factor(april_list_items$year)
```


#### Plot food spending


```r
april_list_items %>%
  filter(class %in% c("Groceries", "Dinnerout", "CoffeeLunch")) %>%
  group_by(year, class) %>%
  summarise(monthlytotal = sum(debit)) %>%
  ggplot(aes(x = year, y = monthlytotal, fill = year)) +
  geom_col() +
  scale_fill_manual(values = c("#0072B2","#CC79A7")) +
  facet_wrap(~class) +
  labs(title = "April eating") +
  ylab("Monthly Spend") +
  theme(
  axis.text.y = element_blank(),
  axis.ticks = element_blank()) # removes y axis tick labels
```

```
## `summarise()` has grouped output by 'year'. You can override using the `.groups` argument.
```

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-7-1.png" width="672" />

```r
ggsave("april.png")
```

```
## Saving 7 x 5 in image
```



We spend WAY too much on lunch/coffee at work every day!
