
library(tidyverse)
library(patchwork)
library(RColorBrewer)


a <- data.frame(
  x = c("a", "b", "c", "d", "e"),
  y = c(10, 20, 30, 450, 500)
)

lower <- a %>% 
  ggplot(aes(x = x, y = y)) +
  geom_bar(stat = "identity", aes(fill = x),
           width = 0.7, color = "black") +
  geom_text(aes(label = y), vjust = -0.2) +
  scale_fill_manual(values = brewer.pal(8, "Set2")) +
  theme_classic() +
  theme(legend.position = "none",
        axis.title.y = element_text(hjust =1 )) +
  coord_cartesian(ylim = c(0, 50))

upper1 <- a %>% 
  ggplot(aes(x = x, y = y)) +
  geom_bar(stat = "identity", aes(fill = x),
           width = 0.7, color = "black") +
  geom_text(aes(label = y), vjust = -0.2) +
  scale_fill_manual(values = brewer.pal(8, "Set2")) +
  labs(x = NULL,
       y = NULL) +
  theme_classic() +
  theme(legend.position = "none",
        axis.line.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.text.x = element_blank()) +
  coord_cartesian(ylim = c(400, 550))

upper2 <- a %>% 
  ggplot(aes(x = x, y = y)) +
  geom_bar(stat = "identity", aes(fill = x),
           width = 0.7, color = "black") +
  geom_text(aes(label = y), vjust = -0.2) +
  scale_fill_manual(values = brewer.pal(8, "Set2")) +
  labs(x = NULL,
       y = NULL) +
  theme_classic() +
  theme(legend.position = "none",
        axis.line.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.text.x = element_blank()) +
  coord_cartesian(ylim = c(450, 520))


broken1 <- wrap_plots(upper1, lower, nrow = 2) &
  theme(axis.text = element_text(color = "black"),
        text = element_text(size = 14))

 broken2 <- wrap_plots(upper2, lower, nrow = 2) &
  theme(axis.text = element_text(color = "black"),
        text = element_text(size = 14))

wrap_plots(broken1, broken2, nrow = 1)

ggsave("../Results/Broken_axis.svg", height = 4, width = 6, bg = "white")
ggsave("../Results/Broken_axis.png", height = 4, width = 6, bg = "white")




left <- a %>% 
  ggplot(aes(x = y, y = x)) +
  geom_bar(stat = "identity", aes(fill = x),
           width = 0.7, color = "black") +
  geom_text(aes(label = y), hjust = -0.2) +
  scale_fill_manual(values = brewer.pal(8, "Set2")) +
  theme_classic() +
  theme(legend.position = "none",
        axis.title.x = element_text(hjust =1 )) +
  coord_cartesian(xlim = c(0, 50))


right <- a %>% 
  ggplot(aes(x = y, y = x)) +
  geom_bar(stat = "identity", aes(fill = x),
           width = 0.7, color = "black") +
  geom_text(aes(label = y),hjust = -0.2) +
  scale_fill_manual(values = brewer.pal(8, "Set2")) +
  labs(x = NULL,
       y = NULL) +
  theme_classic() +
  theme(legend.position = "none",
        axis.line.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.y = element_blank()) +
  coord_cartesian(xlim = c(400, 600))

wrap_plots(left, right, nrow = 1) &
  theme(axis.text = element_text(color = "black"),
        text = element_text(size = 14))
