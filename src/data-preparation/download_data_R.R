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

## some cities give an error because of their spelling:

#Malaga 
listing_EU$Link[listing_EU$Link=='http://data.insideairbnb.com/spain/andalucía/malaga/2022-06-29/data/listings.csv.gz'] <- 'http://data.insideairbnb.com/spain/andaluc%C3%ADa/malaga/2022-06-29/data/listings.csv.gz'
#Pays Basque
listing_EU$Link[listing_EU$Link=='http://data.insideairbnb.com/france/pyrénées-atlantiques/pays-basque/2022-06-10/data/listings.csv.gz'] <- 'http://data.insideairbnb.com/france/pyr%C3%A9n%C3%A9es-atlantiques/pays-basque/2022-06-10/data/listings.csv.gz'
#Sevilla
listing_EU$Link[listing_EU$Link=='http://data.insideairbnb.com/spain/andalucía/sevilla/2022-06-27/data/listings.csv.gz'] <- 'http://data.insideairbnb.com/spain/andaluc%C3%ADa/sevilla/2022-06-27/data/listings.csv.gz'
#stockholm
listing_EU$Link[listing_EU$Link=='http://data.insideairbnb.com/sweden/stockholms-län/stockholm/2022-06-25/data/listings.csv.gz'] <- 'http://data.insideairbnb.com/sweden/stockholms-l%C3%A4n/stockholm/2022-06-25/data/listings.csv.gz'
#Trentino
listing_EU$Link[listing_EU$Link=='http://data.insideairbnb.com/italy/trentino-alto-adige-südtirol/trentino/2022-06-29/data/listings.csv.gz'] <- 'http://data.insideairbnb.com/italy/trentino-alto-adige-s%C3%BCdtirol/trentino/2022-06-29/data/listings.csv.gz'

# making a loop to download all the data links of the EU cities
for (i in 1:42) { 
    myurl <- paste(listing_EU[i,3], sep = "") #you need the exact column number so change 1 to that value and change df to your dataframe's name
    myfile <- paste0("C:/Users/casro/", listing_EU$City[i], ".csv") #~ your own wd
    download.file(url = myurl, destfile = myfile)
}

