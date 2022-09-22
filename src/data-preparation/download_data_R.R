# load these packages
library('tidyverse')
library('dplyr')
Airbnb_listing_urls <- read.delim("C:/Users/casro/Airbnb_listing_urls.csv", sep = ';') #~ your own wd

#filter for all cities in EU
countries_in_EU <- c('Austria', 'Belgium', 'Bulgaria', 'Croatia', 'Republic of Cyprus', 'Czech Republic', 'Denmark', 
                 'Estonia', 'Finland', 'France', 'Germany', 'Greece', 'Hungary', 'Italy', 'Latvia', 'Lithuania', 
                 'Luxembourg', 'The Netherlands', 'Poland', 'Portugal', 'Romania', 'Slovakia', 'Slovenia', 'Spain', 'Sweden')

#Delete white space of country
tmp <- sub('.', '', Airbnb_listing_urls$Country)

#Add the countries without the whitespace to df
Airbnb_listing_urls$Country <- tmp

#Filter for countries in EU
listing_EU <- Airbnb_listing_urls %>% filter(Country %in% countries_in_EU)

listing_EU[,3]

# making a loop to download all the data links of the EU cities
for (i in 1:42) { 
    myurl <- paste(listing_EU[i,3], sep = "") #you need the exact column number so change 1 to that value and change df to your dataframe's name
    myfile <- paste0("C:/Users/casro/", listing_EU$City[i], ".csv") #~ your own wd
    download.file(url = myurl, destfile = myfile)
}

