# Friends Don't Let Friends Make Bad Graphs 
Friends don't let friends make certain types of data visualization - What are they and why are they bad. 

  Author: Chenxin Li, postdoctoral associate at Center for Applied Genetic Technologies, University of Georgia. 

  Contact: [Chenxin.Li@uga.edu](Chenxin.Li@uga.edu)

This is an *opinionated* essay about good and bad practices in data visualization. 
Examples and explanations are below. 

The `Scripts/` directory contains `.Rmd` files that generate the graphics shown below. 
It requires R, RStudio, and the rmarkdown package. 

* R: [R Download](https://cran.r-project.org/bin/)
* RStudio: [RStudio Download](https://www.rstudio.com/products/rstudio/download/)
* rmarkdown can be installed using the intall packages interface in RStudio

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

# 2. Friends Don't Let Friends Make Violin Plots for Small Sample Sizes 

This is quite common in the literature as well, but unfortunately, violin plots (or any sort of smoothed distribution curves) make no sense for small n. 

![Beware of Violin Plots for Small Sample Sizes](https://github.com/cxli233/FriendsDontLetFriends/blob/main/Results/Beware_of_small_n_box_violin_plot.png) 

Distributions and quartiles can vary widely with small n, even if the underlying observations are similar. 
Distribution and quartiles are only meaningful with large n. 
I did an experiment before, where I sampled the *same* normal distribution several times and computed the quartiles for each sample.
The quartiles only stablize when n gets larger than 50. 

# 3. Friends Don't Let Friends Use Bidirectional Color Scales for Unidirectional Data 

Excuse my language, but this is a truly data visualization sin, and again quite common. 
I can understand why this error is common, because it appears that many of us have not spent a lot of thoughts on this issue. 

![Are You Using the Right Color Scale for Your Data?](https://github.com/cxli233/FriendsDontLetFriends/blob/main/Results/ColorScales.png)

Color scales are pretty, but we have to be extra careful.
When color scales (or color gradients) are used to represent numerical data, the darkest and lightest colors should have special meanings.
You can decide what those special meanings are: e.g., max, min, mean, zero. But they should represent something meaningful. 
A data visualization sin for heat maps/color gradients is when the lightest or darkers colors are some arbitrary numbers. 
*This is as bad as the longest bar in a bar chart not being the largest value.* Can you imagine that?  

# 4. Friends Don't Let Friends Make Bar Plot Meadow 

We talked about no bar charts for means separation, but this is a different issue. 
It has to do with presenting results of a multi-factorial experiment. 
Bar plot meadows are very common in scientific publications and unfortunately also *ineffective* in communicating the results. 

![Horrendous Giant Bar Plot vs. Better Designed Plot](https://github.com/cxli233/FriendsDontLetFriends/blob/main/Results/AvoidBarPlotMeadow.png)

Data from: [Matand et al., 2020, BMC Plant Biology](https://link.springer.com/article/10.1186/s12870-020-2243-7)

Bar plot meadows are common because multi-factorial experiments are common. 
However, bar plot meadows are poorly designed for its purpose. 
To communicate results of a multi-factorial experiment, it requires thoughtful designs regarding grouping/faceting by factors of interest.

In this example, I focus on comparing the effect of `Treatment` & `Explant` on `Response` at the level of each `Variety`. 
However, if the focus is the effect of `Treatment` & `Variety` on `Response` at the level of each `Exaplant`, then it will require a different layout. 

# 5. Friends Don't Let Friends Make Heatmap without (Considering) Reordering Rows & Columns 

Heatmaps are very common in scientific publications, and *very very* common in omics papers. 
However, for heatmaps to be effective, we have to consider the ordering of rows & columns. 

![A Heatmap before and after reordering rows and columns](https://github.com/cxli233/FriendsDontLetFriends/blob/main/Results/Reorder_rows_and_columns_for_heatmap.png?raw=true) 

In this example, I have cells as columns and features as rows. Each grid is showing z scores. 
It is impossible to get anything useful out of the heatmap without reordering rows and columns. 
We can reorder rows and columns using clustering, but that is not the only way. 
Of course, if the rows and columns are mapping to physical entities (rows and columns of a 96-well plate), then you can't reorder them. 
But it is a very good idea to at least consider reordering rows and columns. 

# Conclusion (?)

That's it for now. I will update this when I have the time (and inspirations) to produce more examples. 
The next one is probably "Friends Don't Let Friends Make Heatmap without Checking distribution of values". Stay tuned.
