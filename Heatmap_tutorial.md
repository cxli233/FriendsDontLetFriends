
# Introduction 
This workflow is about how to programmatically reorder rows & columns of a heatmap. 
Heatmap is a versatile visualization method for many data types. 
However, for heatmaps to be effective, we should consider reordering rows & columns.
See [this figure](https://github.com/cxli233/FriendsDontLetFriends#5-friends-dont-let-friends-make-heatmap-without-considering-reordering-rows--columns) for an example.  

# Required Packages 
```{r}
library(tidyverse)
library(patchwork)

library(RColorBrewer)
```

# Data 
We will use this example data from my own research.
This is a collaboration between [Buell lab](https://buell-lab.github.io/) at UGA & [O'Connor lab](https://www.ice.mpg.de/) at Max Planck Institute.  

Don't worry about what this table is about, but this should work with any kind of data. 
This is a tidyverse workflow, so the input data do need to be in the tidy format. 
See [this tutorial](https://r4ds.had.co.nz/tidy-data.html) for info on tidy data. 

```{r}
my_data <- read_csv("../Data/heatmap_example.csv", col_types = cols())

head(my_data)
```

`row` and `col` will be what will used in a heatmap. 
The `value` column will be used to color the heatmap. 

# Without reordering
Let's see what will happen if we don't reorder the rows and columns. 
```{r}
no_reorder <- my_data %>% 
  ggplot(aes(x = col, y = row)) +
  geom_tile(aes(fill = value)) +
  scale_fill_gradientn(colors = brewer.pal(9, "YlGnBu")) +
  theme_classic() +
  theme(axis.text.y.left = element_blank(),
        axis.ticks.y.left = element_blank())

no_reorder

ggsave("../Results/Heatmap_no_reorder.svg", height = 3.5, width = 4.2, bg = "white")
ggsave("../Results/Heatmap_no_reorder.png", height = 3.5, width = 4.2, bg = "white")
```
![heatmap_no_reorder](https://github.com/cxli233/FriendsDontLetFriends/blob/main/Results/Heatmap_no_reorder.png)

As you can see, there is no pattern to be discern here. 

# Reorder one dimension first
To make it easier to discern information hidden in the heatmap, we need to reorder rows & columns. 
My approach is reordering one of dimensions (rows or columns) first. 
Often we can reorder one dimension based on some practical meaning. 
For example, is one dimension time series? Developmental stages? Different experimental conditions/treatments?
We can reorder one dimension first based on some practical meaning. 

## An example data where columns have practical meaning. 
Let's say we have an experiment with 10 genes and 6 samples. 
```{r}
my_data2 <- expand.grid(
  genes = letters[1:10],
  samples = 1:6)
```

And let's say samples 1, 3, 5 are controls, and samples 2, 4, 6 are treatments. 
And let's say we want to reorder it such that the controls appear first in (left) in the heatmap. 
```{r}
my_data2 <- my_data2 %>% 
  mutate(samples = factor(samples, 
                          levels = c(1, 3, 5, 2, 4, 6))) 

head(my_data2)
```

To order a column of the data frame, you can use `factor()`.
Within the `factor()` function, you type in the desired order in `levels = c(...)`. 

Now, when you go plot it, what will we see?
```{r}
my_data2 %>% 
  ggplot(aes(x = samples, y = genes)) +
  theme_classic()

ggsave("../Results/Reorder_1_dim.svg", height = 3, width = 3, bg = "white")
ggsave("../Results/Reorder_1_dim.png", height = 3, width = 3, bg = "white")
```
![Reorder_one_dimension](https://github.com/cxli233/FriendsDontLetFriends/blob/main/Results/Reorder_1_dim.png)

Now you can see that the x axis is in this order `1, 3, 5, 2, 4, 6`, which is the order we specified. 

# Programmatic reordering of rows and columns
What do we don't want to manually punch in the order? 
We can reorder one dimension using same basic statistics: __peak value__ and __number of peak values__.

* peak value: at which column does a given row reaches its maximum value?
* number of peak values: for any given column, how many rows reaches their maximum value? 

A really simple but effective way to order rows and columns is to reordering columns by number of peak values. 
After that, reorder rows by peak values. 

1. Columns that have most rows reaching peak value appear first (to the left of heatmap).
2. Columns that have the least rows reaching peak value appear last (to the right of the heatmap).
3. Rows that reaches peak value for the 1st column appears on top. 
4. Rows that reaches peak value for the last column appears on the bottom. 

It might be easier to understand how this plays out with an actual heatmap. 

## Finding peak values and number of peak values
Let's come back this our `my_data` example
To find the peak value for each row, use `group_by(row)` followed by `slice_max()`

```{r}
my_data_peak_values <- my_data %>% 
  group_by(row) %>% 
  slice_max(order_by = value, n = 1, with_ties = F) %>% 
  rename(peaked_at = col) %>% 
  select(-value)

head(my_data_peak_values)
```

Now we have a data frame, each row is a row that will appear in the heatmap. 
For each row, there is information on which column of the heatmap that it peaks at. 

To find how many rows peaked at each column, use `group_by(column)` followed by `count()`.
```{r}
number_of_peaks <- my_data_peak_values %>% 
  group_by(peaked_at) %>% 
  count() %>% 
  arrange(-n)

head(number_of_peaks) 
```
Now we have a data frame where each row is a column that will appear in the heatmap.
And we have information on how many rows peaked at that column. 

Now we will to reorder rows by columns. 
```{r}
my_data_peak_values_reordered <- my_data_peak_values %>% 
  inner_join(number_of_peaks, by = "peaked_at") %>% 
  arrange(-n)  

my_data_peak_values_reordered
```

After finding these basic statistics, we can join these statistics to our main data frame. 
```{r}
my_data_reordered <- my_data %>% 
  inner_join(number_of_peaks, by = c("col" = "peaked_at")) %>% 
  mutate(col = reorder(col, -n)) %>%  # this reorders the columns
  select(-n) %>% 
  inner_join(my_data_peak_values_reordered, by = "row") %>% 
  mutate(row = reorder(row, n)) # this reorders the rows
  

head(my_data_reordered)
```

# Now we can plot it
```{r}
reordered_heatmap <- my_data_reordered %>% 
  ggplot(aes(x = col, y = row)) +
  geom_tile(aes(fill = value)) +
  scale_fill_gradientn(colors = brewer.pal(9, "YlGnBu")) +
  theme_classic() +
  theme(axis.text.y.left = element_blank(),
        axis.ticks.y.left = element_blank())

reordered_heatmap
```

... and do a side by side comparison. 
```{r}
wrap_plots(no_reorder+ 
             labs(title = "Not reordered"), 
           reordered_heatmap +
             labs(title = "Rows/columns reordered"),
           guides = "collect") 

ggsave("../Results/Heatmap_reorder.svg", height = 3.5, width = 8, bg = "white")
ggsave("../Results/Heatmap_reorder.png", height = 3.5, width = 8, bg = "white")
```
![Side_by_side](https://github.com/cxli233/FriendsDontLetFriends/blob/main/Results/Heatmap_reorder.png)

Now we can see that a clear pattern emerged. 
Each column has a group of rows that reach peak level.
Overall, the heatmap is also much easier to understand and informative. 



