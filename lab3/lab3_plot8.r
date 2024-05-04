# Load the data
unsheltered_data <- read.csv('C:/Users/Lola/Desktop/STAT80B_Project/final-project/data/homelessness_totals.csv')

# ------------ Cleaning data ----------------
# Calculate the quartiles
q1 <- quantile(unsheltered_data$unsheltered_homeless_2017, 0.25)
q3 <- quantile(unsheltered_data$unsheltered_homeless_2017, 0.75)

# Calculate the interquartile range
iqr <- q3 - q1

# Define the upper and lower bounds for outliers
lower_bound <- q1 - 1.5 * iqr
upper_bound <- q3 + 1.5 * iqr

# Remove outliers from the dataset
cleaned_data <- unsheltered_data[unsheltered_data$unsheltered_homeless_2017 >= lower_bound & unsheltered_data$unsheltered_homeless_2017 <= upper_bound, ]
# --------------------------------------------

# Side-by-side boxplot
boxplot(unsheltered_homeless_2017 + sheltered_homeless_2017 ~ county, data = cleaned_data,
        main = "Homeless Counts by Shelter Status and County, 2017",
        xlab = "County", ylab = "Count",
        col = c("blue", "red"), las = 2, outline = FALSE)