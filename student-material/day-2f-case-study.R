# Prerequisites ----------------------------------------------------------------

# load tidyverse
library(tidyverse)

# import data
transactions <- data.table::fread("data/transactions.csv", data.table = FALSE) %>% as_tibble()
products <- data.table::fread("data/products.csv", data.table = FALSE) %>% as_tibble()
households <- data.table::fread("data/households.csv", data.table = FALSE) %>% as_tibble()

# Exercises --------------------------------------------------------------------

# Exercise 1
transactions %>%
  distinct(hshd_num) %>%
  tally()

transactions %>%
  inner_join(households) %>%
  distinct(hshd_num) %>%
  tally()

# Exercise 2
transactions %>%
  group_by(hshd_num, week_num) %>%
  summarise(total_n_products = n_distinct(product_num)) %>%
  summarise(avg_n_products = mean(total_n_products)) %>%
  ggplot(aes(avg_n_products)) +
  geom_histogram(bins = 100)

transactions %>%
  group_by(hshd_num, week_num) %>%
  summarise(visit = n_distinct(basket_num)) %>%
  summarise(avg_n_visits = mean(visit)) %>%
  ggplot(aes(avg_n_visits)) +
  geom_histogram(bins = 100)

# Exercise 3
transactions %>%
  group_by(hshd_num, week_num) %>%
  summarize(total_spend = sum(spend)) %>%
  inner_join(households) %>%
  group_by(hh_size) %>%
  summarize(avg_spend = median(total_spend)) %>%
  ggplot(aes(hh_size, avg_spend)) +
  geom_col()

# Exercise 4
transactions %>%
  inner_join(products) %>%
  mutate(
    baby_stuff = commodity == "BABY",
    alcohol = commodity == "ALCOHOL"
  ) %>%
  group_by(basket_num) %>%
  summarise(
    basket_has_baby_stuff = max(baby_stuff),
    basket_has_alcohol = max(alcohol)
  ) %>%
  summarise(
    prop_both = sum((basket_has_baby_stuff * basket_has_alcohol) == 1) /
      sum(basket_has_baby_stuff == 1),
    prob_beer = mean(basket_has_alcohol),
    diaper_lift = prop_both / prob_beer
  )

# Exercise 5
transactions %>%
  inner_join(products) %>%
  inner_join(households) %>%
  group_by(brand_ty, income_range) %>%
  summarize(total_spend = sum(spend)) %>%
  mutate(
    income_range = fct_relevel(income_range, "UNDER 35K", "35-49K", "50-74K",
                               "75-99K", "100-150K", "150K+", "null"),
    income_range = fct_recode(income_range, Unknown = "null")
  ) %>%
  ggplot(aes(income_range, total_spend, fill = brand_ty)) +
  geom_col(position = "fill")

# Exercise 6
transactions %>%
  inner_join(products) %>%
  group_by(commodity, week_num) %>%
  summarize(spend = sum(spend)) %>%
  filter(
    !(commodity %in% c("HOLIDAY", "SEASONAL PRODUCTS", "OUTDOOR")),
    min(week_num) == 53 & max(week_num) == 104,
    week_num %in% c(53, 104)
  ) %>% 
  spread(week_num, spend) %>%
  mutate(growth = `104` / `53` - 1) %>%
  ggplot(aes(growth, fct_reorder(commodity, growth))) +
  geom_point()
