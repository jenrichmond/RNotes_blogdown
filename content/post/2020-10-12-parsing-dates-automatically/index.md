---
title: lubridate parsing dates automatically
author: ''
date: '2020-10-18'
slug: parsing-dates-automatically

image: "img/gs.png"
output:
  html_document:
    keep_md: yes

---




I've been looking at old Tidy Tuesday datasets this week to try and work out why sometimes date data is automatically parsed as dates, like in the palmer penguin dataset...


```r
# read data from Tidy Tuesday
penguins_raw <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-07-28/penguins_raw.csv') %>%
  clean_names

# check class
class(penguins_raw$date_egg)
```

```
## [1] "Date"
```

```r
# pull first date observation
penguins_raw$date_egg[[1]]
```

```
## [1] "2007-11-11"
```

And other times R thinks dates are characters, like in the marbles data. 


```r
# read data from Tidy Tuesday
marbles <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-06-02/marbles.csv')

# check class
class(marbles$date)
```

```
## [1] "character"
```

```r
# pull first date observation
marbles$date[[1]]
```

```
## [1] "15-Feb-20"
```


I have already learned [how to use dmy()](http://jenrichmond.rbind.io/post/converting-characters-to-dates/) and could convert the marble dates into date format pretty easily but...


```r
# convert date to dmy
marbles$date <- dmy(marbles$date)
# check class again
class(marbles$date)
```

```
## [1] "Date"
```

... why doesn't R recognise them as dates automatically?

In the marbles data, the raw dates are in day-month-year format (i.e. 15-Feb-20). I like this format (because I live in Australia and it is consistent with how we write dates here), but maybe R prefers [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601#:~:text=Although%20the%20standard%20allows%20both,YYYY%2DMM%20format%20is%20allowed1
) format (i.e. YYYY-MM-DD) and will only parse dates in that format? 

To test this hypothesis, I made a google form that asked respondents to enter their birthday 3 times...

- first, however they wanted
- second, using a date template
- third, in yyyy-mm-dd format




```r
# read data from googlesheets

bday <- read_sheet("https://docs.google.com/spreadsheets/d/18OaHGFe33kvbB3GMCDHdXrmudnR7zEm4Swr-0_JEw4U/edit#gid=1811856339") 

glimpse(bday)
```

```
## Rows: 21
## Columns: 4
## $ timestamp     <dttm> 2020-10-12 22:02:34, 2020-10-12 22:18:19, 2020-10-12 22…
## $ free_date     <list> "30 June 1978", "17 Feb, 2011", "March 25 2014", "1977/…
## $ template_date <dttm> 1978-06-30, 2011-02-17, 2014-03-25, 1977-07-11, 1981-09…
## $ iso_date      <chr> "1978-06-30", "2011-02-17", "2014-03-25", "1977-07-11", …
```

Well that didn't turn out as I had expected. The free date entry parses as a list! When you let people enter date without any instructions you end up with data that is REALLY hard to parse. 

The template date is recognised as dttm (datetime format) and appears in R as yyyy-mm-dd, even though in the google sheet it appears in AUS date format (dd-mm-yyyy). 

Most surprising to me is that the data that I asked respondants to enter in ISO format (yyyy-mm-dd) is parsed as characters NOT dates. 

Hmmmmm..

### what happens if change the date format in googlesheets? 

Maybe the number formating in google sheets makes a difference. Here I have copied the iso column into a different sheet and used Format-Number-Date to change the format to be Date in googlesheets. 


```r
# read data from google sheets
bday_copy <- read_sheet("https://docs.google.com/spreadsheets/d/12xGBGjoCll8TbT6PpbhVksZGPavAVJqWGUOsWEPSS9c/edit#gid=0") 
```

```
## Reading from "date copy"
```

```
## Range "Sheet1"
```

```r
glimpse(bday_copy)
```

```
## Rows: 21
## Columns: 1
## $ iso_date_copy <dttm> 1978-06-30, 2011-02-17, 2014-03-25, 1977-07-11, 1981-09…
```
Ahhhh so googlesheet dates in date format will read as dates in R. Good to know...

Now I'm kinda interested, what about .csv or .xlsx format??

### What happens if I download the the bday sheet and read it in as a .csv?


```r
# read data from csv
bday_csv <- read_csv("bday_csv.csv")

glimpse(bday_csv)
```

```
## Rows: 21
## Columns: 4
## $ timestamp     <chr> "12/10/2020 22:02:35", "12/10/2020 22:18:20", "12/10/202…
## $ free_date     <chr> "30 June 1978", "17 Feb, 2011", "March 25 2014", "1977/7…
## $ template_date <chr> "30/06/1978", "17/02/2011", "25/03/2014", "11/07/1977", …
## $ iso_date      <date> 1978-06-30, 2011-02-17, 2014-03-25, 1977-07-11, 1981-09…
```
What? the template date is characters, but the ISO formatted date is a date....

# What about excel?


```r
# read data from xl
bday_xl <- read_excel("bday_xl.xlsx")

glimpse(bday_xl)
```

```
## Rows: 21
## Columns: 4
## $ timestamp     <dttm> 2020-10-12 22:02:34, 2020-10-12 22:18:19, 2020-10-12 22…
## $ free_date     <chr> "30 June 1978", "17 Feb, 2011", "March 25 2014", "1977/7…
## $ template_date <dttm> 1978-06-30, 2011-02-17, 2014-03-25, 1977-07-11, 1981-09…
## $ iso_date      <chr> "1978-06-30", "2011-02-17", "2014-03-25", "1977-07-11", …
```

Well that is weird... from .xlsx the template date is dttm but the ISO formatted date is characters- which is the OPPOSITE to what happens with the same data read from a .csv file. 

# When will R recognise my dates as dates?

Bottom line, it depends... where you are reading data from makes a difference.  R is more likely to read your dates if the variable in googlesheets or excel is in date format, but from .csv, it seems to like ISO format (yyyy-mm-dd). 

# Free entry dates

OK what you do with the free date data, when you have forgotten to restrict the way that your participants enter their date. 

Let's make a new df that includes just the free date and template date variables. 


```r
free_template <- bday %>%
  select(free_date, template_date)
```

Can `lubridate` help parse dates that are in a million different formats?


```r
head(free_template$free_date)
```

```
## [[1]]
## [1] "30 June 1978"
## 
## [[2]]
## [1] "17 Feb, 2011"
## 
## [[3]]
## [1] "March 25 2014"
## 
## [[4]]
## [1] "1977/7/11"
## 
## [[5]]
## [1] "4 Sep 1981"
## 
## [[6]]
## [1] "11/7/1987"
```

Actually, there aren't a million formats. There are probably only 3 ...

- dmy
- ymd
- mdy

... and you can use `parse_date_time()` to let R know that it should try to parse dates in all 3 formats. 


```r
free_template <- free_template %>%
  mutate(free_date_parsed = parse_date_time(free_date, c("ymd", "mdy", "dmy")))
```

```
## Warning: 1 failed to parse.
```

```r
glimpse(free_template)
```

```
## Rows: 21
## Columns: 3
## $ free_date        <list> "30 June 1978", "17 Feb, 2011", "March 25 2014", "19…
## $ template_date    <dttm> 1978-06-30, 2011-02-17, 2014-03-25, 1977-07-11, 1981…
## $ free_date_parsed <dttm> 1978-06-30, 2011-02-17, 2014-03-25, 1977-07-11, 1981…
```
Wow- that is pretty impressive, only 1 failed to parse. The only date that failed was the one entry that didn't have a year (i.e. Aug 21). But were there any errors?

Let's compare the free_date to the template_date. If there is any time between them, something went wrong with the `parse_date_time()`. Use mutate to make a new variable subtracting one date from the other. 


```r
# make a new variable to check whether there is any difference between free and template date
free_template %>%
  mutate(date_check = free_date_parsed - template_date)
```

```
## # A tibble: 21 x 4
##    free_date template_date       free_date_parsed    date_check     
##    <list>    <dttm>              <dttm>              <drtn>         
##  1 <chr [1]> 1978-06-30 00:00:00 1978-06-30 00:00:00          0 secs
##  2 <chr [1]> 2011-02-17 00:00:00 2011-02-17 00:00:00          0 secs
##  3 <chr [1]> 2014-03-25 00:00:00 2014-03-25 00:00:00          0 secs
##  4 <chr [1]> 1977-07-11 00:00:00 1977-07-11 00:00:00          0 secs
##  5 <chr [1]> 1981-09-04 00:00:00 1981-09-04 00:00:00          0 secs
##  6 <chr [1]> 1987-07-11 00:00:00 1987-07-11 00:00:00          0 secs
##  7 <chr [1]> 1977-09-11 00:00:00 1977-09-11 00:00:00          0 secs
##  8 <chr [1]> 1967-07-06 00:00:00 2067-07-06 00:00:00 3155760000 secs
##  9 <chr [1]> 1979-05-02 00:00:00 1979-05-02 00:00:00          0 secs
## 10 <chr [1]> 1982-03-28 00:00:00 1982-03-28 00:00:00          0 secs
## # … with 11 more rows
```

```r
glimpse(free_template)
```

```
## Rows: 21
## Columns: 3
## $ free_date        <list> "30 June 1978", "17 Feb, 2011", "March 25 2014", "19…
## $ template_date    <dttm> 1978-06-30, 2011-02-17, 2014-03-25, 1977-07-11, 1981…
## $ free_date_parsed <dttm> 1978-06-30, 2011-02-17, 2014-03-25, 1977-07-11, 1981…
```

Mostly there is 0 sec difference between the new free_dates and the template date- yay!  The only instance where it made an error was the case where the year was only 2 digits. 


```r
bday$free_date[[8]]
```

```
## [1] "6th july 67"
```
Of interest, placing a ' in the missing digit space on a year, makes the date parse just fine. 


```r
bday$free_date[[10]]
```

```
## [1] "March 28, ‘82"
```

# excel behaving badly

I haven't encountered this yet, but if there is a function in the `janitor` package to deal with a problem it must be common. Apparently sometimes [dates from excel import into R as numeric](https://blog.exploratory.io/how-to-convert-excel-numeric-dates-to-date-data-type-in-r-5b100547007f)

Use `janitor::excel_numeric_to_date()` to convert...

# What have I learned about lubridate now?

- getting R to automatically recognise your dates as dates is a bit of a crap shoot
  + depends on where you are reading your data from (googlesheets, csv, excel) and how much leeway you gave your participants when they were entering them
- best to not allow participants free reign over their date entry
  + but if you do, `parse_date_time()` does a decent job of pulling different formats into a consistent one
  
  
# What do I still have to learn?

- another thing that `lubridate` helps you do is deal with doing math with dates
  + how much time is there between x date and x date?
  + what will the date be 100 days from now?
- I don't know what the difference is between a duration, a period, and an interval, but apparently its a thing... that is next on my list. 
