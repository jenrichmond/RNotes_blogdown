---
title: cooking with datapasta
author: ''
date: '2018-08-09'
slug: cooking-with-datapasta
categories: []
output:
  html_document:
    keep_md: yes
---

Another day... another data set. This time I am trying to get EMG data from LabChart into R. LabChart is the software we use to record EMG data and do the first steps of data cleaning/processing. At the moment a good chunk of the cleaning process involves Excel macros, so my goal is to replicate what we have traditionally done in Excel in R, so that it is more automated and more reproducible. 



First step, get the data from LabChart datapad into R. Not as easy as I thought. I tried copying and pasting the data into Excel, and instead of messing with it there, saving as .csv, and using read_csv to import it into R. This kinda worked, except that the process of copying the timestamps into excel messed with the units. The timestamps are super important in EMG data because we are only looking at 1000ms segments of data, so when Excel butchers your 0:15:24:281 timestamp, so that R reads in 15:24:00 in hms format, you are in trouble. 

The goal of using R is to get rid of Excel, so I need to work out how to remove that the Excel step. It seems unnecessarily difficult to save the DataPad output as a .txt or .csv file. As far as I can work out, copying and pasting is the only way to get Datapad information out.  

Can I copy and paste data straight into R? Enter the `datapasta` package. 

This package is nifty. 

Step 1: select and Ctrl-C the data from DataPad, then use datapasta to paste into R by either

1. typing a paste command into a script [df_paste() for paste as data.frame]  
2. choosing an option from addins [choose Paste as data.frame] 
3. using a keyboard shortcut [Ctrl-Shift-Alt d will paste as data.frame]

Now when it pastes the data it seems to do it into the console/script, but doesn't create an object in your enviornment that you can then work with. 

Step 2:  assign the data frame you just created a name. 

In the script it will say ...

```
data.frame(stringsAsFactors= FALSE, ----- and then all the data for each variable

```
To assign that dataframe a name, just type the name of the dataframe in the front with a <- and run the script again. i.e.

```
conditionparticipant <- data.frame(stringsAsFactors etc......)
```

Check out this [screencast](https://drive.google.com/file/d/1hYOMO7EuQzJgS1M5_Xj6hqqjxLHouIKU/view) to see me making pasta. 
 
NOTE to self- datapasta will also paste a tribble or vector or vector vertical. I don't yet have a good grasp on what those things are, or how they might be useful. To learn: what is a tribble? 
  
