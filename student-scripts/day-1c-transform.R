
## ----package-prereq------------------------------------------------------
library(dplyr) # or library(tidyverse)

## ----data-prereq---------------------------------------------------------
transactions <- data.table::fread("data/transactions.csv", data.table = FALSE) %>% as_tibble()
transactions

## ----filter-obs----------------------------------------------------------

# filter for all observations in month 1 (January)
filter(transactions, hshd_num == "3708") #<<

# filter for all observations on January 1st
filter(transactions, hshd_num == "3708", spend > 3) #<<

# filter for all observations on January 1st with a departure delay
filter(transactions, hshd_num == "3708", spend > 3, product_num != 85383) #<<

## ----save-filter-output--------------------------------------------------
hshd_3708 <- filter(transactions, hshd_num == "3708")
hshd_3708

## ---- what will these produce? ------------------------------------------
filter(transactions, week_num == 12)
filter(transactions, week_num != 12)
filter(transactions, week_num %in% c(1, 5, 10))
filter(transactions, spend <= 5)
filter(transactions, !(spend <= 5))
filter(transactions, is.na(spend))


## ---- what will these produce? ------------------------------------------
# set 1
filter(transactions, week == 1, store_r == "SOUTH")
filter(transactions, week == 1 & store_r == "SOUTH")

# set 2
filter(transactions, store_r == "SOUTH" | store_r == "NORTH")
filter(transactions, store %in% c("SOUTH", "NORTH"))

# set 3 --> are these the same?
filter(transactions, !(week_num < 50 | spend > 2))
filter(transactions, week_num >= 50, spend <= 2)


## ----Filter-Your-Turn ---------------------------------------------------
# 1: import the data

# 2: filter for transactions with greater than 2 units

# 3: for transactions with greater than 2 units during week 101 that occurred in the south region.

# 4: for transactions with greater than 2 units during week 101 that occurred in the south or central regions.


## ----Select-Variables ---------------------------------------------------
select(transactions, product_num, spend, units, store_r, week_num)

# produces same as above
select(transactions, product_num:week_num)


## ----select-helpers------------------------------------------------------

# starts with example
select(transactions, ends_with("num"))

# ends with example
select(transactions, contains("_"))

# combining different select helpers
select(transactions, c(year, ends_with("num"), contains("_")))


## ----Select-Your-Turn ---------------------------------------------------
# 1. Import the __households.csv__ data

# 2. Select all columns that contain "_"

#3. Filter for those observations that fall in the "75-99K" income range



## ---Re-order Observations -----------------------------------------------

# ascending order
arrange(transactions, spend)

# descending order
arrange(transactions, desc(spend))

## ------------------------------------------------------------------------
(df <- tibble(x = c(5, 2, 5, NA)))



## ----Arrange-Your-Turn ----------E---------------------------------------
# 1: arrange transactions by week_num in ascending order

# 2: arrange transactions by week_num in ascending order and spend in descending order

# 3: What happens when you arrange an alphabetical variable such as store_r?


## ----Summary-Aggregations ------------------------------------------------

# compute mean spend
summarize(transactions, avg_spend = mean(spend, na.rm = TRUE))

# compute multiple summary stats
summarize(transactions, 
  spend_avg = mean(spend, na.rm = TRUE),
  spend_sd  = sd(spend, na.rm = TRUE),
  n = n()
)

## -----Group Data ---------------------------------------------------------

# group data by week
by_week <- group_by(transactions, week_num)

# compute summary stat
summarize(by_week, spend_avg = mean(spend, na.rm = TRUE))

# group data by store region
by_region <- group_by(transactions, store_r)

# compute summary stat
summarize(by_region, delay_sd = sd(spend, na.rm = TRUE))

## ----Summarize-Your-Turn ------------------------------------------------
# 1: Compute the average `spend` by `hshd_num` and arrange in descending order to find the household with the largest average spend.

# 2: Find the `product_num`s with the largest median spend.



## ---- Pipe Operator -------------------------------------------------------

# traditional approach
prod_group <- group_by(transactions, product_num)
prod_spend <- summarize(prod_group, spend_median = median(spend, na.rm = TRUE))
arrange(prod_spend, desc(spend_median))

# pipe operator (%>%) approach
transactions %>%
  group_by(product_num) %>%
  summarize(spend_median = median(spend, na.rm = TRUE)) %>%
  arrange(desc(spend_median))


## ---- Pipe Operator Your Turn -----------------------------------------------
# Using the pipe operator follow these steps with the transactions data:
#   1. filter for southern region stores only
#   2. group by product
#   3. compute the average spend
#   4. sort this output to find the product with the largest average spend



## ------Mutate-Variables----------------------------------------------------

# create new price_per_unit variable
mutate(transactions, price_per_unit = spend / units) %>%
  select(spend, units, price_per_unit, everything())

# create mutliple variables
transactions %>%
  group_by(week_num) %>%
  summarize(
    spend = sum(spend, na.rm = TRUE),
    units = sum(units, na.rm = TRUE)
  ) %>% 
  mutate( 
    avg_spend_per_unit = spend / units, 
    wow_perc_growth    = (avg_spend_per_unit / lag(avg_spend_per_unit)) - 1, 
    wtd_net_spend      = cumsum(spend), 
    wtd_net_units      = cumsum(units) 
  ) 

# mean center data
transmute(transactions, center_spend = spend / mean(spend, na.rm = TRUE))

# transform values
transmute(transactions,
  log_spend = log(spend),
  exp_spend = exp(spend))

# lag and cumsum values
transmute(transactions,
  spend     = spend,
  lag_spend = lag(spend),
  sum_spend = cumsum(spend))

## ---- Mutate-Your-Turn ------------------------------------------------------
# Using what you've learned thus far, can you find the store region and week that 
# experienced the greatest week over week growth in the number of units sold?

# Hint:
## transactions %>%
##   group_by(______, ______) %>%
##   summarize(______) %>%
##   mutate(______) %>%
##   arrange(______)



