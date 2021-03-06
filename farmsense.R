### Data cleaning of a farm data collection project
      # step 1: Load the packages
library(tidyverse)
library(readr)
library(stringr)
library(ggplot2)
library(gridExtra)
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

#Step 4: Identify special characters that needs reformating and do that for all of columns
str(unclean)
view(unclean)

unclean <- unclean %>% 
  mutate_all(~str_replace_all(.,"_", " ")) %>% 
  mutate_all(~str_replace_all(.,"-"," ")) %>% 
  mutate(size_of_farm_plot = gsub("unit ","",size_of_farm_plot)) %>% 
  mutate(size_of_farm_plot = gsub(" ", " X ", size_of_farm_plot)) %>% 
  mutate(uuid = gsub(" ","-",uuid))


## Step 5: Change the case of text attributes to Full title case

unclean <- unclean %>% 
  mutate(lganame = str_to_title(lganame)) %>% 
  mutate(wardname = str_to_title(wardname)) %>% 
  mutate(sex = str_to_title(sex)) %>% 
  mutate(farm_type = str_to_title(farm_type)) %>% 
  mutate(crop_type = str_to_title(crop_type)) %>% 
  mutate(mode_of_acquisition = str_to_title(mode_of_acquisition)) %>% 
  mutate(farm_cooperative = str_to_title(farm_cooperative)) %>% 
  mutate(means_of_buying_and_selling = str_to_title(means_of_buying_and_selling)) %>% 
  mutate(access_to_internet = str_to_title(access_to_internet)) %>% 
  mutate(access_to_storage = str_to_title(access_to_storage)) %>% 
  mutate(access_to_water = str_to_title(access_to_water)) %>% 
  mutate(market_produce_sold_at = str_to_title(market_produce_sold_at)) %>% 
  mutate(data_collector = str_to_title(data_collector)) %>% 
  mutate(living_standard = str_to_title(living_standard)) %>% 
  mutate(yield_price = str_to_title(yield_price)) %>% 
  mutate(need_help_marketing_product = str_to_title(need_help_marketing_product)) %>% 
  mutate(farm_seed = str_to_title(farm_seed)) %>% 
  mutate(farm_seedling = str_to_title(farm_seedling)) %>% 
  mutate(farm_category = str_to_title(farm_category)) %>% 
  mutate(fertilizer_practice = str_to_title(fertilizer_practice)) %>% 
  mutate(`fertilizer_yes/fertilizer-type` = str_to_title(`fertilizer_yes/fertilizer-type`)) %>% 
  mutate(farm_sense = str_to_title(farm_sense)) %>% 
  mutate(farm_produce_sold_at = str_to_title(farm_produce_sold_at))

## Step 6: Checks for anomally -  There is no statename
unclean <- unclean %>% 
  mutate(statecode = statename) %>% 
  mutate(statename = ifelse(statename == "ON", "Ondo", statename))

##Converting the dataset from character to the appropriate data type 
unclean$age <- as.numeric(unclean$age)

## Creating categorical variables of the age, thereby creaing an age group.

clean <- unclean %>% 
  mutate(age_range = ifelse(18 <= age & age <= 28, "18 - 28", age)) %>% 
  mutate(age_range = ifelse(29 <= age & age <= 38, "29 - 38", age_range)) %>% 
  mutate(age_range = ifelse(39 <= age & age <= 48, "39 - 48", age_range)) %>% 
  mutate(age_range = ifelse(49 <= age & age <= 58, "49 - 58", age_range)) %>% 
  mutate(age_range = ifelse(59 <= age & age <= 69, "49 - 69", age_range)) %>%
  glimpse()


##TO find NA's
nrow(unclean[!complete.cases(unclean),])

##Access to storage, has no value
t(!is.na(farmsense$access_to_storage))

View(farmsense[85,])
farmsense[!complete.cases(farmsense),]
farmsense[is.na(farmsense$access_to_storage), "access_to_storage"] <- "No" 

