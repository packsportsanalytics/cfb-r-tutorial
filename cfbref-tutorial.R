# College Football Reference SAC Tutorial
# Created by Billy Fryer
# Last Update 9/23/2022

# GOAL: Stacked Bar Chart of Recieving and Rushing Yards

# Step 0:  Where Data is From
# https://www.sports-reference.com/cfb/schools/north-carolina-state/2022.html

# Step 1: Library Packages
# install.packages("tidyverse")
library(tidyverse)
# install.packages("ggplot2")
library(ggplot2)

W# Step 2: Read in Data
data <- read_csv("https://raw.githubusercontent.com/packsportsanalytics/cfb-r-tutorial/main/test-data.csv")

plotting_data <- data %>%
  # We need the data in a long format to make the stacked bar chart
  pivot_longer(cols = rushing_att:scrimmage_td,
               names_to = "type",
               values_to = "value") %>% 
  # Select to get rid columns
  select(name, type, value) %>% 
  # Filter to get rid of rows
  filter(type == "rushing_yds" | type == "recieving_yds")


# Plotting!

# Plot 1
ggplot(plotting_data, aes(x = value,
                          y = name)) +
  geom_bar(stat = "identity")

# Plot 2
# Add Labels and center them

ggplot(plotting_data, aes(x = value,
                          y = name)) +
  geom_bar(stat = "identity") +
  labs(title = "Biggest Yard Gainers for NC State",
       subtitle = "Through Week 4 of 2022 Season",
       x = "Yards Gained",
       y = "",
       caption = "Data from CFB Reference ~ Graph by Billy Fryer") +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        legend.text = element_text(hjust = 0.5),
        plot.caption = element_text(hjust = 0.5))

# Plot 3
# Rearrange names and color plot

ggplot(plotting_data, aes(x = value,
                          y = reorder(name, value))) +
  geom_bar(aes(fill = type),
               stat = "identity") +
    labs(title = "Biggest Yard Gainers for NC State",
       subtitle = "Through Week 4 of 2022 Season",
       fill = "",
       x = "Yards Gained",
       y = "",
       caption = "Data from CFB Reference ~ Graph by Billy Fryer") +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        legend.text = element_text(hjust = 0.5),
        plot.caption = element_text(hjust = 0.5))

# Final Plot!
# Colors, pretty labels

plotting_data2 <- plotting_data %>% 
  # Mutate to add columns/change already existing columns
  mutate(pretty_type = case_when(type == "rushing_yds" ~ "Rushing",
                                 TRUE ~ "Recieving"))

ggplot(plotting_data2, aes(x = value,
                          y = reorder(name, value))) +
  geom_bar(aes(fill = pretty_type),
               stat = "identity") + 
  labs(title = "Biggest Yard Gainers for NC State",
       subtitle = "Through Week 4 of 2022 Season",
       fill = "",
       x = "Yards Gained",
       y = "",
       caption = "Data from CFB Reference ~ Graph by Billy Fryer") + 
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        legend.text = element_text(hjust = 0.5),
        plot.caption = element_text(hjust = 0.5)) +
  scale_fill_manual(values = c("Rushing" = "red",
                               "Recieving" = "black"))


