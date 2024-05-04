library(ggplot2)

# Load the data
unsheltered_data <- read.csv('C:/Users/Lola/Desktop/STAT80B_Project/final-project/data/homelessness_totals.csv')

# ------------ Cleaning data ----------------
# Calculate the quartiles
q1 <- quantile(unsheltered_data$unsheltered_homeless_2007, 0.25)
q3 <- quantile(unsheltered_data$unsheltered_homeless_2007, 0.75)

# Calculate the interquartile range
iqr <- q3 - q1

# Define the upper and lower bounds for outliers
lower_bound <- q1 - 1.5 * iqr
upper_bound <- q3 + 1.5 * iqr

# Remove outliers from the dataset
cleaned_data <- unsheltered_data[unsheltered_data$unsheltered_homeless_2007 >= lower_bound & unsheltered_data$unsheltered_homeless_2007 <= upper_bound, ]
# --------------------------------------------


# Convert 'county' to a factor for categorical plotting
cleaned_data$county <- factor(cleaned_data$county)

# Create the scatter plot
ggplot(cleaned_data, aes(x = unsheltered_homeless_2007, y = unsheltered_homeless_2017), color = county) +
  geom_point() +
  labs(title = "Scatter Plot of Homeless Counts (2007 vs. 2017) by County",
       x = "Unsheltered Homeless 2007",
       y = "Unsheltered Homeless 2017",
       color = "County") +
  theme_minimal()
