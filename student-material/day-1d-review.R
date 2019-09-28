
## ----Package requirements------------------------------------------------
library(dplyr) # or library(tidyverse)

## ----Data requirements --------------------------------------------------
transactions <- data.table::fread("data/transactions.csv", data.table = FALSE) %>% as_tibble()
transactions



## ---- Q1 ---------------------------------------------------------
# How much total spend did household 3937 have in week 54?



## ---- Q2 ---------------------------------------------------------
# Compute the total spend for baskets that household 3937 had in week 54.



## ---- Q3 ---------------------------------------------------------
# Compute the total units per basket for the central region. 
# Which basket contained the most units?



## ---- Q4 ---------------------------------------------------------
# In the east region, compute each household's spend-to-units ratio 
# for each week. Which household has the largest spend-to-units ratio?



## ---- Q5 ---------------------------------------------------------
# Compute total spend by basket for each purchase date. Can you find 
# the date that has the largest average (mean) total spend?

