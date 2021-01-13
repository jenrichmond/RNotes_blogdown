---
title: git from project
author: ~
date: '2021-01-13'
slug: []
categories: []
tags: []
---

In the spirit of documenting new git things I am learning (see my pull request post here), I thought I would walk through how to turn a project that lives on your machine into a git repo. I am walking through the instructions in happygitwithr.com and there is a reason that there first two use cases Jenny Bryan lays out both involve starting with a repo on Github first 

### Option 1: New project, Github first
- create a new repo on github, clone it to your machine, make changes to the copy on your machine and push those changes to github

### Option 2: Existing project, Github first
- create a new repo on github, clone it to your machine, *copy/move the files that make up your existing project to the folder that you cloned*, make any additional changes you want, and then push those changes to github

### Option 3: Existing project, Github last
- this one is tricker, but maintains any existing version history. Apparently usethis is making this easier, and potentially shell free.... so lets try it out on my Tidy Tuesday project. 


Step 1: launch your project file
- if your things don't live in a project you can usethis::create_project()

Step 2: tell Rstudio you want to use git 

- you can do this from within RStudio, again using usethis package 

```
usethis::use_git(message = "initial commit"))

```
Note this is equivalent to `git init` in the terminal. If you get a message asking whether commit the files usethis finds, you can say 'Yup'. Otherwise, take a look at the git tab and see if there is anything to commit. 



Step 3: tell RStudio you want to connect to github

usethis also makes this step easy, provided you have created a Github Personal Access Token (PAT)

```

usethis::usegithub()

```
