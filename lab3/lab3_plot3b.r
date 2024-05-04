library(tidyverse)
library(ggplot2)

# data set of homelessness ct in CA
unsheltered_data <- read.csv('C:/Users/Lola/Desktop/STAT80B_Project/final-project/data/homelessness_totals.csv')

# ------------ Cleaning data ----------------
# Calculate the quartiles
q1 <- quantile(unsheltered_data$sheltered_homeless_2017, 0.25)
q3 <- quantile(unsheltered_data$sheltered_homeless_2017, 0.75)

# Calculate the interquartile range
iqr <- q3 - q1

# Define the upper and lower bounds for outliers
lower_bound <- q1 - 1.5 * iqr
upper_bound <- q3 + 1.5 * iqr

# Remove outliers from the dataset
cleaned_data <- unsheltered_data[unsheltered_data$sheltered_homeless_2017 >= lower_bound & unsheltered_data$sheltered_homeless_2017 <= upper_bound, ]
# --------------------------------------------

boxplot(cleaned_data$sheltered_homeless_2017,
        names = c("Sheltered Homeless"),
        main = "Total sheltered homeless Counts, 2017",
        xlab = "sheltered homeless, 2017", ylab = "Count")
