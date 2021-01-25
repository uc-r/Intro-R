
## First Commands---------------------------------------------------------
# my commment
mtcars
?sum
hist(mtcars$mpg)
random_numbers <- runif(25)
history()

## Getting Help ----------------------------------------------------------

# provides details for specific function
help(sqrt)
?sqrt

# provides examples for said function
example(sqrt)


## Working Directory ------------------------------------------------------

# get your current working directory
getwd()

# set your working directory
setwd("put/your/own/file/path/here")

getwd()


## R as a Calculator -------------------------------------------------------

# uses PEMBDAS convention for order of operations
4 + 3 / 10 ^ 2
(4 + 3) / 10 ^ 2
(4 + 3 / 10) ^ 2

# calculations with NA produces NA
4 + 3 / 10 ^ NA 


## Assigning & evaluating --------------------------------------------------

x <- 4 + 3 / 10 ^ 2   # Good
x = 4 + 3 / 10 ^ 2    # Works but not idiomatic

# we can increment (build onto) existing objects
x
x <- x + 1
x

# evaluation is case sensitive
X


## YOUR TURN! ------------------------------------------------------------

# Compute the Economic Order Quantity Model shown on slide 20





## Workspace Environment --------------------------------------------------
# list all objects
ls()

# remove a single object
rm(D)

# remove all objects
rm(list = ls())


## Packages ---------------------------------------------------------------

# install packages from CRAN
install.packages("packagename") 

# load package to use in current R session
library(packagename)



## YOUR TURN! ------------------------------------------------------------

# 1. Download these packages from CRAN:
#    - tidyverse
#    - nycflights13

# 2. Load both packages to use in your current R session



