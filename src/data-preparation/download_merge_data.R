# Load libraries
library(tidyverse)
library(dplyr)
library(readxl)
library(googledrive)

# Deactivate the authorization for Google drive
drive_deauth()

# Loading the URLS from Google drive
data_id <-"https://docs.google.com/spreadsheets/d/16pAErs8l2_aAOdhUtmBoY1PIgiPDiQfU/edit?usp=sharing&ouid=117401560079139801880&rtpof=true&sd=true"
drive_download(as_id(data_id), path = "Airbnb_listing_urls.xlsx", overwrite = TRUE)
Airbnb_listing_urls <- read_excel("Airbnb_listing_urls.xlsx")

# Filter for all countries in western EU
countries_in_EU <- c('Belgium', 'France', 'Germany', 'The Netherlands', 'Portugal', 'Spain')

# Filter for countries in EU
listing_EU <- Airbnb_listing_urls %>% filter(Country %in% countries_in_EU)

# Create a directory for cities
dir.create('../../data/cities')

# Subsetting for the specified countries
listing_EU <- Airbnb_listing_urls |> subset(Country %in% countries_in_EU)

# Change characters in order to prevent error while downloading data
listing_EU$Link=gsub('√≠', '%C3%AD', listing_EU$Link)
listing_EU$Link=gsub('√©', '%C3%A9', listing_EU$Link)

# Download the files
for (i in 1:23) { 
  myurl <- paste(listing_EU[i,3], sep = "") 
  myfile <- paste0("../../data/cities/", listing_EU$City[i], ".csv")
  download.file(url = myurl, destfile = myfile)
}

# Setting path to directory with correct file type 
EU_data_files <- list.files(path="../../data/cities", pattern=".csv")

# Read through the csv files and assign columns city & country
airbnb_dfs <- Map(
  function(data_file, country, city) 
    read.csv(file.path("../../data/cities", data_file)) |> transform(country=country, city=city),
  EU_data_files,
  listing_EU$Country,
  listing_EU$City
  )

# Bind the data together to one dataframe
df <- bind_rows(airbnb_dfs)

# Save the data in a CSV file
write.csv(df, file = "../../data/listings_download.csv", fileEncoding = "UTF-8",row.names=FALSE )



