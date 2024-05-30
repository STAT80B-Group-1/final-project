library(ggplot2)
library(dplyr)
# Load the dataset
homelessness_data <- read.csv('C:/Users/karee/Documents/final-project/data/homelessness_totals.csv')

# View the initial data structure
View(homelessness_data)

# Isolate columns that have "Total" in the name and the corresponding counties
selected_data <- homelessness_data %>%
  select(county, contains("Total"))

# View the resulting data
View(selected_data)

# Isolating the years and totals
reshaped_data <- selected_data %>%
  pivot_longer(cols = starts_with("Total"), names_to = "year", values_to = "totals")%>%
  mutate(year = str_replace(year, "Total.Homeless..", ""))
View(reshaped_data)

# Calculating rate of change
rate_of_change <- reshaped_data %>%
  group_by(county) %>%
  mutate(rates = (totals / totals[year == 2007] - 1) * 100,
  Polarity = ifelse(rates >= 0, "Positive", "Negative"))%>%# Denoting Positivity and Negativity
  filter(year != 2007)  # Exclude the year 2007 
# Graphing bubble chart
ggplot(rate_of_change, aes(x = year, y = county, size = abs(rates), color = Polarity, fill = county)) +
  geom_point(alpha = 0.7, shape = 21, stroke = 1.5) + 
  scale_color_manual(values = c("Positive" = "blue", "Negative" = "red")) +
  scale_size(range = c(2, 10)) + 
  labs(title = "Homeless Rate of Change by County Compared to 2007",
       x = "Year",
       y = "Rate of Change (%)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
