library('tidyverse')
library('dplyr')

# Loading the URLS
Airbnb_listing_urls <- read.delim("Airbnb_listing_urls.csv", sep = ';', encoding='UTF-8')


# filter for all countries in western EU
countries_in_EU <- c('Belgium', 'France', 'Germany', 'The Netherlands', 
                     'Portugal', 'Spain')

# Delete white space of country
tmp <- sub('.', '', Airbnb_listing_urls$Country)
# Add the countries without the whitespace to df
Airbnb_listing_urls$Country <- tmp
# Filter for countries in EU
listing_EU <- Airbnb_listing_urls %>% filter(Country %in% countries_in_EU)

# Change characters in order to prevent error while downloading data
listing_EU$Link=gsub('é', '%C3%A9', listing_EU$Link)
listing_EU$Link=gsub('í', '%C3%AD', listing_EU$Link)
listing_EU$Link=gsub('ä', '%C3%A4', listing_EU$Link)
listing_EU$Link=gsub('ü', '%C3%BC', listing_EU$Link)

# Create a directory for cities
dir.create('cities')

# Setting path to directory with correct file type 
EU_data_files <- list.files(path="cities", pattern=".csv")

# Subsetting for the specified countries
listing_EU <- Airbnb_listing_urls |> subset(Country %in% countries_in_EU)

# Loop through the csv files and assign columns city & country
airbnb_dfs <- Map(
    function(data_file, country, city) 
        read.csv(file.path("cities", data_file)) |> transform(country=country, city=city),
    EU_data_files,
    listing_EU$Country,
    listing_EU$City
)

# Bind the data together to one dataframe
df <- bind_rows(airbnb_dfs)



