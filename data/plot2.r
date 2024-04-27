# data set of homelessness ct in CA

sheltered_data <- read.csv('C:/Users/Lola/Desktop/STAT80B_Project/final-project/data/homelessness_edited.csv')

# Filter the data for Santa Cruz county in California
santa_cruz_data <- sheltered_data %>%
  filter(county == "Santa Cruz" & state_name == "California")

# Select the columns for sheltered homeless counts from 2007 to 2017
santa_cruz_counts <- select(santa_cruz_data, starts_with("sheltered_homeless_"))

# Reshape the data for plotting
santa_cruz_counts_long <- pivot_longer(santa_cruz_counts, cols = everything(), names_to = "Year", values_to = "Count")

# Plot the data
ggplot(santa_cruz_counts_long, aes(x = as.integer(sub("sheltered_homeless_", "", Year)), y = Count)) +
  geom_line() +
  labs(x = "Year", y = "Sheltered Homeless Count", title = "Sheltered Homelessness in Santa Cruz County (2007-2017)") + scale_x_continuous(breaks = c(2007, 2010, 2012, 2015, 2017), labels = c(2007, 2010, 2012, 2015, 2017))
