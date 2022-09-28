library('tidyverse')
library('dplyr')

Airbnb_listing_urls <- read.delim("Airbnb_listing_urls.csv", sep = ';', encoding='UTF-8')

#filter for all cities in EU
countries_in_EU <- c('Austria', 'Belgium', 'Bulgaria', 'Croatia', 'Republic of Cyprus', 'Czech Republic', 'Denmark', 
                 'Estonia', 'Finland', 'France', 'Germany', 'Greece', 'Hungary', 'Italy', 'Latvia', 'Lithuania', 
                 'Luxembourg', 'The Netherlands', 'Poland', 'Portugal', 'Romania', 'Slovakia', 'Slovenia', 'Spain', 'Sweden')

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

# Create a directory
dir.create('cities')

# Loop through the files in the directory
for (i in 1:42) { 
    myurl <- paste(listing_EU[i,3], sep = "") 
    myfile <- paste0("cities/", listing_EU$City[i], ".csv")
    download.file(url = myurl, destfile = myfile)
}

