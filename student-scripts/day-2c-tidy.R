
## ----Package requirement--------------------------------------------------
library(tidyverse) # or directly w/library(tidyr)

## ----Example Data --------------------------------------------------------
load("data/tidy_data.RData")

## ----Your Turn Data ------------------------------------------------------
bomber_wide <- read_rds("data/bomber_wide.rds")
bomber_long <- read_rds("data/bomber_long.rds")
bomber_prefix <- read_rds("data/bomber_prefix.rds")
bomber_mess <- read_rds("data/bomber_mess.rds")


## ----Gather: wide to long ------------------------------------------------

# These all produce the same results:
cases %>% gather(Year, n, 2:4)
cases %>% gather(Year, n, `2011`:`2013`)
cases %>% gather(Year, n, `2011`, `2012`, `2013`)
cases %>% gather(Year, n, starts_with("20"))
cases %>% gather(Year, n, -country)


## ----Spread: long to wide ------------------------------------------------

# make long data
cases <- cases %>% gather(Year, n, -country)
cases %>% spread(key = Year, value = n)


## ----Gather & Spread Your Turn -------------------------------------------

# 1. Reshape the bomber_wide data from wide to long and name the new value 
#    column "Flying_Hrs"

# 2. Reshape the bomber_long data from long to wide using the "Output" variable 
#    for the new column names and the "Value" variable to fill in values



## ----Separate: one to multiple-------------------------------------------
storms %>% separate(col = date, into = c("year", "month", "day"), sep = "-")


## ----Unite: multiple to one ---------------------------------------------

# create data with variables to unite
multiple <- storms %>% separate(col = date, into = c("year", "month", "day"), sep = "-")

# unite multiple variables to one
multiple %>% unite(col = date, c("year", "month", "day"), sep = "-")



## ----Separate & Unite Your Turn -----------------------------------------

# Reshape the bomber_prefix data so that the "prefix" and "number" columns 
# are combined into a “MD” variable with “-“ separator



## ----The Big Mess Challenge --------------------------------------------

# Reshape the bomber_mess data to look like whats on the screen





