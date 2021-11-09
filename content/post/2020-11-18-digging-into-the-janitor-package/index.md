---
title: cleaning penguins with the janitor package
author: ''
date: '2020-11-18'
slug: digging-into-the-janitor-package
image: "img/dirty_penguin.jpg"
output:
  html_document:
    keep_md: yes
---

The janitor package by [Sam Firke](https://github.com/sfirke/janitor) contains probably my FAVOURITE R function: `clean_names()`. By default when I am reading data into R, I pipe `clean_names()` onto the end of my `read_csv()`. I never have to look at inconsistently formatted variable names. But janitor package includes lots of other useful functions that make it easier to deal with dirty data and count stuff.

    new_df <- read_csv(here("data", "df.csv") %>%
            clean_names())
            

# Exploring package functions

Are you keen to dig into the little known functions of a package that you use all the time? Here is a tip: in console type the name of the package with a double colon (i.e. janitor::), all the functions in the package will pop up and you can explore them by scrolling up and down the list.

Alternatively you can load the package in the console and then use `ls("package:packgename")` to get a list of all the objects in the package.

``` r
library(janitor)

ls("package:janitor")
```

    ##  [1] "%>%"                   "add_totals_col"        "add_totals_row"       
    ##  [4] "adorn_crosstab"        "adorn_ns"              "adorn_pct_formatting" 
    ##  [7] "adorn_percentages"     "adorn_rounding"        "adorn_title"          
    ## [10] "adorn_totals"          "as_tabyl"              "chisq.test"           
    ## [13] "clean_names"           "compare_df_cols"       "compare_df_cols_same" 
    ## [16] "convert_to_date"       "convert_to_datetime"   "convert_to_NA"        
    ## [19] "crosstab"              "describe_class"        "excel_numeric_to_date"
    ## [22] "fisher.test"           "get_dupes"             "make_clean_names"     
    ## [25] "remove_constant"       "remove_empty"          "remove_empty_cols"    
    ## [28] "remove_empty_rows"     "round_half_up"         "round_to_fraction"    
    ## [31] "row_to_names"          "signif_half_up"        "tabyl"                
    ## [34] "top_levels"            "untabyl"               "use_first_valid_of"

Lets try a few these functions.

# read some dirty data

The penguin data isn’t very dirty out of the package, but I added some funky things for illustrative purposes.

``` r
dirty <- read_csv("penguin_raw_dirty.csv")
```

# 1. clean\_names()

The penguin variable names are not great. A nasty mix of capital and little letters, gaps and brackets- not fun to type over and over again.

``` r
names(dirty)
```

    ##  [1] "studyName"           "Sample Number"       "Species"            
    ##  [4] "Region"              "Island"              "Stage"              
    ##  [7] "Individual ID"       "Clutch Completion"   "Empty Column"       
    ## [10] "Date Egg"            "Culmen Length (mm)"  "Culmen Depth (mm)"  
    ## [13] "Flipper Length (mm)" "Body Mass (g)"       "Sex"                
    ## [16] "Delta 15 N (o/oo)"   "Delta 13 C (o/oo)"   "Comments"

`clean_names()` will take all the variable names and make them lower case and replace gaps/brackets with underscores.

``` r
clean <- dirty %>%
  clean_names()

names(clean)
```

    ##  [1] "study_name"        "sample_number"     "species"          
    ##  [4] "region"            "island"            "stage"            
    ##  [7] "individual_id"     "clutch_completion" "empty_column"     
    ## [10] "date_egg"          "culmen_length_mm"  "culmen_depth_mm"  
    ## [13] "flipper_length_mm" "body_mass_g"       "sex"              
    ## [16] "delta_15_n_o_oo"   "delta_13_c_o_oo"   "comments"

# 2. remove\_empty()

Sometimes dirty data contains whole rows or columns that are empty. You can quickly remove them with `remove_empty()`. By default it is a “quiet” function, but specify quiet = FALSE and it will give you a little feedback about what it has done.

``` r
empty <- clean %>%
  remove_empty(which = c("rows", "cols"), quiet = FALSE)
```

    ## Removing 1 empty rows of 347 rows total (0.288%).

    ## Removing 1 empty columns of 18 columns total (Removed: empty_column).

# 3. get dupes()

Lets imagine an RA made a mistake and entered the data for a couple of penguins twice. `get_dupes()` will tell you if there are duplicate entries in your dataset.

``` r
empty %>%
  get_dupes(sample_number, species)
```

    ## # A tibble: 4 x 18
    ##   sample_number species  dupe_count study_name region island stage individual_id
    ##           <dbl> <chr>         <int> <chr>      <chr>  <chr>  <chr> <chr>        
    ## 1            18 Adelie …          2 PAL0708    Anvers Torge… Adul… N9A2         
    ## 2            18 Adelie …          2 PAL0708    Anvers Torge… Adul… N9A2         
    ## 3            60 Chinstr…          2 PAL0910    Anvers Dream  Adul… N95A2        
    ## 4            60 Chinstr…          2 PAL0910    Anvers Dream  Adul… N95A2        
    ## # … with 10 more variables: clutch_completion <chr>, date_egg <chr>,
    ## #   culmen_length_mm <dbl>, culmen_depth_mm <dbl>, flipper_length_mm <dbl>,
    ## #   body_mass_g <dbl>, sex <chr>, delta_15_n_o_oo <dbl>, delta_13_c_o_oo <dbl>,
    ## #   comments <chr>

Then you can remove the duplicates with the `distinct()` function from `dplyr`. It only keeps distinct observations.

``` r
dupes_gone <- empty %>%
  distinct()

dupes_gone %>%
  get_dupes(sample_number, species)
```

    ## No duplicate combinations found of: sample_number, species

    ## # A tibble: 0 x 18
    ## # … with 18 variables: sample_number <dbl>, species <chr>, dupe_count <int>,
    ## #   study_name <chr>, region <chr>, island <chr>, stage <chr>,
    ## #   individual_id <chr>, clutch_completion <chr>, date_egg <chr>,
    ## #   culmen_length_mm <dbl>, culmen_depth_mm <dbl>, flipper_length_mm <dbl>,
    ## #   body_mass_g <dbl>, sex <chr>, delta_15_n_o_oo <dbl>, delta_13_c_o_oo <dbl>,
    ## #   comments <chr>

# 4. tabyl()

But perhaps the most surprisingly awesome function in the janitor package is `tabyl()`. Counting things in R is surprisingly hard [see post](http://jenrichmond.rbind.io/post/counting-things/), but `tabyl()` is a huge help.

Advantages…

-   works with %&gt;%
-   takes a dataframe
-   outputs a dataframe
-   is compatible with other table packages like `kableExtra` and `gt`

### one variable (gets you %)

``` r
dupes_gone %>%
  tabyl(species) 
```

    ##                                    species   n   percent
    ##        Adelie Penguin (Pygoscelis adeliae) 152 0.4418605
    ##  Chinstrap penguin (Pygoscelis antarctica)  68 0.1976744
    ##          Gentoo penguin (Pygoscelis papua) 124 0.3604651

### two variables

``` r
dupes_gone %>%
  tabyl(species, sex)
```

    ##                                    species . FEMALE MALE NA_
    ##        Adelie Penguin (Pygoscelis adeliae) 0     73   73   6
    ##  Chinstrap penguin (Pygoscelis antarctica) 0     34   34   0
    ##          Gentoo penguin (Pygoscelis papua) 1     58   61   4

Hmmmm why is there a “.” column? Turns out for one penguin their sex is entered as “.” instead of NA.

Use `na_if()` from `dplyr` to convert pesky values to NA.

``` r
dupes_gone$sex <-  na_if(dupes_gone$sex, ".")

dupes_gone %>%
  tabyl(species, sex)
```

    ##                                    species FEMALE MALE NA_
    ##        Adelie Penguin (Pygoscelis adeliae)     73   73   6
    ##  Chinstrap penguin (Pygoscelis antarctica)     34   34   0
    ##          Gentoo penguin (Pygoscelis papua)     58   61   5

### three variables

``` r
dupes_gone %>%
  tabyl(species, sex, island) 
```

    ## $Biscoe
    ##                                    species FEMALE MALE NA_
    ##        Adelie Penguin (Pygoscelis adeliae)     22   22   0
    ##  Chinstrap penguin (Pygoscelis antarctica)      0    0   0
    ##          Gentoo penguin (Pygoscelis papua)     58   61   5
    ## 
    ## $Dream
    ##                                    species FEMALE MALE NA_
    ##        Adelie Penguin (Pygoscelis adeliae)     27   28   1
    ##  Chinstrap penguin (Pygoscelis antarctica)     34   34   0
    ##          Gentoo penguin (Pygoscelis papua)      0    0   0
    ## 
    ## $Torgersen
    ##                                    species FEMALE MALE NA_
    ##        Adelie Penguin (Pygoscelis adeliae)     24   23   5
    ##  Chinstrap penguin (Pygoscelis antarctica)      0    0   0
    ##          Gentoo penguin (Pygoscelis papua)      0    0   0

### adorn\_ ing things

#### totals by row and/or col

``` r
dupes_gone %>%
  tabyl(species, sex) %>%
  adorn_totals(c("row", "col"))
```

    ##                                    species FEMALE MALE NA_ Total
    ##        Adelie Penguin (Pygoscelis adeliae)     73   73   6   152
    ##  Chinstrap penguin (Pygoscelis antarctica)     34   34   0    68
    ##          Gentoo penguin (Pygoscelis papua)     58   61   5   124
    ##                                      Total    165  168  11   344

#### percentages

``` r
dupes_gone %>%
  tabyl(species, sex) %>%
  adorn_percentages("row")
```

    ##                                    species    FEMALE      MALE        NA_
    ##        Adelie Penguin (Pygoscelis adeliae) 0.4802632 0.4802632 0.03947368
    ##  Chinstrap penguin (Pygoscelis antarctica) 0.5000000 0.5000000 0.00000000
    ##          Gentoo penguin (Pygoscelis papua) 0.4677419 0.4919355 0.04032258

#### percent formatting

``` r
  dupes_gone %>%
  tabyl(species, sex) %>%
  adorn_percentages("row") %>%
  adorn_pct_formatting()
```

    ##                                    species FEMALE  MALE  NA_
    ##        Adelie Penguin (Pygoscelis adeliae)  48.0% 48.0% 3.9%
    ##  Chinstrap penguin (Pygoscelis antarctica)  50.0% 50.0% 0.0%
    ##          Gentoo penguin (Pygoscelis papua)  46.8% 49.2% 4.0%

# 5. tabyl + other nice tables (kableExtra, gt)

The nice thing is that the output of `tabyl()` can be assigned as a dataframe object in your environment OR you can pipe on a `kable()`…

``` r
dupes_gone %>%
  tabyl(species, sex) %>%
  adorn_percentages("row") %>%
  adorn_pct_formatting() %>%
  kable() 
```

<table>
<thead>
<tr>
<th style="text-align:left;">
species
</th>
<th style="text-align:left;">
FEMALE
</th>
<th style="text-align:left;">
MALE
</th>
<th style="text-align:left;">
NA\_
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Adelie Penguin (Pygoscelis adeliae)
</td>
<td style="text-align:left;">
48.0%
</td>
<td style="text-align:left;">
48.0%
</td>
<td style="text-align:left;">
3.9%
</td>
</tr>
<tr>
<td style="text-align:left;">
Chinstrap penguin (Pygoscelis antarctica)
</td>
<td style="text-align:left;">
50.0%
</td>
<td style="text-align:left;">
50.0%
</td>
<td style="text-align:left;">
0.0%
</td>
</tr>
<tr>
<td style="text-align:left;">
Gentoo penguin (Pygoscelis papua)
</td>
<td style="text-align:left;">
46.8%
</td>
<td style="text-align:left;">
49.2%
</td>
<td style="text-align:left;">
4.0%
</td>
</tr>
</tbody>
</table>

… or a `gt()` to get a really nicely formatted summary table

``` r
dupes_gone %>%
  tabyl(species, sex) %>%
  adorn_percentages("row") %>%
  adorn_pct_formatting() %>%
  gt()
```

<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#lfftokllhe .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#lfftokllhe .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#lfftokllhe .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#lfftokllhe .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#lfftokllhe .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#lfftokllhe .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#lfftokllhe .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#lfftokllhe .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#lfftokllhe .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#lfftokllhe .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#lfftokllhe .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#lfftokllhe .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#lfftokllhe .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#lfftokllhe .gt_from_md > :first-child {
  margin-top: 0;
}

#lfftokllhe .gt_from_md > :last-child {
  margin-bottom: 0;
}

