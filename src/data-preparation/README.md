# Data Preparation

### Table of Contents

#### 1. Downloading and merging the data
- 1.1 Filtering the Western EU countries
- 1.2 Changing characters in the download links
- 1.3 Create and loop through the directory
- 1.4 Merging process
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
Some countries contain "strange" characters in their links, such as: "%C3%". R did not copy these links correctly, hence we had to create separate codes for these. 
```
listing_EU$Link=gsub('é', '%C3%A9', listing_EU$Link)
listing_EU$Link=gsub('í', '%C3%AD', listing_EU$Link)
listing_EU$Link=gsub('ä', '%C3%A4', listing_EU$Link)
listing_EU$Link=gsub('ü', '%C3%BC', listing_EU$Link)
```

## 1.3 Create and loop through the directory
Now that the links are all working, we created a loop that goes through the city links and downloads all data of the listings per city. This data is stored in a file called 'cities/', containing listings of 23 cities. 

## 1.4 Merging process
The different datafiles of the 23 cities were merged into one dataframe consisting of around 270,000 rows with observation, each representing a listing. At this stage, the dataframe consisted of the original 83 variables retrieved from Inside Airbnb. 

# 2. Data cleaning
## 2.1 Filter the variables used in the analysis
For the first step it was decided to only use variables usefull for the analysis. The variable list is available [here](https://github.com/course-dprep/team-assignment-team-4/tree/data_exploration/src). Therefore, we excluded unnecessary information such as: host information and overlapping variables. 
```
data_filtered <- df[c('id','host_response_rate','host_is_superhost', 'host_identity_verified','property_type','room_type','accommodates','bathrooms_text','bedrooms',
                      'beds','amenities','price','minimum_nights','maximum_nights','number_of_reviews','review_scores_rating','review_scores_accuracy',
                      'review_scores_cleanliness','review_scores_checkin','review_scores_communication','review_scores_location','review_scores_value',
                      'instant_bookable')]
```
## 2.2 Remove inconvenient symbols from the data and correct the data types
The "$" was removed from the 'price' variable. This way, we were able to transform the price to a numeric variable. Additionally, all text was removed from the 'bathrooms_text' variable and the "%" sign was removed from the 'host_response_rate' variable for the same reason. 

To ensure the data had the correct data type, we created a column list with the variables we wanted to convert to numeric. In order to convert the columns to numeric, we created a loop so that all variables were changed to the correct data type for the purpose of the analysis.

## 2.3 Checking data for face validity and extreme outliers

## 2.4 Converting host variables into binary
The relevant host information about whether the identity of the host is publicly known and about being a superhost is depicted in the dataset with the values: "true" and "false". These values were recoded to "1" for true and "0" for false. 

## 2.5 Create a dummy variable for the property type

## 2.6 Check for missing values
When checking the missing values, we found that the value of bedrooms was missing in 8.5% of the listigns. Since we argue that the amount of bedrooms is an important characteristic of an Airbnb listing and this is still a relatively small percentage, the missing values were dropped. additionally, the missing values of bedrooms and beds (0.4% and 1.4% respectively) were dropped. 

Moreover, the reviews score had a total of ...% missing values. Since reviews are a vital part of a decision making process online, we decided not to drop the missing values but to replace them with "0". By doing this we allow the absence of reviews (scores) to be a part of the estimation tool. 

```
code for the review scores. 
```
# 3. Wrap up
After cleaning the data, the following dataset remained: 
- ...

This dataset is used for the analysis and the creation of the estimation tool. 






