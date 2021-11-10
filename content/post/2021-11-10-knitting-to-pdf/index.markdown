---
title: knitting to pdf
author: Jen Richmond
date: '2021-11-10'
slug: []
categories: []
tags: []
---

I've never really liked the default font that is used when Rmd knits to pdf. When knitting to pdf, R uses LaTex (which is why you often need to install the `tinytex` package) and the default in LaTex is called Computer Modern. 

<img src="compmod.png" width="693" />
<br>

You can customise fonts, size, and line spacing in the yaml. To change the font style you need to use a LaTex engine like xelatex and specify the mainfont (your main text) and monofont (code chunks and output). 

<img src="yaml.png" width="372" />

<br>

Adjust linespacing with the linestretch parameter and use fontsize to change the sizing. Note- LaTex will only do 10 pt, 11 pt, or 12 pt font. 

Then your knitted pdf will look like this!


<img src="done.png" width="720" />
