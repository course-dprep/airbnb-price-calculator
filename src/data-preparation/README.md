# Data Preparation

### Table of Contents

#### 1. Downloading and merging the data
- 1.1 Filtering the Western EU countries
- 1.2 Changing characters in the download links
- 1.3 Merging process
#### 2. Data cleaning
- 2.1 Filter the variables used in the analysis
- 2.2 Remove inconvenient symbols from the data and correct the data types
- 2.3 Checking data for face validity and extreme outliers
- 2.4 Converting host variables into binary
- 2.5 Create a dummy variable for the property type
- 2.6 Check for missing values
#### 3. Wrap-up


# 1. Downloading and merging the data
## 1.1 Filtering the Western EU countries
The web scraper collected the data links of all the cities around the world. We downloaded that data into r and started filtering the Western EU countries:
  - Belgium
  - France
  - Germany
  - The Netherlands
  - Portugal 
  - Spain

These countries were saved into a seperate dataframe.


## 1.2 Changing characters in the download links
Some countries contain "strange" characters in their links, such as: "%C3%". R did not copy these links correctly, hence we had to create separate codes for these characters.  
```
listing_EU$Link=gsub('é', '%C3%A9', listing_EU$Link)
listing_EU$Link=gsub('í', '%C3%AD', listing_EU$Link)
listing_EU$Link=gsub('ä', '%C3%A4', listing_EU$Link)
listing_EU$Link=gsub('ü', '%C3%BC', listing_EU$Link)
```
## 1.3 merging process
Now that the links are all working, the following code was created that reads through the city links, downloads all data of the listings per city, and binds the data in one dataframe. 

```
airbnb_dfs <- Map(
    function(data_file, country, city) 
        read.csv(file.path("cities", data_file)) |> transform(country=country, city=city),
    EU_data_files,
    listing_EU$Country,
    listing_EU$City
)
```

The dataframe of the 23 cities had around 270,000 rows with observation, each representing a listing. At this stage, the dataframe consisted of the original 83 variables retrieved from Inside Airbnb and two additional columns representing the name of the country and the city. 

# 2. Data cleaning
## 2.1 Filter the variables used in the analysis
For the first step it was decided to only use variables usefull for the analysis. The variable list is available [here](https://github.com/course-dprep/team-assignment-team-4/blob/data_exploration/src/README.md). Therefore, we excluded unnecessary information such as: host information and overlapping variables. 
```
data_filtered <- df[c('id','country','city','host_response_rate','host_is_superhost', 'host_identity_verified','property_type','room_type','accommodates','bathrooms_text','bedrooms',
                      'beds', 'price','minimum_nights','maximum_nights','number_of_reviews','review_scores_rating','review_scores_accuracy',
                      'review_scores_cleanliness','review_scores_checkin','review_scores_communication','review_scores_location','review_scores_value',
                      'instant_bookable')]
```

## 2.2 Remove inconvenient symbols from the data and correct the data types
The "$" was removed from the 'price' variable. This way, we were able to transform the price to a numeric variable. Additionally, all text was removed from the 'bathrooms_text' variable and the "%" sign was removed from the 'host_response_rate' variable for the same reason. 

To ensure the data had the correct data type, we created a column list with the variables we wanted to convert to numeric. In order to convert the columns to numeric, a loop was created so that all variables were changed to the correct data type for the purpose of the analysis.

## 2.3 Checking data for face validity and extreme outliers
For this step, an extra column was created to check the prices per person for each city to look for face validity and extreme outliers. The prices of the cities seemed to be realistic, so this should not be a problem. 

## 2.4 Converting host variables into binary
The following relevant host and booking information is depicted as either "true" or "false" in the dataset:
- the identity of the host is publicly known 
- being a superhost 
- instant bookable

Therefore, these values were recoded to "1" for true and "0" for false. 

## 2.5 Create a dummy variable for the property type
To limit the number of total values in the property type column to take into account for the regression, the property types that appeared in less than 1% of all observations were changed to 'non-common property type' in the dataframe.

```
table_property_type <-as.data.frame(table(data_filtered$property_type))
table_cut_of<- table_property_type %>% filter(Freq >0.01*nrow(data_filtered))
data_filtered <- data_filtered %>% mutate(property_type=ifelse(property_type %in% table_cut_of$Var1, property_type, 'Non-common proporty type'))

```

## 2.6 Check for missing values
When checking the missing values, we found that the value of bedrooms was missing in 8.5% of the listigns. Since we argue that the amount of bedrooms is an important characteristic of an Airbnb listing, the missing values were dropped. Additionally, the missing values of bedrooms and beds (0.4% and 1.4% respectively) were dropped. 

Moreover, 20% of the listings had no reviews. this resulted in missing values for the following review-related variables: 
- review_scores_accuracy
- review_scores_checkin
- review_scores_cleanliness
- review_scores_rating
- review_scores_communication
- review_scores_location
- review_scores_value

Since reviews are a vital part of a decision making process online, we decided not to drop the missing values but to replace them with "0". By doing this we allow the absence of review scores to be a part of the estimation tot and capture the servicelevel fo the host. That is why it was decided to also remove the variable host response rate because of 23% of the listings had missing values. 

# 3. Wrap up
After cleaning the data, the following dataset remained: 
- name van de file: 241,367 observation with 24 variables. 

This dataset is used for the analysis and the creation of the estimation tool. 






