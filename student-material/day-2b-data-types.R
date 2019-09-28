
## ----load-pkgs-----------------------------------------------------------
library(tidyverse)
library(forcats)   # to work with factors
library(lubridate) # to work with dates
library(hms)       # to work with dates

## ----load-data-----------------------------------------------------------
# complete journey data
transactions <- completejourney::transactions
products <- completejourney::products

# imported data
households <- data.table::fread("data/households.csv", data.table = FALSE) %>% as_tibble()



## ----Logical Data Types -------------------------------------------------

# boolean values
typeof(TRUE)
typeof(FALSE)
typeof(c(TRUE, TRUE, FALSE))

# logical operations result in TRUE / FALSE
transactions %>%
  select(basket_id, coupon_disc) %>% 
  mutate(used_coupon = coupon_disc > 0) 

# logical comparison
x <- c(1, 2, 3, 4) < 4
x

# sum of elements that meet that condition
sum(x)

# proportion of elements that meet that condition
mean(x)


## ---- Your Turn Logicals---------------------------------------------------
# Using the completejourney::transactions data and the coupon_disc variable
#   1. How many transactions used a coupon?
#   2. What proportion of transactions used a coupon?




## ----Character Data Types -------------------------------------------------

# character string vector
x <- c("FROZEN MEAT", "FRZN MEAT/MEAT DINNERS", "MEAT - MISC", "CEREAL")

# force to lower case
str_to_lower(x)

# extract first 4 characters
str_sub(x, start = 1, end = 4)

# detect if "meat" is in each element
str_detect(x, pattern = "MEAT")

# replace first "MEAT" in each element with "NON-VEGGIE
str_replace(x, pattern = "MEAT", replacement = "NON-VEGGIE")

# replace all "MEAT" in each element with "NON-VEGGIE
str_replace_all(x, pattern = "MEAT", replacement = "NON-VEGGIE")

# filter for "MEAT" products
products %>% 
  select(product_id, product_category) %>%
  filter(str_detect(product_category, "MEAT")) #<<

# how many products are "MEAT" products
products %>%
  distinct(product_id, product_category) %>%
  mutate(meat_product = str_detect(product_category, "MEAT")) %>% #<<
  summarize(
    count = sum(meat_product, na.rm = TRUE),
    prop  = mean(meat_product, na.rm = TRUE)
  )

# replace "FRZN" with "FROZEN"
products %>%
  mutate(product_category = str_replace_all(product_category, pattern = "FRZN", replacement = "FROZEN")) %>% #<<
  filter(str_detect(product_category, "FROZEN")) %>%
  distinct(product_category)

# all products the start with "FROZEN", "FRZN", or end with the word "ICE"
products %>%
  filter(str_detect(product_category, regex("(^FROZEN|FRZN|//bICE$)"))) %>%
  distinct(product_category)

## ---- Your Turn Characters ---------------------------------------------------
# Using the completejourney::products data and product_category variable
#   1. How many products contain "SEAFOOD"
#   2. What is the proportion of products that contain "SEAFOOD"

# Hint:
## products %>%
##   distinct(product_category) %>%
##   mutate(seafood = _____) %>%
##   summarise(
##     count = _____,
##     prop  = _____
##     )



## ----Factor Data Types -------------------------------------------------

# example
eyes <- factor(x = c("blue", "green", "green"), levels = c("blue", "brown", "green"))
eyes

unclass(eyes)

# distinct marital status factor levels
households %>% distinct(marital)

# distinct income levels factor levels
households %>% distinct(income_range)

# plotting factors
ggplot(households, aes(marital)) +
  geom_bar()

ggplot(households, aes(income_range)) +
  geom_bar()

# relevel income range factor levels -------------------------------------------
households <- households %>% 
  mutate(income_range = fct_relevel(income_range, "UNDER 35K", "35-49K", "50-74K", "75-99K", "100-150K", "150K+", "null")) #<<

households %>% count(income_range)

ggplot(households, aes(income_range)) +
  geom_bar()

# recode-income range factor levels ----------------------------------------
households <- households %>%
  mutate(income_range = fct_recode(income_range, Unknown = "null")) #<<

households %>% count(income_range)

ggplot(households, aes(income_range)) +
  geom_bar()

# collapse marital status factor levels ------------------------------------
households <- households %>%
  mutate(
    marital = fct_collapse(marital, Unknown = c("null", "Unknown")), #<<
    marital = fct_relevel(marital, "Unknown", after = Inf)
    )

households %>% count(marital)

ggplot(households, aes(marital)) +
  geom_bar()


# change factor orders just for plotting purposes ---------------------------
households %>%
  mutate(homeowner = fct_collapse(homeowner, Unknown = c("Unknown", "null"))) %>%
  ggplot(aes(fct_infreq(homeowner))) + #<<
  geom_bar()

households %>%
  mutate(homeowner = fct_collapse(homeowner, Unknown = c("Unknown", "null"))) %>%
  ggplot(aes(fct_rev(homeowner))) + #<<
  geom_bar()


prod_count <- products %>% 
  count(department) %>%
  drop_na() %>%
  ggplot(aes(n, fct_reorder(department, n))) + #<<
  geom_point()



## ---- Your Turn Factors ---------------------------------------------------
# Using the households data
#   1. Recode the hh_size factor so that "null" is now "Unknown"
#   2. Relevel the hh_size factor so that "Unknown" is at the end
#   2. Use a bar chart to illustrate the distribution of hh_size in our data




## ----Date Data Types ---------------------------------------------------

# year, month, day
ymd("2018-12-02")

# year, month, day, hour
ymd_h("2018-12-02 01")

# year, month, day, timestamp
ymd_hms("2018-12-02 01:31:27")

# lubridate does not care about date formate
ymd("2018-12-02")
ymd("2018/12/02")
mdy("February 02, 2018")

# get year
year("2018-12-02 01:31:27")

# get quarter
quarter("2018-12-02 01:31:27")

# get month
month("2018-12-02 01:31:27", label = TRUE)

# get weekday
wday("2018-12-02 01:31:27", label = TRUE, abbr = FALSE)

# filter for weekends
transactions %>%
  filter(wday(transaction_timestamp) %in% 6:7) %>% #<<
  select(basket_id, transaction_timestamp)

# create a new weekday variable
transactions %>%
  mutate(weekday = wday(transaction_timestamp, label = TRUE)) %>% #<<
  select(basket_id, transaction_timestamp, weekday)


## ---- Your Turn Dates ---------------------------------------------------

# Using the completejourney::transactions data set
#   1. Make a bar chart showing the total number of transactions by weekday. 
#      Which weekday experiences the most traffic?
#
#   2. Make a line chart showing the total daily sales value (sum(sales_value)) 
#      for each day of the year (hint: use yday()). Is there any obvious trend 
#      in the daily total sales value?

