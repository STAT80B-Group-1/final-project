library(tidyverse)
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggrepel)
# data set of homelessness ct in CA
data <- read.csv('C:/Users/karee/OneDrive/Documents/GitHub/final-project/data/homelessness_totals.csv')

# Filter the data for Santa Cruz county in California
santa_cruz_data <- data %>%
  filter(county == "Santa Cruz" & state_name == "California")

# Select the columns for unsheltered homeless counts from 2007 to 2017
unsheltered_data <- santa_cruz_data %>%
  select(starts_with("unsheltered_homeless_")) %>%
  pivot_longer(cols = everything(), names_to = "Year", values_to = "Count") %>%
  mutate(Type = "Unsheltered")

# Select columns for the sheltered count from 07-17
sheltered_data <- santa_cruz_data %>%
  select(starts_with("sheltered_homeless_")) %>%
  pivot_longer(cols = everything(), names_to = "Year", values_to = "Count") %>%
  mutate(Type = "Sheltered")

# combine the sheltered and unsheltered data
combined_data <- bind_rows(unsheltered_data, sheltered_data)

annotation <- data.frame(
  x = 2014, y = 2895, 
  label = "In 2014, \n the Departnment of HUD \n changed their\n data collection \n standards"
)
# Plot the combined data
ggplot(combined_data, aes(x = as.integer(sub(".*_(\\d+)", "\\1", Year)), y = Count, color = Type)) +
  geom_line(size = 1.5) +  # Adjust line thickness
  labs(
    x = "Year",
    y = "Homeless Count",
    title = "Sheltered vs Unsheltered Homelessness in Santa Cruz County (2007-2017)",
    color = "Type"
  ) + 
  geom_label_repel(data=annotation, aes( x=x, y=y, label=label, nudge_x = 2017, nudge_y = 4000),                 , 
                       color="darkblue", 
                       size=6 , angle=0, fontface="bold" ) +
  geom_point(aes(x=2014,y=2895),         
             color='darkblue',
             size=3) +
  scale_color_manual(values = c("Sheltered" = "red", "Unsheltered" = "blue")) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    axis.title = element_text(size = 12),
    axis.text = element_text(size = 10),
    legend.title = element_text(size = 12),
    legend.text = element_text(size = 10)
  ) +
  scale_x_continuous(
    breaks = c(2007, 2010, 2012, 2015, 2017),
    labels = c(2007, 2010, 2012, 2015, 2017)
  )


