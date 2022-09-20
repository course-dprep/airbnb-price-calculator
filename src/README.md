# Collecting the Data

The data collection consists of two files. The first file, inside_airbnb_link_scraper.py, is a program that is used to scrape the data download links of all cities that are listed on the website [Inside Airbnb](http://insideairbnb.com/get-the-data.html). The second file, data_download.R, is a program that downloads the datasets from the aforementioned data download links and merges the datasets together into one file. 

The datasets that were downloaded from Inside Airbnb contain 31 variables that were further used in the preparation and analysis of the data. The table below shows a description of these variables. 

|Variable                        |Description                                 |Relevance                                   |
|--------------------------------|--------------------------------------------|--------------------------------------------|
|id                              |Unique identifier of listing                |In order to distinguish the listing         |
|host_response_rate              |Rate at which a host responds               |Faster response 8|
|host_is_superhost               |Whether host is superhost                   ||
|host_identity_verified          |Whether identity of host is known           ||
|neighbourhood                   |Neighbourhood of the listing                ||
|neighbourhood_cleansed          |Detailer neighbourhood of listing           ||
|property_type                   |Self described type of property             ||
|room_type                       |Self described type of room                 ||
|accommodates                    |Maximum capacity of listing                 ||
|bathrooms_text                  |Number of bathrooms                         ||
|bedrooms                        |Number of bedrooms                          ||
|beds                            |Number of beds                              ||
|amenities                       |Additional specifications of listing        ||
|price                           |Daily price in local currency               ||
|minimum_nights                  |Minimum nights a guest can stay             ||
|maximum_nights                  |Maximum nights a guest can stay             ||
|number_of_reviews               |Total amount of reviews a listing has       ||
|review_scores_rating            |General review score of property            ||
|review_scores_accuracy          |Review score for accuracy of property       ||
|review_scores_cleanliness       |Review score for cleanliness of property    ||
|review_scores_checkin           |Review score of the check-in at property    ||
|review_scores_communication     |Review score of the communication by host   ||
|review_scores_location          |Review score of the property location       ||
|review_scores_value             |Review score of value of property           ||
|reviews_per_month               |Amount of reviews a listing has per month   ||
|city                            |City that a listing is situated             ||
|country                         |Country in which a listing is situated      ||


