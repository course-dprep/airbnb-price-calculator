library('dplyr')

# load the data 
df <- read.csv("listings_download.csv", fileEncoding = "UTF-8")

# filtering for variables that are interesting for ou pricing tool
data_filtered <- df[c('id','country','city','host_response_rate','host_is_superhost', 'host_identity_verified','property_type','room_type','accommodates','bathrooms_text','bedrooms',
                      'beds', 'price','minimum_nights','maximum_nights','number_of_reviews','review_scores_rating','review_scores_accuracy',
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

# Converting instant bookable into binary
data_filtered <- data_filtered %>% mutate(instant_bookable=ifelse(instant_bookable == "t", 1,
                                                                   ifelse(instant_bookable == "f", 0, NA)))

# Converting host variables into binary 
data_filtered <- data_filtered %>% mutate(host_is_superhost=ifelse(host_is_superhost == "t", 1,
                                                                       ifelse(host_is_superhost == "f", 0, NA)))
data_filtered <- data_filtered %>% mutate(host_identity_verified=ifelse(host_identity_verified == "t", 1,
                                                                            ifelse(host_identity_verified == "f", 0, NA)))

# Creating a dummy variable for property type, the types that occur less than 1% will be changed to 'non-common property type' for the final analysis
table_property_type <-as.data.frame(table(data_filtered$property_type))
table_cut_of<- table_property_type %>% filter(Freq >0.01*nrow(data_filtered))
data_filtered <- data_filtered %>% mutate(property_type=ifelse(property_type %in% table_cut_of$Var1, property_type, 'Non-common proporty type'))


# compute means per city to check the validity of prices
data_filtered %>% group_by(city) %>% summarize_at(vars(price), list(name=mean), na.rm=TRUE) 
data_filtered %>% group_by(city) %>% summarize_at(vars(price_per_person), list(name=mean), na.rm=TRUE) 

# delete observations with extreme low and high price outliers based on price per person
data_filtered <- data_filtered %>% filter(price_per_person > 0 & price_per_person < 1500)

# check means again for face validity
data_filtered %>% group_by(city) %>% summarize_at(vars(price), list(name=mean), na.rm=TRUE) 


# Checking for the % of NA
df_missing_values<-as.data.frame(sapply(data_filtered, function(x) sum(is.na(x))))
View(df_missing_values)

# Bedrooms NA ≈ 8,5% so for validity we can delete NA values
data_filtered <- data_filtered %>% drop_na(bedrooms)

# Bathrooms_txt NA < 1% so for validity we can delete NA values
data_filtered <- data_filtered %>% drop_na(bathrooms_text)

# Beds NA ≈ 1,4% so for validity we can delete NA values
data_filtered <- data_filtered %>% drop_na(beds)

# Approximately 20% of the listings have no reviews, since this is the only variable with which we can indicate customer satisfaction we have to include it.
# So we will put the review scores that have an NA value to zero 
data_filtered$review_scores_accuracy[is.na(data_filtered$review_scores_accuracy)] <- 0
data_filtered$review_scores_checkin[is.na(data_filtered$review_scores_checkin)] <- 0
data_filtered$review_scores_cleanliness[is.na(data_filtered$review_scores_cleanliness)] <- 0
data_filtered$review_scores_rating[is.na(data_filtered$review_scores_rating)] <- 0
data_filtered$review_scores_communication[is.na(data_filtered$review_scores_communication)] <- 0
data_filtered$review_scores_location[is.na(data_filtered$review_scores_location)] <- 0
data_filtered$review_scores_value[is.na(data_filtered$review_scores_value)] <- 0

# Approximately 23% of the host response rate has NA value, therefore we will exclude this variable for the analysis 
data_filtered <- subset(data_filtered, select = -host_response_rate)

# Save dataset
write.csv(data_filtered, file = "listings_final.csv", fileEncoding = "UTF-8",row.names=FALSE )

