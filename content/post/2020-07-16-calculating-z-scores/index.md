---
title: calculating z scores
author: ''
date: '2020-07-16'
slug: calculating-z-scores
output:
  html_document:
    keep_md: yes
---


The scale() function will center and/or scale a numeric object. Use center = TRUE to subtract the mean from the values; use scale = TRUE to divide the centered values by the standard deviation to produce z scores.

#### center variable A 
 
 > scale(A, center = TRUE, scale = FALSE)


#### generate z-scores for variable A 

> scale(A, center = TRUE, scale = TRUE)

Lets try it with EMG data

#### read in clean EMG data

Sample data from N=5 participants


```r
library(tidyverse)

emg <- read_csv("sampleEMG.csv")

glimpse(emg)
```

```
## Rows: 1,760
## Columns: 8
## $ X1        <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 1…
## $ pp_no     <chr> "pp1", "pp1", "pp1", "pp1", "pp1", "pp1", "pp1", "pp1", "pp1…
## $ condition <chr> "stimtype1", "stimtype1", "stimtype1", "stimtype1", "stimtyp…
## $ bin       <chr> "bin_0", "bin_0", "bin_1", "bin_1", "bin_2", "bin_2", "bin_3…
## $ bin_no    <dbl> 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, …
## $ trial     <chr> "trial1", "trial1", "trial1", "trial1", "trial1", "trial1", …
## $ muscle    <chr> "brow", "cheek", "brow", "cheek", "brow", "cheek", "brow", "…
## $ rms       <dbl> 2.1998, 9.1660, 2.1451, 5.7558, 2.7000, 10.9498, 1.1724, 7.4…
```


# Get data set up 

This dataset is long with muscle (brow,cheek) in a single variable. We want to z score each muscle separately, so easiest to make the brow and cheek data wide. 

#### Make data wide


```r
emg_wide <- emg %>%
  pivot_wider(names_from = "muscle", values_from = "rms")

glimpse(emg_wide)
```

```
## Rows: 1,760
## Columns: 8
## $ X1        <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 1…
## $ pp_no     <chr> "pp1", "pp1", "pp1", "pp1", "pp1", "pp1", "pp1", "pp1", "pp1…
## $ condition <chr> "stimtype1", "stimtype1", "stimtype1", "stimtype1", "stimtyp…
## $ bin       <chr> "bin_0", "bin_0", "bin_1", "bin_1", "bin_2", "bin_2", "bin_3…
## $ bin_no    <dbl> 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, …
## $ trial     <chr> "trial1", "trial1", "trial1", "trial1", "trial1", "trial1", …
## $ brow      <dbl> 2.1998, NA, 2.1451, NA, 2.7000, NA, 1.1724, NA, 1.6986, NA, …
## $ cheek     <dbl> NA, 9.1660, NA, 5.7558, NA, 10.9498, NA, 7.4457, NA, 6.1996,…
```

Now use mutate to create new columns that contain z scores.

#### Option 1: mutate z scores manually

> mutate(z_score = (value - mean(value)) / sd(value))


```r
emg_z_manual <- emg_wide %>%
  mutate(Zbrow = (brow - mean(brow))/sd(brow)) %>%
  mutate(Zcheek = (cheek - mean(cheek))/sd(cheek))
```


#### Option 2: mutate z scores using scale()


```r
emg_z_scale <- emg_wide %>%
  mutate(Zbrow = scale(brow, center = TRUE, scale = TRUE)) %>%
  mutate(Zcheek = scale(cheek, center = TRUE, scale = TRUE))
```

#### Check

Use summary to check that the mean is now 0


```r
summary(emg_z_scale)
```

```
##        X1            pp_no            condition             bin           
##  Min.   :   1.0   Length:1760        Length:1760        Length:1760       
##  1st Qu.: 440.8   Class :character   Class :character   Class :character  
##  Median : 880.5   Mode  :character   Mode  :character   Mode  :character  
##  Mean   : 880.5                                                           
##  3rd Qu.:1320.2                                                           
##  Max.   :1760.0                                                           
##                                                                           
##      bin_no      trial                brow             cheek        
##  Min.   : 0   Length:1760        Min.   : 0.9923   Min.   :  1.513  
##  1st Qu.: 2   Class :character   1st Qu.: 4.4201   1st Qu.:  2.968  
##  Median : 5   Mode  :character   Median : 7.2572   Median :  3.817  
##  Mean   : 5                      Mean   : 7.2396   Mean   :  6.042  
##  3rd Qu.: 8                      3rd Qu.: 9.0815   3rd Qu.:  6.122  
##  Max.   :10                      Max.   :40.6425   Max.   :168.999  
##                                  NA's   :880       NA's   :880      
##      Zbrow.V1          Zcheek.V1    
##  Min.   :-1.5555   Min.   :-0.4094  
##  1st Qu.:-0.7020   1st Qu.:-0.2779  
##  Median : 0.0044   Median :-0.2012  
##  Mean   : 0.0000   Mean   : 0.0000  
##  3rd Qu.: 0.4586   3rd Qu.: 0.0073  
##  Max.   : 8.3169   Max.   :14.7318  
##  NA's   :880       NA's   :880
```


## EMG z scores by participant

In the context of EMG, we want to standardise scores separately for each participant. You can do that using group_by(pp_no) before the mutate. 



```r
emg_z_scale_bypp <- emg_wide %>%
  group_by(pp_no) %>%
  mutate(Zbrow = scale(brow, center = TRUE, scale = TRUE)) %>%
  mutate(Zcheek = scale(cheek, center = TRUE, scale = TRUE))
```


Use a filter then summary to check that it gives you the same values as before for a single participant.


```r
emg_z_scale_bypp %>%
  filter(pp_no == "pp1") %>%
  summary()
```

```
##        X1            pp_no            condition             bin           
##  Min.   :  1.00   Length:352         Length:352         Length:352        
##  1st Qu.: 88.75   Class :character   Class :character   Class :character  
##  Median :176.50   Mode  :character   Mode  :character   Mode  :character  
##  Mean   :176.50                                                           
##  3rd Qu.:264.25                                                           
##  Max.   :352.00                                                           
##                                                                           
##      bin_no      trial                brow             cheek        
##  Min.   : 0   Length:352         Min.   : 0.9923   Min.   :  4.389  
##  1st Qu.: 2   Class :character   1st Qu.: 1.6991   1st Qu.:  6.171  
##  Median : 5   Mode  :character   Median : 2.2721   Median :  7.627  
##  Mean   : 5                      Mean   : 2.9080   Mean   : 13.934  
##  3rd Qu.: 8                      3rd Qu.: 3.0276   3rd Qu.: 10.047  
##  Max.   :10                      Max.   :22.2281   Max.   :168.999  
##                                  NA's   :176       NA's   :176      
##       Zbrow.V1          Zcheek.V1     
##  Min.   :-0.84411   Min.   :-0.42046  
##  1st Qu.:-0.53267   1st Qu.:-0.34200  
##  Median :-0.28023   Median :-0.27786  
##  Mean   : 0.00000   Mean   : 0.00000  
##  3rd Qu.: 0.05266   3rd Qu.:-0.17125  
##  Max.   : 8.51278   Max.   : 6.83100  
##  NA's   :176        NA's   :176
```


