# # Read the HPI data from the CSV file
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggrepel)
# Read the HPI data from the CSV file
'C:/Users/Lola/Downloads/ATNHPIUS06087A.csv'

# Rename the column ATNHPIUS06087A to HPI
data_hpi <- data_hpi %>%
  rename(HPI = ATNHPIUS06087A)

# Convert the DATE column to Date type
data_hpi$DATE <- as.Date(data_hpi$DATE, format = "%Y-%m-%d")

# Filter the data for the years 2007-2017
data_hpi_filtered <- data_hpi %>%
  filter(DATE >= as.Date("2007-01-01") & DATE <= as.Date("2017-01-01"))

# Extract the year from the DATE column
data_hpi_filtered$Year <- as.integer(format(data_hpi_filtered$DATE, "%Y"))
data_hpi_filtered <- data_hpi_filtered %>% select(Year, HPI)

# Read the homelessness data from the CSV file
data_homeless <- read.csv('C:/Users/Lola/Downloads/ATNHPIUS06087A.csv')

# Filter the data for Santa Cruz county in California
santa_cruz_data <- data_homeless %>%
  filter(county == "Santa Cruz" & state_name == "California")

# Select the columns for homeless counts from 2007 to 2017
total_data <- santa_cruz_data %>%
  select(starts_with("Total.Homeless..")) %>%
  pivot_longer(cols = everything(), names_to = "Year", values_to = "Count") %>%
  mutate(Year = as.integer(sub(".*\\.\\.(\\d{4})", "\\1", Year))) # Extract the year from the column names
                              #"\\.*\\.\\.(\\d+)", "\\1"

# Combine the data
combined_data <- merge(data_hpi_filtered, total_data, by = "Year", all.x = TRUE)

# Verify the structure of combined_data
str(combined_data)


annotation <- data.frame(
  x = 2014, y = 3529, 
  label = "In 2014, \n the Departnment of HUD \n changed their\n data collection \n standards"
)
# Create the ggplot
ggplot(combined_data, aes(x = Year)) +
  # Plot the Count data
  geom_line(aes(y = Count, color = "Total Homelessness Count"), size = 1) +
  # Plot the HPI data, adjusted to the secondary axis scale
  geom_line(aes(y = HPI * (4000 / max(HPI)), color = "Home Price Index"), size = 1) +
  scale_y_continuous(
    name = "Total Homelessness Count",
    limits = c(1500, 4000),  # Set limits for Count
    sec.axis = sec_axis(~ . * (max(combined_data$HPI) / 3800), name = "Home Price Index")  # Secondary axis for HPI
  ) +
  labs(
    x = "Year",
    title = "Total Homelessness Count and Home Price Index in Santa Cruz County (2007-2017)",
    color = "Variable"
  ) +
  scale_color_manual(values = c("Total Homelessness Count" = "blue", "Home Price Index" = "red")) +
  geom_label_repel(data=annotation, aes( x=x, y=y, label=label, nudge_x = 2015, nudge_y = 4000),                 , 
            color="darkblue", 
            size=6 , angle=0, fontface="bold" ) +
  geom_point(aes(x=2014,y=3529),         
             color='darkblue',
             size=3) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    axis.title = element_text(size = 12),
    axis.text = element_text(size = 10),
    legend.title = element_text(size = 12),
    legend.text = element_text(size = 10),
    axis.title.y.right = element_text(color = "red"),
    axis.text.y.right = element_text(color = "red")
  ) + scale_x_continuous(breaks = c(2007, 2010, 2012, 2015, 2017), labels = c(2007, 2010, 2012, 2015, 2017))