#lfftokllhe .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#lfftokllhe .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#lfftokllhe .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#lfftokllhe .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#lfftokllhe .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#lfftokllhe .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#lfftokllhe .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#lfftokllhe .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#lfftokllhe .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#lfftokllhe .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#lfftokllhe .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#lfftokllhe .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#lfftokllhe .gt_left {
  text-align: left;
}

#lfftokllhe .gt_center {
  text-align: center;
}

#lfftokllhe .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#lfftokllhe .gt_font_normal {
  font-weight: normal;
}

#lfftokllhe .gt_font_bold {
  font-weight: bold;
}

#lfftokllhe .gt_font_italic {
  font-style: italic;
}

#lfftokllhe .gt_super {
  font-size: 65%;
}

#lfftokllhe .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="lfftokllhe" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">species</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">FEMALE</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">MALE</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">NA_</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Adelie Penguin (Pygoscelis adeliae)</td>
      <td class="gt_row gt_left">48.0%</td>
      <td class="gt_row gt_left">48.0%</td>
      <td class="gt_row gt_left">3.9%</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Chinstrap penguin (Pygoscelis antarctica)</td>
      <td class="gt_row gt_left">50.0%</td>
      <td class="gt_row gt_left">50.0%</td>
      <td class="gt_row gt_left">0.0%</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Gentoo penguin (Pygoscelis papua)</td>
      <td class="gt_row gt_left">46.8%</td>
      <td class="gt_row gt_left">49.2%</td>
      <td class="gt_row gt_left">4.0%</td>
    </tr>
  </tbody>
  
  
</table></div>
