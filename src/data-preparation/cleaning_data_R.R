library('dplyr')

# filtering for variables that are interesting for ou pricing tool
data_filtered <- df[c('id','host_response_rate','host_is_superhost', 'host_identity_verified','property_type','room_type','accommodates','bathrooms_text','bedrooms',
                      'beds','amenities','price','minimum_nights','maximum_nights','number_of_reviews','review_scores_rating','review_scores_accuracy',
                      'review_scores_cleanliness','review_scores_checkin','review_scores_communication','review_scores_location','review_scores_value',
                      'instant_bookable')]


# InsideAirbnb makes every valuta into $
data_filtered$price <- (gsub("\\$|,", "", data_filtered$price))
# Deleting percentage from repsonse rate
data_filtered$host_response_rate <- (gsub("%", "", data_filtered$host_response_rate))

# recode bathroom_text to numeric values, by dropping everything except numbers and dots
data_filtered$bathrooms_text <- (gsub("[^0-9.]", "", data_filtered$bathrooms_text))


# create a list of the columns we want to convert to numeric
column_list_numeric <- grep('bathrooms_text|price|host_response_rate|host_listings_count|accommodates|bedrooms|beds|minimum_nights|maximum_nights|number_of_reviews|review_scores_rating|review_scores_accuracy|review_scores_cleanliness|review_scores_checkin|review_scores_communication|review_scores_location|review_scores_value|reviews_per_month', colnames(data_filtered,), value=T)
#for loop where we unlist the list in order to convert them to numeric
for (column in column_list_numeric){
    data_filtered[,column] <- as.numeric(unlist(data_filtered[,column]))
}

# Price per person in new column 
data_filtered$price_per_person <- data_filtered$price/data_filtered$accommodates

# Converting host variables into binary 
data_filtered <- data_filtered %>% mutate(host_is_superhost=ifelse(host_is_superhost == "t", 1,
                                                                       ifelse(host_is_superhost == "f", 0, NA)))
data_filtered <- data_filtered %>% mutate(host_identity_verified=ifelse(host_identity_verified == "t", 1,
                                                                            ifelse(host_identity_verified == "f", 0, NA)))

# compute means per city to check the validity of prices
data_filtered %>% group_by(city) %>% summarize_at(vars(price_euros), list(name=mean), na.rm=TRUE) 

# delete observations with extreme low and high price outliers based on price per person
data_filtered <- data_filtered %>% filter(price_per_person > 0 & price_per_person < 1500)

# check means again for face validity
data_filtered %>% group_by(city) %>% summarize_at(vars(price_euros), list(name=mean), na.rm=TRUE) 

# Checking for the % of NA
df_missing_values<-as.data.frame(sapply(data_filtered, function(x) sum(is.na(x))))
View(df_missing_values)

# Bedrooms NA ≈ 8,5% so for validity we can delete NA values
data_filtered <- data_filtered %>% drop_na(bedrooms)

# Bathrooms_txt NA < 1% so for validity we can delete NA values
data_filtered <- data_filtered %>% drop_na(bathrooms_text)

# Beds NA ≈ 1,4% so for validity we can delete NA values
data_filtered <- data_filtered %>% drop_na(beds)


