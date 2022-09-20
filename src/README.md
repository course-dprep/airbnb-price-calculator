# Collecting the Data

The data collection consists of ...............

For further preparation of the data we used variables which are relevant for our model, these variables are shown in the table below. 


|Variable                        |Description                                                                                     |
|--------------------------------|------------------------------------------------------------------------------------------------|
|id                              |Unique identifier of the listing                                                                |
|host_response_rate              |Rate at which a host responds                                                                   |
|host_is_superhost               |Whether host is superhost                                                                       |
|host_identity_verified          |Whether identity of host is known                                                               |
|property_type                   |Self described type of property                                                                 |
|room_type                       |All homes are grouped into three types: Entire place / Shared room / Private room               |
|accommodates                    |The maximum capacity of the listing                                                             |
|bathrooms_text                  |The Number of bathrooms in the listing                                                          |
|bedrooms                        |The number of bedrooms                                                                          |
|beds                            |The number of bed(s)                                                                            |
|amenities                       |Additional features of listing                                                                  |
|price                           |Daily price in local currency                                                                   |
|minimum_nights                  |Minimum number of nights a guest can stay                                                       |
|maximum_nights                  |Maximum number of nights a guest can stay                                                       |
|number_of_reviews               |The number of reviews the listing has                                                           |
|review_scores_rating            |General review score of the listing                                                             |
|review_scores_accuracy          |Review score for accuracy of the listing                                                        |
|review_scores_cleanliness       |Review score for cleanliness of the listing                                                     |
|review_scores_checkin           |Review score of the check-in at the listing                                                     |
|review_scores_communication     |Review score of the communication by host                                                       |
|review_scores_location          |Review score of the property location                                                           |
|review_scores_value             |Review score of value of the listing                                                            |
|reviews_per_month               |Amount of reviews a listing has per month                                                       |
|city                            |City that a listing is situated                                                                 |
|country                         |Country in which a listing is situated                                                          |

(Descriptions retrevied from: https://docs.google.com/spreadsheets/d/1iWCNJcSutYqpULSQHlNyGInUvHg2BoUGoNRIGa6Szc4/edit?usp=sharing)


To discuss:
Some interesting variables:
number_of_reviews_ltm
number_of_reviews_l30d
license
instant_bookable
availability_30
availability_60
availability_90
availability_365


Deleted:
|Variable                        |Description                                 |
|--------------------------------|--------------------------------------------|
|host_since                      |Date the host was created                   |
|host_response_time              |Time after which a host responds            |
|neighbourhood                   |Neighbourhood of the listing                |
|neighbourhood_cleansed          |Detailer neighbourhood of listing           |
