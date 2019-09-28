
## ----Package Requirements ------------------------------------------------
library(tidyverse) # or library(dplyr)

## ----Example Data set-up -------------------------------------------------
x <- tribble(
  ~key, ~val_x,
     1, "x1",
     2, "x2",
     3, "x3"
)
y <- tribble(
  ~key, ~val_y,
     1, "y1",
     2, "y2",
     4, "y3"
)


## ----Exercises Data------------------------------------------------------
transactions <- data.table::fread("data/transactions.csv", data.table = F) %>% as_tibble()
products     <- data.table::fread("data/products.csv", data.table = F) %>% as_tibble()
households   <- data.table::fread("data/households.csv", data.table = F) %>% as_tibble()



## ----Mutating Joins ------------------------------------------------------

# inner join
x %>% inner_join(y, by = "key")

# left join
x %>% left_join(y, by = "key")

# right join
x %>% right_join(y, by = "key")

# full join
x %>% full_join(y, by = "key")


## ----Your Turn 1---------------------------------------------------------

# 1. Join the transactions and products data using inner_join()

# 2. Join the transactions, products, and households data using two inner_join()s



## ----Filtering Joins ------------------------------------------------------

# semi-join
x %>% semi_join(y, by = "key")

# anti-join
x %>% anti_join(y, by = "key")


## ----Your Turn 2---------------------------------------------------------

# 1. Of the 5000 households in our households data, how many do we transaction 
#    data for?
  
# 2. Of the 151,141 products in our products data, how many are not represented 
#    in our transactions data?




## ----Final Challenge -----------------------------------------------------

# Compute the total spend by commodity for household (hshd_num) 3708. 
# See if you can plot the results in rank order.










