---
title: stats2- anova
author: ''
date: '2018-09-07'
slug: stats2-anova
categories: []
tags:
  - analysis
  - stats
  - anova
draft: TRUE
---

ANOVA and regression are the same, the `lm()` function is useful 
```
mod <- aov(total.score ~ venue, afl.majors)
```

This is the Anova function from the `car` package
Anova(mod)

Posthoc pairwise comparisons with conservative bonferroni BUT problematic because you didn't have a hypothesis about what you were looking for
```
posthocPairwiseT(mod, p.adjust.method = "bonferroni")
```