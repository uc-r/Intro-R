
## ---Prerequisites---------------------------------------------------------
library(tidyverse)


## ---- Importing Your Turn 1 ----------------------------------------------

# 1. Import the households.csv file using readr::read_csv()
households <- read_csv("data/households.csv")

# 2. Import the transactions.csv file using data.table::fread()
transactions <- data.table::fread("data/transactions.csv", data.table = FALSE) %>%
  as_tibble()


## ---- Transforming Your Turn 1 -------------------------------------------
# How much total spend has household 4124 had throughout the available data?
transactions %>%
  filter(hshd_num == 4124) %>%
  summarise(sum_spend = sum(spend))

## ---- Transforming Your Turn 2 -------------------------------------------
# Which week did household 4124 spend the most?
transactions %>%
  filter(hshd_num == 4124) %>%
  group_by(week_num) %>%
  summarise(sum_spend = sum(spend)) %>%
  top_n(10, wt = sum_spend)

## ---- Transforming Your Turn 3 -------------------------------------------
# Compute the average spend per basket for each region.
transactions %>%
  group_by(store_r, basket_num) %>%
  summarise(avg_basket = mean(spend))


## ---- Transforming Your Turn 4 -------------------------------------------
# Can you find the date that has the largest spend-to-units ratio?
transactions %>%
  group_by(purchase_) %>%
  summarize(total_spend = sum(spend),
            total_units = sum(units)) %>%
  mutate(ratio = total_spend / total_units) %>%
  arrange(desc(ratio))


## ---- Visualization Your Turn 1 ------------------------------------------
# Plot the total spend by weeks
transactions %>%
  group_by(week_num) %>%
  summarise(total_spend = sum(spend)) %>%
  ggplot(aes(x = week_num, y = total_spend)) +
  geom_col()


## ---- Visualization Your Turn 2 ------------------------------------------
# Plot the total spend versus total units for every household. Facet by store 
# region to see if the pattern differs by region.
transactions %>%
  group_by(store_r, hshd_num) %>%
  summarise(total_spend = sum(spend),
            total_units = sum(units)) %>% 
  ggplot(aes(total_units, total_spend)) +
  geom_point(aes(color = store_r), show.legend = FALSE, alpha = .1) +
  facet_wrap(~ store_r) +
  geom_smooth()


## ---- Visualization Your Turn 3 ------------------------------------------
# Can you add a title and adjust the axes of the plot you created above?
transactions %>%
  group_by(store_r, hshd_num) %>%
  summarise(total_spend = sum(spend),
            total_units = sum(units)) %>% 
  ggplot(aes(total_units, total_spend)) +
  geom_point(aes(color = store_r), show.legend = FALSE, alpha = .1) +
  facet_wrap(~ store_r) +
  geom_smooth() +
  scale_x_continuous(name = "Total Units", labels = scales::comma) +
  scale_y_continuous(name = "Total Spend", labels = scales::dollar) +
  ggtitle("Household Spend vs Units")


# How can we overlay two separate data frames that contain the same
# information/scales
south <- transactions %>%
  filter(store_r == "SOUTH") %>%
  group_by(hshd_num) %>%
  summarize(spend = sum(spend),
            units = sum(units))

east <- transactions %>%
  filter(store_r == "EAST") %>%
  group_by(hshd_num) %>%
  summarize(spend = sum(spend),
            units = sum(units))

ggplot() +
  geom_point(data = east, aes(units, spend), color = "blue") +
  geom_smooth(data = east, aes(units, spend), color = "blue") +
  geom_point(data = south, aes(units, spend), color = "red") +
  geom_smooth(data = south, aes(units, spend), color = "red")
