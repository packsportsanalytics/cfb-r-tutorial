# College Football SAC Tutorial
# Created by Billy Fryer
# Last Update 9/22/2022

### Load Packages
# install.packages("tidyverse")
library(tidyverse)
# install.packages("ggplot2")
library(ggplot2)
# install.packages("cfbfastR")
library(cfbfastR)
# cfbplotR isn't on CRAN so we need to get it from GitHub
# install.packages("devtools")
# devtools::install_github("Kazink36/cfbplotR")
library(cfbplotR)

## Question: Who are the biggest favorites/underdogs in the Power 5 this week?

### Step 0: Get API Key using instructions here: https://cfbfastr.sportsdataverse.org/

### Step 1: Get data for last week's odds

current_week <- 5

# Home Lines
home_lines <- cfbfastR::cfbd_betting_lines(year = 2022) %>% 
  # Get Current Week
  filter(week == current_week) %>% 
  # Bovada as the provider
  filter(provider == "Bovada") %>% 
  # Only variables needed
  select(team = home_team,
         conference = home_conference,
         line = home_moneyline)

# Away Lines
away_lines <- cfbfastR::cfbd_betting_lines(year = 2022) %>% 
  # Get Current Week
  filter(week == current_week) %>% 
  # Bovada as the provider
  filter(provider == "Bovada") %>% 
  # Only variables needed
  select(team = away_team,
         conference = away_conference,
         line = away_moneyline)


# Put these two data frames together on top of one another
all_lines <- bind_rows(away_lines, home_lines)

power5 <- c("Pac-12", "ACC", "SEC", "Big Ten", "Big 12")

# Filter lines down to power 5, BYU and Notre Dame
p5_lines <- all_lines %>% 
  filter(conference %in% power5 | team %in% c("Notre Dame", "BYU")) %>% 
  # Get rid of NAs
  filter(!is.na(line))




### Plotting Take 1
# ggplot(p5_lines, aes(x = team,
#                      y = line)) +
#   geom_col()

# Plotting Take 2
ggplot(p5_lines, aes(x = team,
                     y = line)) +
  geom_col(aes(color = team, 
               fill = team), width = 0.5) +
  scale_fill_cfb(alpha = .8) +
  scale_color_cfb(alt_colors = p5_lines$team) +
  theme_bw() +
  labs(title = "Power 5 Betting Odds for Week 2",
       subtitle = "Not all Power 5 Teams Availible",
       y = "Money Line",
       x = "",
       caption = "Created by Billy Fryer with cfbplotR ~ Data from cfbfastR") +
  theme(axis.text.x = element_cfb_logo(),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        plot.caption = element_text(hjust = 0.5),
        )

