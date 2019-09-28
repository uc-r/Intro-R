

## ----Atomic-Vectors---------------------------------------------------

letters
1:12
sample(c(TRUE, FALSE), 10, replace = TRUE)

# Coercion --------------------------------------------------------
# Non-characters become characters
c("a", "b", 1:2)

# Logicals become numerics
c(1:2, TRUE)

# Factors are funky
c(factor("a"), 1)
c(factor("a"), "b")


## ----Vector-Application--------------------------------------------------

library(tidyverse)

# for filtering
filter(warpbreaks, tension %in% c("L", "H")) %>% as_tibble()

# for naming
names(warpbreaks) <- c("Variable1", "Variable2", "Variable3")

## ----Vector-Indexing-----------------------------------------------------

# some vector
v <- letters[1:10]
v

# index by element number
v[1]
v[c(1, 5, 10)]
v[-c(1, 5, 10)]

# if the vector is named we can index by name
names(v) <- LETTERS[1:10]
v

v[c("A", "A", "B")]


## ----Matrices------------------------------------------------------

# numeric matrix
set.seed(123)
v1 <- sample(1:10, 25, replace = TRUE)
m1 <- matrix(v1, nrow = 5)
m1

# character matrix
m2 <- matrix(letters[1:9], nrow = 3)
m2

# correlation matrix
cor(mtcars)[, 1:5]

# matrix multiplication
m3 <- matrix(1:6, nrow = 2)
m4 <- matrix(6:11, ncol = 2)
m3 %*% m4

## ----Matrix-Indexing----------------------------------------------------
m5 <- matrix(1:15, nrow = 3)

# first element, third colum
m5[1, 3]

# first three elements of all columns
m5[1:2, ]

# Using names to access rows and columns
colnames(m5) <- letters[1:5]
rownames(m5) <- LETTERS[1:3]
m5[c("A", "C"), c("b", "d")]



## ----Arrays-------------------------------------------------------

# depth = 2
array(1:25, c(3, 5, 2))

# depth = 1 (same as a matrix)
array(1:15, c(3, 5, 1))

## ---array indexing-----------------------------------------------------
a1 <- array(1:25, c(3, 5, 2))

# rows 1 & 2, columns 2-4 of the second matrix
a1[1:2, 2:4, 2]

# first row and all columns of both matrices (converts result into a single matrix)
a1[1, , ]



## ---Data Frames ----------------------------------------------------------
completejourney::transactions

## ---data frame indexing --------------------------------------------------
# first 10 rows for 3 columns
mpg[1:10, c("manufacturer", "model", "cty")]

# preserve output as data frame
mpg["cty"]

# simplify output as a vector
mpg[["cty"]]

# simplify output as a vector
mpg$cty



## ----Lists --------------------------------------------------------------
l1 <- list(item1 = v1, item2 = m1, item3 = mpg)
l1

## ----list indexing--------------------------------------------------------
# preserve output as a list
a <- l1["item1"]
is.list(a)
is.atomic(a)
a

# simplify output as a vector
b <- l1[["item1"]]
is.list(b)
is.atomic(b)
b

# simplify output as a vector
c <- l1$item1
is.list(c)
is.atomic(c)
c


# a linear model
model <- lm(mpg ~ ., data = mtcars)

# results are in a list
str(model)

# get the first ten residuals
model[["residuals"]][1:10]

# get the coefficient for the wt variable
model$coefficients["wt"]



