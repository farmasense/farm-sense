### Data cleaning of a farm data collection project
      # step 1: Load the packages
library(tidyverse)
library(readr)
library(stringr)

      #step 2: Import the dataset in R
setwd("C:/Users/LENOVO/Documents/Data science project")
unclean <- read_csv("Data Analysis/farm-sense.csv")
glimpse(unclean) ## Sorting the data types and atttributes
t(colnames(unclean)) ##Assigning indexes to data values

#Step 3: Identify what column is useful to you and drop the ones that's not
unclean <- unclean %>% 
  select(5:11,24,25,28:55,57,60)








































