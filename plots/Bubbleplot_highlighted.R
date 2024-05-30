library(ggplot2)
library(dplyr)
# Load the dataset
homelessness_data <- read.csv('C:/Users/karee/Documents/final-project/data/homelessness_totals.csv')

# View the initial data structure
View(homelessness_data)

# Isolate columns that have "Total" in the name and the corresponding counties
selected_data <- homelessness_data %>%
  select(county, contains("Total"))




# Isolating the years and totals
reshaped_data <- selected_data %>%
  pivot_longer(cols = starts_with("Total"), names_to = "year", values_to = "totals")%>%
  mutate(year = str_replace(year, "Total.Homeless..", "")) # removing letters from year values


# Calculating rate of change
rate_of_change <- reshaped_data %>%
  group_by(county) %>%
  mutate(rates = (totals / totals[year == 2007] - 1) * 100,
  Polarity = ifelse(rates >= 0, "Positive", "Negative"), # Denoting Positivity and Negativity
  Highlight = ifelse(county == "Santa Cruz", "Santa Cruz", "Not Santa Cruz"))%>%
  filter(year != 2007)  # Exclude the year 2007
View(rate_of_change)
# Graphing bubble chart
ggplot(rate_of_change, aes(x = year, y = county, size = abs(rates), color = Polarity, fill = Highlight)) +
  geom_point(aes(alpha = Highlight), shape = 21, stroke = 1.5) +  # Adjust stroke for thicker outlines
  scale_color_manual(values = c("Positive" = "blue", "Negative" = "red")) +
  scale_fill_manual(values = c("Santa Cruz" = "gold", "Not Santa Cruz" = "grey"), guide = "none") +
  scale_size(range = c(3, 10)) +  # Adjust range for larger bubbles
  labs(title = "Homeless Rate of Change by County Compared to 2007",
       x = "Year",
       y = "Rate of Change (%)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
