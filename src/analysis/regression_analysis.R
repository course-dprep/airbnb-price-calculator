# Packages
library(readr)
library(tidypredict)
library(broom)
library(dplyr)
library(ggplot2)
library(ggfortify)
library(yaml)

# Load 
listings_final <- read_csv("../../data/listings_final.csv")



# Check for normality of price (DV)
ggplot(listings_final, aes(price))+ geom_histogram(binwidth = 25)+ xlim(0, 4000) + ylim(0, 2000) 

# Since normality does not hold, we take the log of price
listings_final <- listings_final %>% mutate(log_price=log(price))
ggplot(listings_final, aes(log_price)) + geom_histogram(bins=60)



# Multiple linear regression with log_price and all the relevant variables
lm_listings <- lm(log_price ~ city + host_is_superhost + host_identity_verified + property_type + room_type + accommodates + bathrooms_text + bedrooms + beds + minimum_nights + maximum_nights + number_of_reviews + review_scores_rating + review_scores_accuracy + review_scores_cleanliness + review_scores_checkin + review_scores_communication + review_scores_location + review_scores_value + instant_bookable, data = listings_final)
summary(lm_listings)
# 188 observations deleted due to missingness

# Check for assumptions
plot(lm_listings)

# Create a dataframe with the models output
df_lm_listings <- tidy(lm_listings)

# Only include the significant variables with estimates > 0.075
df_lm_listings_sig <- df_lm_listings %>% filter(p.value <0.05) %>% filter(abs(estimate) > 0.075)

# Make a list with all the variables we want to keep 
variable_list_listings <- c('city', 'host_is_superhost', 'property_type', 'room_type', 'accommodates', 'bathrooms_text', 'review_scores_rating', 'review_scores_cleanliness', 'review_scores_checkin', 'review_scores_communication', 'review_scores_location', 'review_scores_value', 'instant_bookable')

# Change the variable list so that it can be used in the regression formula
variable_list_listings <- paste0('`',variable_list_listings, '`')
character_variables_listings <- paste0(variable_list_listings, collapse= '+')

# Conduct the regression with all the relevant variables
formula_listings <- as.formula(paste0('log(price)~', character_variables_listings))
regression_final <- lm(formula_listings, listings_final)
summary(regression_final)



# Save the output in a dataframe
df_regression_final <- tidy(regression_final)

# creating directory for saving the data
dir.create("../../gen/")
dir.create("../../gen/temp/")

# Save the regression output and the variable list in a csv file
write.csv(df_regression_final, file = "../../gen/temp/regression_output_listings.csv", fileEncoding = "UTF-8",row.names=FALSE )

write.csv(variable_list_listings, file = "../../gen/temp/variable_list_listings.csv", fileEncoding = "UTF-8",row.names=FALSE )

# Save the model to make predictions in the shinyapp later on
parsed_regression <- parse_model(regression_final)

write_yaml(parsed_regression, "../../gen/temp/regression_output.yml")



