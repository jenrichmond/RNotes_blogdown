---
title: calculating age
author: ''
date: '2018-08-04'
slug: calculating-age
categories: []
tags: []
output:
  html_document:
    keep_md: yes
---

I have been playing with a new (not actually new, but new to R) dataset this week. 


#### Successes: 

1. I loaded the data in using `read_csv`. 
2. I made dates into dates. 

* The interview group is listed as 1s and 2s in the file so R thought those were  integers. So I used `as.factor` to convert.

```
dataframe$variable <- as.factor(dataframe$variable) 

```

I used `lubridate` package to specify that DOB and Test_date were dates with Day Month Year (dmy) format. It was pretty clever and dealt nicely with some inconsistencies in date format too. 


```  
mutate(DOB = dmy(DOB), Test_Date= dmy(Test_Date))
 
```    


#### Challenges

Now that I have dates that are dates, I'd like to calculate how old these kids are. Just subtracting DOB from Test_Date does OK, except that it calculates age in Days. 

```
mutate(agedays = (Test_Date-DOB))    

```

I mostly work with infants and preschoolers so I really want age in Weeks or Months, not Days or Years. Turns out this is a bit challenging. I could just estimate age in months by dividing the Days by 30, which works, kind of. The result is in time format but still in days.  

Help google!!

This function on github has potential.  

https://gist.github.com/mmparker/7254445

It does a really nice job of calculating age even when I use my date variables.  

```
mutate(ageyear = calc_age(DOB, Test_Date))

```

BUT.... the output is years. 

Trying to work out how to adapt this function for my purpose sent me down a little rabbit hole re what is a function and how you make one. 

This one is pretty simple, a good introduction, me  thinks...

#### Function to calculate age: 


```
calc_age <- function(birthDate, refDate = Sys.Date()) {

    require(lubridate)

    period <- as.period(interval(birthDate, refDate),
                        unit = "year")

    period$year

} 

```



My understanding is that this piece of code creates a function called `calc_age` that take inputs of birthDate and refDate, although if you skip the refDate input it will default to Sys.Date, which would be useful if you wanted to know what age was today. Using my birthday as input...

```
calc_age("1978/06/30")
```

...gives answer = 40

Yup, I'm still 40. 

The nuts and bolts are between the curly brackets. This function requires the lubridate package, and defines the "period" as an interval between birthDate and refDate, specifying that it is a period (rather than an interval or duration) 


#### NOTE

>lubridate object classes  
1. durations, which represent an exact number of seconds.  
2. periods, which represent human units like weeks and months.  
3. intervals, which represent a starting and ending point.  
(from http://r4ds.had.co.nz/dates-and-times.html#time-spans) 


`lubridate` is smart with dates right? I should be able to just change the unit = months and it would work? Sadly, no. 

I need help...

### UPDATE

Twitter saves the day again! BIG thanks to [Alison Hill](https://twitter.com/apreshill) for pointing me to this [extra useful lubridate resource](https://data.library.virginia.edu/working-with-dates-and-time-in-r-using-the-lubridate-package/)

So what I really want to do is calculate an interval, which you do using %--%. Once you have an interval, you divide by months(1), using / if you want decimal places or modulus [%/% -I always wondered what that was] if you want whole months. 
```
ageproblem2 <- ageproblem %>%
        mutate(ageinterval = DOB %--% Test_Date) %>%
        mutate(agemons = ageinterval %/% months(1)) %>%
         mutate(ageweeks = ageinterval %/% weeks(1))
```



