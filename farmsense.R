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

## Renaming the column names
unclean <- unclean %>% 
  rename(statename = state, lganame = lgaa, wardname = wards, sex = `farmer-sex`,
         farm_type = `type-farming`, crop_type = `crops-grown`, latitude = `_farm_gps_latitude`,
         longitude = `_farm_gps_longitude`, mode_of_acquisition = owner_ship, farm_category = cultivation_practiced,
         size_of_farm_plot = `size-farm-plot`,farm_cooperative = cooperative_part, farming_experience = experience, 
         planting_date = start_date_of_planting, harvesting_date = end_date_of_planting, access_to_internet = `access-internet`,
         access_to_storage = `access-storage`, access_to_water = `access-water`, means_of_buying_and_selling = means_buy_sell,
         farm_produce_sold_at = `sell-produce`, market_produce_sold_at = market_sell_buy, need_help_marketing_product = `marketing-product`,
         yield_price = `yield-price`, living_standard = `standard-living`, uuid = `_uuid`,data_collector = `data-collector`, farm_sense = `farm-sense`)







