## Use fertilzers, has NA's value
t(!is.na(farmsense$fertilizer_practice))
farmsense[is.na(farmsense$fertilizer_practice), "fertilizer_practice"] <- "No"
View(farmsense[c(60,77,85),])

## Converting the data into the right data types
str(farmsense)


#Renaming the dataset
farmsense <- clean

colnames(farmsense)

farmsense$age_range <- as.factor(farmsense$age_range)
farmsense$data_collector <- as.factor(farmsense$data_collector)
farmsense$farm_sense <- as.factor(farmsense$farm_sense)
farmsense$living_standard <- as.factor(farmsense$living_standard)
farmsense$yield_price <- as.factor(farmsense$yield_price)
farmsense$need_help_marketing_product <- as.factor(farmsense$need_help_marketing_product)
farmsense$market_produce_sold_at <- as.factor(farmsense$market_produce_sold_at)
farmsense$farm_produce_sold_at <- as.factor(farmsense$farm_produce_sold_at)
farmsense$access_to_internet <- as.factor(farmsense$access_to_internet)
farmsense$access_to_storage <- as.factor(farmsense$access_to_storage)
farmsense$access_to_water <- as.factor(farmsense$access_to_water)
farmsense$lganame <- as.factor(farmsense$lganame)
farmsense$wardname <- as.factor(farmsense$wardname)
farmsense$sex <- as.factor(farmsense$sex)
farmsense$farm_type <- as.factor(farmsense$farm_type)
farmsense$crop_type <- as.factor(farmsense$crop_type)
farmsense$mode_of_acquisition <- as.factor(farmsense$mode_of_acquisition)
farmsense$farm_category <- as.factor(farmsense$farm_category)
farmsense$fertilizer_practice <- as.factor(farmsense$fertilizer_practice)
farmsense$farm_seedling <- as.factor(farmsense$farm_seedling)
farmsense$farm_seed <- as.factor(farmsense$farm_seed)
farmsense$farming_experience <- as.numeric(farmsense$farming_experience)




##Descriptive statistics

ggplot(farmsense, aes(age_range))+
  geom_bar(fill = "dark green")

## Uisng data explorer to pictographically explore the data types
library(DataExplorer)
plot_str(farmsense)

## Exploratory analysis and Descriptive statistics

## Bar plots of some categorical variables
attach(farmsense)
p4 <- ggplot(farmsense, aes(x = sex)) + 
  ggtitle("Gender Distribution") +
  xlab("Gender") +
  geom_bar(aes(y = (..count..)), width = 0.5, fill = "dark green") +
  geom_text(stat = "count", aes(label = ..count.., y = ..count..)) +
  ylab("Farmers") +
  coord_flip() +
  theme_minimal()

##Member of a cooperative
p3 <- ggplot(farmsense, aes(x = farm_cooperative)) +
  ggtitle("Member of Farmers Cooperative") + 
  xlab("Gender") +
  geom_bar(aes(y = (..count..)), width = 0.5, fill = "dark green") +
  geom_text(stat = "count", aes(label = ..count.., y = ..count..)) +
  ylab("Farmers") + 
  coord_flip() + 
  theme_minimal()

p2 <- ggplot(farmsense, aes(x = access_to_internet)) + 
  ggtitle("Access to Smart Phone") + 
  xlab("Smartphone") + 
  geom_bar(aes(y = (..count..)), width = 0.5, fill = "dark green") + 
  geom_text(stat = "count", aes(label = ..count.., y = ..count..)) +
  ylab("Farmers") + 
  coord_flip() +
  theme_minimal()

## Access to Water
p1 <- ggplot(farmsense, aes(x = access_to_water)) + 
  ggtitle("Access to Water") +
  xlab("Access to Water") +
  geom_bar(aes(y = (..count..)), width = 0.5, fill = "dark green") +
  geom_text(stat = "count", aes(label = ..count.., y = ..count..)) +
  ylab("Farmers") + 
  coord_flip() +
  theme_minimal()

