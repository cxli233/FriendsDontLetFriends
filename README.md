# Friends Don't Let Friends Make Bad Graphs 


[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.7542491.svg)](https://doi.org/10.5281/zenodo.7542491)


Friends don't let friends make certain types of data visualization - What are they and why are they bad. 

* Author: Chenxin Li, postdoctoral associate at Center for Applied Genetic Technologies, University of Georgia. 
* Contact: [Chenxin.Li@uga.edu](Chenxin.Li@uga.edu) | [@ChenxinLi2](https://twitter.com/ChenxinLi2) 

This is an *opinionated* essay about good and bad practices in data visualization. 
Examples and explanations are below. 

The `Scripts/` directory contains `.Rmd` files that generate the graphics shown below. 
It requires R, RStudio, and the rmarkdown package. 

* R: [R Download](https://cran.r-project.org/bin/)
* RStudio: [RStudio Download](https://www.rstudio.com/products/rstudio/download/)
* rmarkdown can be installed using the install packages interface in RStudio

# Table of contents

1. [Friends Don't Let Friends Make Bar Plots For Mean Separation](https://github.com/cxli233/FriendsDontLetFriends#1-friends-dont-let-friends-make-bar-plots-for-means-separation)
2. [Friends Don't Let Friends Make Violin Plots](https://github.com/cxli233/FriendsDontLetFriends#2-friends-dont-let-friends-make-violin-plots)
3. [Friends Don't Let Friends Use Bidirectional Color Scales for Unidirectional Data](https://github.com/cxli233/FriendsDontLetFriends#3-friends-dont-let-friends-use-bidirectional-color-scales-for-unidirectional-data)
4. [Friends Don't Let Friends Make Bar Plot Meadow](https://github.com/cxli233/FriendsDontLetFriends#4-friends-dont-let-friends-make-bar-plot-meadow)
5. [Friends Don't Let Friends Make Heatmap without Reordering Rows & Columns](https://github.com/cxli233/FriendsDontLetFriends#5-friends-dont-let-friends-make-heatmap-without-considering-reordering-rows--columns)
6. [Friends Don't Let Friends Make Heatmap without Checking Outliers](https://github.com/cxli233/FriendsDontLetFriends#6-friends-dont-let-friends-make-heatmap-without-checking-outliers)
7. [Friends Don't Let Friends Forget to Check Data Range at Each Factor Level](https://github.com/cxli233/FriendsDontLetFriends#7-friends-dont-let-friends-forget-to-check-data-range-at-each-factor-level)
8. [Friends Don't Let Friends Make Network Graphs without Trying Different Layouts](https://github.com/cxli233/FriendsDontLetFriends#8-friends-dont-let-friends-make-network-graphs-without-trying-different-layouts) 
9. [Friends Don't Let Friends Confuse Position and Length Based Visualizations](https://github.com/cxli233/FriendsDontLetFriends#9-friends-dont-let-friends-confuse-position-based-visualizations-with-length-based-visualizations) 
10. [Friends Don't Let Friends Make Pie Charts](https://github.com/cxli233/FriendsDontLetFriends#10-friends-dont-let-friends-make-pie-chart) 
11. [Friends Don't Let Friends Make Concentric Donuts](https://github.com/cxli233/FriendsDontLetFriends#11-friends-dont-let-friends-make-concentric-donuts)
12. [Friends Don't Let Friends Use Red/green and Rainbow for Color Scales](https://github.com/cxli233/FriendsDontLetFriends#12-friends-dont-let-friends-use-redgreen-and-rainbow-color-scales)
13. [Friends Don't Let Friends Forget to Reorder Stacked Bar Plot](https://github.com/cxli233/FriendsDontLetFriends/tree/main#13-friends-dont-let-friends-forget-to-reorder-stacked-bar-plot)

# 1. Friends Don't Let Friends Make Bar Plots for Means Separation

This has to be the first one. 
Means separation plots are some of the most common in scientific publications. 
We have two or more groups, which contains multiple observations; they may have different means, variances, and distributions. 
The task of the visualization is to show the means and the spread (dispersion) of the data. 

![No Bar Plots for Means Separation](https://github.com/cxli233/FriendsDontLetFriends/blob/main/Results/dont_bar_plot.png) 

In this example, two groups have similar means and standard deviations, but quite different distributions. **Are they really "the same"?**
Just don't use bar plot for means separation, or at least check a couple things before settling down on a bar plot. 

It's worth mentioning that I was inspired by many researchers who have tweeted on the limitation of bar graphs. 
Here is a pulication: [Weissgerber et al., 2015, PLOS Biology](https://journals.plos.org/plosbiology/article?id=10.1371/journal.pbio.1002128). 

# 2. Friends Don't Let Friends Make Violin Plots 

Violin plots don't help your reader to understand the data. The whole justification is that regular box plots may misrepresent multimodel data distributions, so you want to show the data. But violin plots don't have units and tick marks that allow people to actually read the data and compare the distributions. Also the selection of the probability density function for the smoothing is almost never explained, and may even be completely misleading with small datasets.

![Beware of Violin Plots for Small Sample Sizes](https://github.com/cxli233/FriendsDontLetFriends/blob/main/Results/Beware_of_small_n_box_violin_plot.png) 

- If your data is multimodal or has an intersting distribution use a histogram or multiple stacked histograms.
- If your data is not multimodal and you want to show averages and quartiles, just use a box plot.

![Violin Plots should not exist](https://youtu.be/_0QMKFzW9fw?si=o18kDWN5qSeaNfXV)

# 3. Friends Don't Let Friends Use Bidirectional Color Scales for Unidirectional Data 

Excuse my language, but this is a truly data visualization sin, and again quite common. 
I can understand why this error is common, because it appears that many of us have not spent a lot of thoughts on this issue. 

![Are You Using the Right Color Scale for Your Data?](https://github.com/cxli233/FriendsDontLetFriends/blob/main/Results/ColorScales.svg)

Color scales are pretty, but we have to be extra careful.
When color scales (or color gradients) are used to represent numerical data, the darkest and lightest colors should have special meanings.
You can decide what those special meanings are: e.g., max, min, mean, zero. But they should represent something meaningful. 
A data visualization sin for heat maps/color gradients is when the lightest or darkers colors are some arbitrary numbers. 
*This is as bad as the longest bar in a bar chart not being the largest value.* Can you imagine that?  

# 4. Friends Don't Let Friends Make Bar Plot Meadow 

We talked about no bar charts for mean separation, but this is a different issue. 
It has to do with presenting results of a multi-factorial experiment. 
Bar plot meadows are very common in scientific publications and unfortunately also *ineffective* in communicating the results. 

![Horrendous Giant Bar Plot vs. Better Designed Plot](https://github.com/cxli233/FriendsDontLetFriends/blob/main/Results/AvoidBarPlotMeadow.png)

Data from: [Matand et al., 2020, BMC Plant Biology](https://link.springer.com/article/10.1186/s12870-020-2243-7)

Bar plot meadows are common because multi-factorial experiments are common. 
However, a bar plot meadow is poorly designed for its purpose. 
To communicate results of a multi-factorial experiment, it requires thoughtful designs regarding grouping/faceting by factors of interest.

In this example, I focus on comparing the effect of `Treatment` & `Explant` on `Response` at the level of each `Variety`. 
However, if the focus is the effect of `Treatment` & `Variety` on `Response` at the level of each `Exaplant`, then it will require a different layout. 

# 5. Friends Don't Let Friends Make Heatmap without (Considering) Reordering Rows & Columns 

Heatmaps are very common in scientific publications, and *very very* common in omics papers. 
However, for heatmaps to be effective, we have to consider the ordering of rows & columns. 

![A Heatmap before and after reordering rows and columns](https://github.com/cxli233/FriendsDontLetFriends/blob/main/Results/Reorder_rows_and_columns_for_heatmap.png) 

In this example, I have cells as columns and features as rows. Grids are showing z scores. 
It is impossible to get anything useful out of the heatmap without reordering rows and columns. 
We can reorder rows and columns using clustering, but that is not the only way. 
Of course, if the rows and columns are mapping to physical entities (rows and columns of a 96-well plate), then you can't reorder them. 
But it is a very good idea to at least consider reordering rows and columns. 

Data from: [Li et al., 2022, BioRxiv](https://www.biorxiv.org/content/10.1101/2022.07.04.498697v1) 

## Bonus: heatmaps can be very pretty

...if you are good are reordering rows/columns and choosing color gradients. 
Here is an example "abstract aRt" generated from simulated data. 

![aRt with Heatmap](https://github.com/cxli233/FriendsDontLetFriends/blob/main/Results/Abstract_R_2022_11_24.svg)        

R code for this aRt piece can be found [here](https://github.com/cxli233/FriendsDontLetFriends/blob/main/Scripts/Abstract_aRt.R). 

For a tutorial on how to reorder rows and columns of a heatmap, see this [markdown file](https://github.com/cxli233/FriendsDontLetFriends/blob/main/Heatmap_tutorial.md). 

# 6. Friends Don't Let Friends Make Heatmap without Checking Outliers 

Outliers in heatmap can really change how we perceive and interpret the visualization. 
This generalizes to all sort of visualizations that use colors to represent numeric data.
Let me show you an example:

![Did you check outliers](https://github.com/cxli233/FriendsDontLetFriends/blob/main/Results/Check_outliers_for_heatmap.svg)

In this example, I have 2 observations. For each observations, I measured 20 features. 
Without checking for outliers, it may appear that the 2 observations are overall similar, except at 2 features. 
However, after maxing out the color scale around 95th percentile of the data, it reveals that the two observations are distinct across all features. 

# 7. Friends Don't Let Friends Forget to Check Data Range at Each Factor Level 

This is a common issue that many of us have encountered. 
In a multifactor experiment, sometimes the range of the response variable changes widely between different factor levels. 

![Did you check data range at each factor level](https://github.com/cxli233/FriendsDontLetFriends/blob/main/Results/Check_range_at_factor_level.svg)

This hypothetical experiment measured 3 compounds across 2 groups (control vs. treatment). 
Without checking data range for each compound, you will likely have missed that the treatment had a strong effect on compound 1.
This is because the concentration of compound 1 has a much narrower range than the other compounds in this experiment. 

# 8. Friends Don't Let Friends Make Network Graphs without Trying Different Layouts

Network graphs are common in scientific publications. They are super useful in presenting relationship data. 
However, the apparence (not the topology) of the network can make a huge difference in determing if a network graph is effective. 

![Try different network layouts](https://github.com/cxli233/FriendsDontLetFriends/blob/main/Results/TryDifferentLayouts.svg) 

Layouts can drastically change the appearance of networks, making them easier or harder to interpret.
Here are 3 network graphs from the same data. They look very different from each other.
Data from: [Li et al., 2022, BioRxiv](https://www.biorxiv.org/content/10.1101/2022.07.04.498697v1) 

# 9. Friends Don't Let Friends Confuse Position-based Visualizations with Length-based Visualizations 

This is always the elephant in the room and the essence of many misleading visualizations. 
In this example, I measured a response variable across 3 time points. 
Two of the following graphs are fine, but one of them is a data visualization crime. Can you see why? 

![Position vs. length based visualizations](https://github.com/cxli233/FriendsDontLetFriends/blob/main/Results/Position_and_length_based_visualizations.svg)

In dot and line plots, values are represented by positions along the x and y axis.
The same idea applies to other position based visualizations, such as box plots. 
In bar plots, values are represented by the distance from the x axis, and thus the length of the bar. 

The 3rd graph is not 0-based, which makes the bar length at time point 2 about 3x longer than that at time point 1.
In fact, the true difference in means is closer to 1.6x. 
I hope you can see how confusing length and position based visualizations can lead to misleading graphs.   

## Watch out for bar plots with broken axis 

Broken axis may be useful for depicting data across a wide range of numeric values. 
(Alternatively, log scaled axis can be used instead.) 
Broken axis are fine for position based graphics, because the data are represented by positions along the axis. 
However, we must be very careful with bar plots that have broken axis. Here is an example. 

![Broken axis](https://github.com/cxli233/FriendsDontLetFriends/blob/main/Results/Broken_axis.svg) 

In this example, two graphs (left vs. right) are showing the same data. 
However, by changing where the axis is broken, one can make certain bars looks longer or shorter. 
In this example, the length of bar "d" can look *really* different.
The illusion of bar "d" being very short on the right graph boils down to bar plot being a length based graphics, not a position based graphics. 

Example R code for broken axis can be found [here](https://github.com/cxli233/FriendsDontLetFriends/blob/main/Scripts/Broken_axis.R). 

# 10. Friends Don't Let Friends Make Pie Chart 

Pie chart is a common type of visualization for fractional data, where fractions add up to 100%. 
This is achieved by dividing a circle into sectors, and the sectors add up to a full circle. 
Pie charts have been criticized, because human are much worse in reading angles and area than reading lengths. 
Here is a [blog post](https://www.data-to-viz.com/caveat/pie.html) that explores that. 

![Don't make pie charts](https://github.com/cxli233/FriendsDontLetFriends/blob/main/Results/dont_pie_chart.svg)

In this example, we have two groups, each contains 4 sub-categories. 
In classic pie charts, the angles (and thus arc lengths & sector area) represent the data. 
The problem is that it is *very* difficult to compare between groups. 
We can visually simplify the pie chart into donut charts, where the data are now represented by arc lengths. 
However, if we want to use lengths to represent the data, why don't we just unwrap the donut and make stacked bars?
In stacked bar graphs, bars are shown side-by-side and thus easier to compare across groups. 

Fun fact: the scripts underlying stacked bars are much simpler than those underlying the pie charts and donut charts.
If you want to produce sub-optimal graph types with ggplot, you actually have to work extra hard.

# 11. Friends Don't Let Friends Make Concentric Donuts

In this example, we have 3 groups, each of which contains two sub-categories (Type I or Type II). 

![Don't make concentric donuts](https://github.com/cxli233/FriendsDontLetFriends/blob/main/Results/dont_concentric_donuts.svg)

In concentric donuts, you might be tempted to say the data are represented by the arc lengths, which is in fact **inaccurate**. 
The arc lengths on the outer rings are much longer than those in the inner rings. 
Group 2 and Group 3 have the same exact values, but the arc lengths of Group 3 are much longer. 
In fact the data are represented by the *arc angles*, which we are bad at reading. 

Since outer rings are longer, the ordering of the groups (which group goes to which ring) has a big impact on the impression of the plot.
It can lead to the apparent paradox where larger values have shorter arcs. 
The better (and simpler!) alternative is just unwrap the donuts and make a good old stacked bar plot. 
BTW, this is also my main issue with [circos plots](http://circos.ca/) and other circular plot layouts.

# 12. Friends Don't Let Friends Use Red/Green and Rainbow color scales

![are you making a "safe" heatmap?](https://github.com/cxli233/FriendsDontLetFriends/blob/main/Results/Color_blind_grey_scale_safe_heatmap.svg)

Deuteranomaly is the most common type of red/green colorblindness, occurring in 1/16 male and 1/256 female. 
Any color scales that use shades of red and shades of green in the same time would be a problem for a person with red/green colorblindness (third column of the figure). 
In addition, red/green and rainbow do not preserve information well at all when printed on black/white (grey scale, second column in figure). 
Many scientific software still use red/green or rainbow as the default color scales, which drives me crazy. 
More "modern" color scales, such as [viridis](https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html) are both colorblind-friendly and grey scale-safe (third row of figure). 
And they look nice too. 

# 13. Friends Don't Let Friends Forget to Reorder Stacked Bar Plot
Stacked bar plots are useful for visualizing proportion data. 
Stacked bar plots are commonly used to visualize community structure or population structure or admixture analysis. 
This kind of visualization boils down to a collection of samples, where each sample contains multiple classes of members. 
However, when we have many samples and many classes, stacked bar plots need to be optimized to be effective. 
And by "optimize" I mean the grouping and ordering of samples. 

![Reorder your stacked bars](https://github.com/cxli233/FriendsDontLetFriends/blob/main/Results/Reorder_stacked_bars.png)

Here we have an example data with 100 samples and 8 classes of member. 
Due to the number of samples and classes, it is very hard to discern anything from this graph without optimizing the order of bars. What the heck am I looking at? 
After reordering the bars, __wow__, that really made a difference, don't you think? 
For a tutorial on how to optimize a stack bar plot, see [this script](https://github.com/cxli233/FriendsDontLetFriends/blob/main/Scripts/stacked_bars_optimization.Rmd).

# Conclusion (?)

That's it for now. I will update this when I have the time (and inspirations) to produce more examples. 
Not sure what the next one will be, but stay tuned! 
