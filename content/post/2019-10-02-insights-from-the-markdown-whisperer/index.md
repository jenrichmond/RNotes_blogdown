---
title: insights from the RMarkdown whisperer
author: ''
date: '2019-10-02'
slug: insights-from-the-markdown-whisperer
image: "img/alison.JPG"
output:
  html_document:
    keep_md: yes
---

I had the pleasure of attending [Alison Hill's](@apreshill) [RMarkdown workshop](https://ysc-rmarkdown.netlify.com/) in Canberra on Monday and I came away with so many tips and tricks! It was brillant. 

Alison covered A LOT over the course of the day. I learned lots of the power of yaml, how to create parameterised reports, and how to make a package that contains customised .Rmd templates. Each of those topics are blogposts for another day, but my favourite bit was making a beautiful Academic theme blogdown site. 

Slides from this section of Alison's workshop available here: [Collections](https://ysc-rmarkdown.netlify.com/slides/04-collections.html#1) 

The [Hugo Academic theme](https://themes.gohugo.io/academic/) is great, but is a bit... blah. It is really popular but all the sites look a bit same same.  Alison and [Desirée De Leon](@dcossyle), who is a neuroscience grad student, CSS whiz, RStudio intern, and [mother of teacup giraffes](https://tinystats.github.io/teacups-giraffes-and-statistics/) have fixed all that, adding all kinds of customisable fonts and colour schemes.  And.... made it REALLY easy to get your site linked to github and on the internet via Netlify. It is almost magical. 

So before I forget how to do it, here is a step by step guide for using The RMarkdown Whisperer's `BeautifulAcademic`*  blogdown template. 

*NOTE: its not actually called that but I think that they have made the [Hugo Academic theme](https://themes.gohugo.io/academic/) beautiful. 



### How to make Academic Beautiful

#### 1. Install blogdown and check your hugo version


```r
library(blogdown)

hugo_version() #if this is less than 0.57 something then run...

update_hugo()
```

> **UPDATE APRIL2020**: 
if you have never done this before you might need install_hugo(). Also when I tried this on a new machine recently, I got an error re the `Rcpp` package. Use install.package() to get it; I found it worked best by choose "no" when asked "Do you want to install from sources the package which needs compilation?"

#### 2. Get github and netlify

Make sure you have a github account, and you might as well sign up at netlify.com too.

#### 3. Find Alison's ysc template at her github 

- go to this [link](https://github.com/ysc2019-workshop/04-blogdown) to find the ysc-blogdown github repo
- click the Magic `Deploy to Netlify` button at the bottom (yes, its ok- just do it). 
- once you are at netlify, use the `Connect to Github` button
- change the name of the repository that it will create in your github account, click `Save and Deploy`
- wait for the MAGIC

<iframe src="https://giphy.com/embed/l2YWs1NexTst9YmFG" width="480" height="358" frameBorder="0" class="giphy-embed" allowFullScreen></iframe><p><a href="https://giphy.com/gifs/Filmeditor--halloween-ashley-olsen-l2YWs1NexTst9YmFG">via GIPHY</a></p>


It will take a few seconds, but eventually netlify will deploy your site... to the internet... JUST LIKE THAT! It will have an "creative" url, but you can change that later. 

Now if you go to your github, there should be a new repo there, containing all of your site files. 

Alison's bakeoff-themed site with monsters from [Allison Horst](https://github.com/allisonhorst/stats-illustrations) is cute, but you probably want to make it your own. Next you need to get the files on your local machine. 

#### 4. Clone/Download the zip folder 
- Click the clone/download button and copy the url to your repo 
- Go back to RStudio, open a terminal, make sure you are on the desktop by using `cd Desktop`.
- Clone the repo to your desktop by typing `git clone` and pasting the repo link 
- Find the folder on your desktop and open the .Rproj file
- in your console, type serve_site() and see what happens in your Viewer tab

Screencast of me doing the steps above [available here](https://youtu.be/9UIkbAZuLtU)

#### 5. Make some changes to your site

Now that you have the files on your machine and your site serves locally, you can customise everything. Make a change, then use `serve_site()` to see the change in your Viewer. 

###### theme and fonts

You can change the fonts and theme by finding the params.toml file in the `config/_default` folder. You can find the available font and theme options in the data/fonts and data/themes folder.

###### Blog name / author

Change the config.toml file to customise the name of your blog. 
Find the `content/authors/admin` folder and replace the avatar.jpg with your own profile pic; alter the details in the _index.md file to make the blog your own. 

###### Home page

The Home page on hugo-academic theme sites works via a series of widgets, which you can find in the `content/home` folder. Explore each .md in this folder, toggling on the active = false (changing it to true), and see what happens to your home page. By default only the hero.md widget is set to true. 

###### Contents + Blog

The contents of the `content` folder is fair game. 

In `content/post` you can see a template blog is called Bake Off. It has posts for each of 8 bakeoff series; each lives in its own folder. You can delete the posts that are there by deleting the series1-8 folders (although you might like to leave one, just so you can use it as a template). 

Edit the _index file to change the name of your blog to something other than "Bake Off Ratings Reports"

Change the header label for your blog from BAKEOFF to something else by editing the menus.toml file in `config/_default`. This file also has a place for you to put a CV link. 



#### 6. Push changes to git

Once you have made some changes to your site, you want to push them back to git. Make sure your R is talking to git by using the `usethis` package to set up your git config.


```r
library(usethis)

use_git_config(user.name = "Your Name", user.email = "your@email.com")
```


Then find the Git pull down (next to the Addins) and choose commit. Select the checkboxes for files that you want to commit, write an informative commit message, press the commit button and then the push button. Enter your git credentials. 

> **UPDATE APRIL2020**: if you don't have a Git pull down, usethis has a solution for that too. Try use_git(), it will ask you if it is ok to commit the files you have changed and then if it is ok to restart R. Once it restarts, you should now have a Git pulldown next to your addins. As always, connecting a new machine to git is a nightmare. In this case, I had most success with instructions 17.5.2 from happygitwithr.com.


Check your git repo and make sure that the changes appear there. Then check your netlify site; all going well your changes should appear there too!

#### 7. Customise your url

You can be forgiven for not really liking the default 'creative' netlify url you have been assigned. Customise that going back into Netlify and choosing Site settings- Change site name. 


### A troubleshooting tip....

If you are uncertain what something you have done to your site will deploy well to netlify, Alison recommends a quick drag and drop test. Go to the [Drag and Drop App](https://app.netlify.com/drop) and just drag your whole public folder there. 
Netlify will deploy it (with another creative url) which will last 24 hours unless you confirm you want it to be permanent. The drop app is a helpful testing ground. 
