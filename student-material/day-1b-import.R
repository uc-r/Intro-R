
## ----Import-CSV----------------------------------------------------------

# load readr library (or tidyverse)
library(readr)

# import data
products <- read_csv(file = "data/products.csv")
products

## ----Import-Excel--------------------------------------------------------

# load readxl library 
library(readxl)

# read workbook sheets
excel_sheets(path = "data/products.xlsx")

# import sheet of interest
products <- read_excel(path = "data/products.xlsx", sheet = "products data")
products


## ---- YOUR TURN! ---------------------------------------------------------

# Read in the transactions.csv file and save as transactions




## ---Data frame vs tibble --------------------------------------------------

# results in a data frame
transactions <- data.table::fread("data/transactions.csv", data.table = FALSE)
transactions

# results in a tibble
transactions <- read_csv("data/transactions.csv")
transactions


# convert data frame to a tibble
transactions <- data.table::fread("data/transactions.csv", data.table = FALSE)
transactions <- tibble::as_tibble(transactions)
transactions


## ----Alternative importing ---------------------------------------------

# interactive file selection
read_csv(file.choose())


## ----Get to know your data --------------------------------------------

# dimensions (rows x columns)
dim(transactions)

# get a quick glimpse of the data
str(transactions)  # or use
dplyr::glimpse(transactions)

# get the names of all the variables
names(transactions)

# how many missing values exist
sum(is.na(transactions))

# omit all observations with missing values
clean_data <- na.omit(transactions)

# view the data in a spreadsheet like viewer
View(transactions)

