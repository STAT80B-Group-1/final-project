library(tidyverse)
library(ggplot2)

# data set of homelessness ct in CA
unsheltered_data <- read.csv('C:/Users/Lola/Desktop/STAT80B_Project/final-project/data/homelessness_totals.csv')

# ------------ Cleaning data ----------------
# Calculate the quartiles
q1 <- quantile(unsheltered_data$Total.Homeless..2017, 0.25)
q3 <- quantile(unsheltered_data$Total.Homeless..2017, 0.75)

# Calculate the interquartile range
iqr <- q3 - q1

# Define the upper and lower bounds for outliers
lower_bound <- q1 - 1.5 * iqr
upper_bound <- q3 + 1.5 * iqr

# Remove outliers from the dataset
cleaned_data <- unsheltered_data[unsheltered_data$Total.Homeless..2017 >= lower_bound & unsheltered_data$Total.Homeless..2017 <= upper_bound, ]
# --------------------------------------------
boxplot(cleaned_data$Total.Homeless..2017,
        names = c("Total Homeless"),
        main = "Comparison of Total homeless Counts, 2017",
        xlab = "Total homeless, 2017", ylab = "Count")
