# Load libraries
library(tidyverse)
library(dplyr)
library(readxl)
library(googledrive)

# Deactivate the authorization for Google drive
drive_deauth()

# Load the URLS from Google drive
data_id <-"https://docs.google.com/spreadsheets/d/16pAErs8l2_aAOdhUtmBoY1PIgiPDiQfU/edit?usp=sharing&ouid=117401560079139801880&rtpof=true&sd=true"
dir.create('../../data') # create directory for storing data file 
drive_download(as_id(data_id), path = "../../data/Airbnb_listing_urls.xlsx", overwrite = TRUE)
airbnb_listing_urls <- read_excel("../../data/Airbnb_listing_urls.xlsx")

# Filter for all countries in western EU
countries_in_eu <- c('Belgium', 'France', 'Germany', 'The Netherlands', 'Portugal', 'Spain')

# Filter for countries in EU
listing_eu <- airbnb_listing_urls %>% filter(Country %in% countries_in_eu)

# Create a directory for cities
dir.create('../../data/cities')

# Subset for the specified countries
listing_eu <- airbnb_listing_urls %>% subset(Country %in% countries_in_eu)

# Download the files
for (i in 1:nrow(listing_eu)) { # loop through all cities in listing_eu
  myurl <- paste(listing_eu[i,3], sep = "") 
  myfile <- paste0("../../data/cities/", listing_eu$City[i], ".csv") #  make csv for every city in listing_eu
  download.file(url = myurl, destfile = myfile)
}

# Set path to directory with correct file type 
eu_data_files <- list.files(path="../../data/cities", pattern=".csv")

# Read through the csv files and assign columns city & country
airbnb_dfs <- Map(
  function(data_file, country, city) 
    read.csv(file.path("../../data/cities", data_file)) %>% transform(country=country, city=city),
  eu_data_files,
  listing_eu$Country,
  listing_eu$City
  )

# Bind the data together to one dataframe
df <- bind_rows(airbnb_dfs)

# Create directories to save data
dir.create('../../gen')
dir.create('../../gen/data-preparation')
dir.create('../../gen/data-preparation/input')

# Save the data as a CSV file
write.csv(df, file = "../../gen/data-preparation/input/listings_download.csv", fileEncoding = "UTF-8",row.names=FALSE )



