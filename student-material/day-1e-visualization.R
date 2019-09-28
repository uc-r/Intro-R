
## ---Package Requirements ------------------------------------------------
library(ggplot2) # or library(tidyverse)
library(dplyr)   # for other data wrangling tasks

## ---- Example Data ------------------------------------------------------
# built-in data set
mpg

## ---- Exercise Data -----------------------------------------------------
transactions <- data.table::fread("data/transactions.csv", data.table = FALSE) %>% 
  sample_frac(0.25) %>%
  as_tibble()
transactions


## ---- Canvas layer-------------------------------------------------------
ggplot(data = mpg)


## ---- Mapping variables to axes -----------------------------------------
ggplot(data = mpg, aes(x = displ, y = hwy))


## ---- Adding geometrics shapes to represent our data --------------------
ggplot(data = mpg, aes(x = hwy)) +
  geom_histogram()

ggplot(data = mpg, aes(x = hwy)) +
  geom_freqpoly()

ggplot(data = mpg, aes(x = hwy)) +
  geom_density()

ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point()

ggplot(data = mpg, aes(x = class, y = hwy)) +
  geom_boxplot()

ggplot(data = mpg, aes(x = class, y = hwy)) +
  geom_violin()



## ---- Your Turn 1 ---------------------------------------------------------
# Using the transactions data:
   # 1: Create a chart that illustrates the distribution of the spend variable.
   # 2: Create a chart that shows the counts for each store region
   # 3: Create a scatter plot of units vs spend



## ---- Non-mapping Aesthetics----------------------------------------------

# adding color, changing size, different shapes, 50% transparent
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(color = "blue", size = 2, shape = 17, alpha = .5)


# where we place the arguments will make it non-mapping or
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(color = "blue") 

# mapping
ggplot(data = mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point()


  
## ---- Your Turn 2 ---------------------------------------------------------

# 1: Create a scatter plot of units vs spend and color all points blue.
# 2: Create a scatter plot of units vs spend and color all points based on store region.
  
  
  

## ---- Creating Small Multiiples with Facetting ----------------------------

# facet_wrap
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  facet_wrap(~ class, nrow = 2) 

# facet_grid
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  facet_grid(drv ~ cyl) 


## ---- Your Turn 3 ---------------------------------------------------------
# Compute total spend by store region and week. Plot the week vs total spend 
# and use facetting to compare store regions.



## ---- Titles --------------------------------------------------------------
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_jitter() +
  ggtitle("Displacement vs Highway MPG", 
          subtitle = "Data from 1999 & 2008") 

ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_jitter() +
  labs( 
    title = "Displacement vs Highway MPG", 
    subtitle = "Data from 1999 & 2008", 
    caption = "http://fueleconomy.gov" 
    ) 

## ---- Adjusting Axes-------------------------------------------------------
ggplot(data = txhousing, aes(x = volume, y = median)) + 
  geom_point(alpha = .25) +
  scale_x_log10() 

ggplot(data = txhousing, aes(x = volume, y = median)) + 
  geom_point(alpha = .25)  +
  scale_y_continuous(name = "Median Sales Price", labels = scales::dollar) + #<<
  scale_x_log10(name = "Total Sales Volume", labels = scales::comma) #<<

## ---- Titles & Axes-------------------------------------------------------
ggplot(data = txhousing, aes(x = volume, y = median)) + 
  geom_point(alpha = .15) +
  scale_y_continuous(name = "Median Sales Price", labels = scales::dollar) +
  scale_x_log10(name = "Total Sales Volume", labels = scales::comma) +
  labs(
    title = "Texas Housing Sales",
    subtitle = "Sales data from 2000-2010 provided by the TAMU real estate center",
    caption = " http://recenter.tamu.edu/"
    )


## ---- Your Turn 4---------------------------------------------------------
# Complete this code to plot the relationship between total basket spend and 
# units. See if you can adjust the x and y axis titles and also add a main title.
transactions %>%
    group_by(basket_num) %>%
    summarize(
        spend = sum(spend, na.rm = TRUE),
        units = sum(units, na.rm = TRUE)
    ) %>%
  ggplot(aes(x = units, y = spend)) +
  geom_point() +
  scale_x_log10(______) +
  scale_y_log10(______) +
  ggtitle(______)



## ---- Overplotting -------------------------------------------------------
ggplot(data = txhousing, aes(x = volume, y = median)) + 
  geom_point(alpha = .1)  +
  scale_x_log10() +
  geom_smooth() 

ggplot(data = txhousing, aes(x = volume, y = median)) + 
  geom_point(alpha = .1)  +
  scale_x_log10() +
  geom_smooth(method = "lm")

ggplot(data = txhousing, aes(x = volume, y = median)) + 
  geom_point(alpha = .1)  +
  scale_x_log10() +
  geom_smooth(method = "lm") + 
  facet_wrap(~ month) 


## ---- Global attributes--------------------------------------------------
ggplot(data = mpg, aes(x = displ, y = hwy, color = drv)) + #<<
  geom_point() + 
  geom_smooth()

## ---- Local attributes---------------------------------------------------
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() + 
  geom_smooth(mapping = aes(color = drv)) #<<