## Plot p1,p2,p3,p4 graph as one graph
grid.arrange(p1,p2,p3,p4, ncol = 2)

## Access to storage facilities
ggplot(farmsense, aes(x = access_to_storage)) +
  ggtitle("Access to Storage Facilities") +
  xlab("Storage Facilities") +
  geom_bar(aes(y = (..count..)), width = 0.5, fill = "dark green") +
  geom_text(stat = "count", aes(label = ..count.., y = ..count..)) +
  ylab("Farmers") +
  coord_flip() +
  theme_minimal()

## Statistical summary
summary(farmsense$farming_experience) ## There is an outlier with expereince of 77

Mode <- function(x){
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}
Mode(age)


 ## Use of fertilizers
p5 <- ggplot(farmsense, aes(x = fertilizer_practice)) +
  ggtitle("Use of fertilizer") + 
  xlab("Fertilizer") +
  geom_bar(aes(y = (..count..)), width = 0.5, fill = "dark green") +
  geom_text(stat = "count", aes(label = ..count.., y = ..count..)) +
  ylab("Farmers") + 
  coord_flip() + 
  theme_minimal()

p6 <- ggplot(farmsense, aes(x = `fertilizer_yes/fertilizer-type`)) + 
  ggtitle("Fertilizers Types") + 
  geom_bar(aes(y = (..count..)), width = 0.5, fill = "dark green") +
  geom_text(stat = "count", aes(label = ..count.., y = ..count..)) +
  ylab("Farmers") +
  coord_flip() + 
  theme_minimal()
grid.arrange(p5,p6, ncol = 2)

## Descriptive statistics for standard of living
p7 <- ggplot(farmsense, aes(x = living_standard)) +
  ggtitle("The farmers standard of living rely") +
  geom_bar(aes(y = (..count..)), width = 0.5, fill = "dark green") +
  geom_text(stat = "count", aes(label = ..count.., y = ..count..)) +
  ylab("Farmers") +
  coord_flip() + 
  theme_minimal()

## Not satisfied with price
p8 <- ggplot(farmsense, aes(x = yield_price)) +
  ggtitle("Not Satisfied With Price") + 
  geom_bar(aes(y = (..count..)), width = 0.5, fill = "dark green") +
  geom_text(stat = "count", aes(label = ..count.., y = ..count..)) +
  ylab("Farmers") +
  coord_flip() +
  theme_minimal()


## Crop types, farm category, mode of acquisition

p16 <- ggplot(farmsense, aes(x = farm_type)) + ggtitle("Type of Farming") +
  xlab("")+
  geom_bar(aes(y = (..count..)), width = 0.5, fill = "dark green") +
  ylab("Farmers") + coord_flip() + theme_minimal() + 
  geom_text(stat = "count", aes(label = ..count.., y = ..count..))

p17 <- ggplot(farmsense, aes(x = farm_category)) + ggtitle("Type of Cultivation") +
  xlab("") +
  geom_bar(aes(y = (..count..)), width = 0.5, fill = "dark green") +
  ylab("Farmers") + coord_flip() + theme_minimal() + 
  geom_text(stat = "count", aes(label = ..count.., y = ..count..))

p18 <- ggplot(farmsense, aes(x = mode_of_acquisition)) + ggtitle("Type of Ownership") +
  xlab("") + 
  geom_bar(aes(y = (..count..)), width = 0.5, fill = "dark green") +
  ylab("Farmers") + coord_flip() + theme_minimal() + 
  geom_text(stat = "count", aes(label = ..count.., y = ..count..))

p19 <- ggplot(farmsense, aes(x = crop_type)) + ggtitle("Type of Crop Grown") +
  xlab("") + 
  geom_bar(aes(y = (..count..)), width = 0.5, fill = "dark green") +
  ylab("Farmers") + coord_flip() + theme_minimal() + 
  geom_text(stat = "count", aes(label = ..count.., y = ..count..))


grid.arrange(p16, p17, p18, p19, ncol = 2)






































