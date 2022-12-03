# Dependencies 
library(tidyverse)
library(patchwork)

library(RColorBrewer)
library(viridis)
library(rcartocolor)

set.seed(666)

# setwd("../Desktop/Li/OtherCoding/FriendsDontLetFriends/Scripts/")

# Data 
my_data <- expand.grid(
  x = 1:21,
  y = 1:21) %>% 
  mutate(
    group_x = case_when(
      x <= 6 ~ 1,
      x > 6 & x <= 11 ~ 2,
      x > 11 & x <= 15 ~ 3,
      x > 15 & x <= 18 ~ 4,
      x > 18 & x <= 20 ~ 5,
      x > 20 ~ 6
    )
  ) %>% 
  mutate(
    group_y = case_when(
      y <= 6 ~ 1,
      y > 6 & y <= 11 ~ 2,
      y > 11 & y <= 15 ~ 3,
      y > 15 & y <= 18 ~ 4,
      y > 18 & y <= 20 ~ 5,
      y > 20 ~ 6
    )
  ) %>%
  mutate(group_sq = (group_x - group_y)^2) %>% 
  mutate(
    fill = case_when(
      group_sq == 0 ~ 2,
      group_sq == 1 ~ 0.5,
      group_sq == 4 ~ 0,
      group_sq == 9 ~ -0.5,
      group_sq == 16 ~ -1,
      group_sq == 25 ~ -2
    )
  ) %>%
  cbind(
    noise = rnorm(n = nrow(.), mean = 0, sd = 0.25)
  ) %>% 
  mutate(fill2 = fill + noise)
  
# Graph

heatmap <- my_data %>% 
  ggplot(aes(x = x , y = y)) +
  facet_grid(group_y ~ group_x, space = "free", scales = "free") +
  geom_tile(aes(fill = fill2)) +
  scale_fill_gradientn(colors = rev(brewer.pal(11, "RdBu")),
                      limits = c(-max(my_data$fill2), max(my_data$fill2))) +
  labs(x = NULL,
       y = NULL)+
  theme_minimal()+
  theme(
    strip.text = element_blank(),
    strip.background = element_blank(),
    panel.grid = element_blank(),
    axis.text = element_blank(),
    legend.position = "none"
  )

strip_left <- my_data %>% 
  filter(x == 1) %>% 
  ggplot(aes(x = 1, y = y)) +
  facet_grid(group_y ~ group_x, space = "free", scales = "free") + 
  geom_tile(aes(fill = group_y)) +
  scale_fill_gradientn(colors = viridis(n = 256)) +
  labs(x = NULL,
       y = NULL)+
  theme_minimal()+
  theme(
    strip.text = element_blank(),
    strip.background = element_blank(),
    panel.grid = element_blank(),
    axis.text = element_blank(),
    legend.position = "none"
    )


strip_bottom <- my_data %>% 
  filter(y == 1) %>% 
  ggplot(aes(x = x, y = 1)) +
  facet_grid(group_y ~ group_x, space = "free", scales = "free") + 
  geom_tile(aes(fill = group_x)) +
  scale_fill_gradientn(colors = rev(carto_pal(7, "Magenta"))) +
  labs(x = NULL,
       y = NULL)+
  theme_minimal()+
  theme(
    strip.text = element_blank(),
    strip.background = element_blank(),
    panel.grid = element_blank(),
    axis.text = element_blank(),
    legend.position = "none"
  )

wrap_plots(
  heatmap, strip_left,
  strip_bottom, 
  nrow = 2, ncol = 2,
  widths = c(1, 0.04),
  heights = c(1, 0.04)
)

ggsave("../Results/Abstract_R_2022_11_24.png", height = 2.5, width = 2.5, bg = "white")
ggsave("../Results/Abstract_R_2022_11_24.svg", height = 2.5, width = 2.5, bg = "white")