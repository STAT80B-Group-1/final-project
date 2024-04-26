# install.packages("tidyverse")
# install.packages("ggplot2")
# install.packages("dplyr")

library(tidyverse)

# data set of homelessness ct in CA
unsheltered_data <- read.csv('C:/Users/Lola/Desktop/STAT80B_Project/final-project/data/homelessness_edited.csv')

# filter the data for Santa Cruz County, CA
santa_cruz_data <- unsheltered_data %>%
  filter(county == "Santa Cruz" & state_name == "California")

# select the columns for unsheltered homeless counts from 2007 to 2017
santa_cruz_counts <- select(santa_cruz_data, starts_with("unsheltered_homeless_"))

# reshape the data for plotting
santa_cruz_counts_long <- pivot_longer(santa_cruz_counts, cols = everything(), names_to = "Year", values_to = "Count")

# plot data!!!
ggplot(santa_cruz_counts_long, aes(x = as.integer(sub("unsheltered_homeless_", "", Year)), y = Count)) +
  geom_line() +
  labs(x = "Year", y = "Unsheltered Homeless Count", title = "Unsheltered Homelessness in Santa Cruz County (2007-2017)") + scale_x_continuous(breaks = c(2007, 2010, 2012, 2015, 2017), labels = c(2007, 2010, 2012, 2015, 2017))
