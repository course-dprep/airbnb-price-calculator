# Load the packages
library(data.table)
library(shiny)
library(shinyWidgets)
library(bslib)
library(shinythemes)
library(yaml)
library(readr)
library(tidypredict)
library(broom)
library(dplyr)

# Load the output of the regression
regression_output<- read.csv("../../gen/analysis/input/regression_output_listings.csv", fileEncoding = "UTF-8")
airbnb_listings <- read.csv("../../gen/data-preparation/output/listings_final.csv", fileEncoding = "UTF-8") 
variable_list<- read.csv("../../gen/analysis/input/variable_list_listings.csv")
regression_model<-read_yaml("../../gen/analysis/input/regression_output.yml")
regression_model <- as_parsed_model(regression_model)

## Clean the variables and create lists:
# Property types
regression_output_prop <- regression_output[regression_output$term %like% "property_type",] 
regression_output_prop$term <- (gsub("property_type", "", regression_output_prop$term))
property_types<-sort(unique(airbnb_listings$property_type))

# Room types
regression_output_room <- regression_output[regression_output$term %like% "room_type",] 
regression_output_room$term <- (gsub("room_type", "", regression_output_room$term))
room_types<-unique(airbnb_listings$room_type)

# Cities
regression_output_cities <- regression_output[regression_output$term %like% "city",] 
regression_output_cities$term <- (gsub("city", "", regression_output_cities$term))
cities<-sort(unique(airbnb_listings$city))

## Function
# Make an empty data frame with the variables as headers

df_creator<-function(variable_list, cities, regression_output, input, regression_final){
  
  # Load the variables that were taken into the model and create an empty data frame with these variables as heading (this dataframe will later be used to run the regression on):
  table_heads <- variable_list
  table_heads <- gsub("\\`", "", table_heads) # remove the '`' from the headings, this way the heading matches the regression headings.
  df <- data.frame(matrix(ncol = length(table_heads), nrow = length(cities))) # make an empty data frame on which we will run the regression
  colnames(df) <- table_heads # change the column names into the needed table headers
  
  # Save the other input of the user to the dataframe, such that we can later apply the regression on this data frame  
  df[1, 'property_type']<- input$"Property type"
  df[1, 'host_is_superhost'] <- as.numeric(input$superhost)
  df[1, 'bathrooms_text']<- as.numeric(input$bath)
  df[1, 'room_type']<- input$"Room type"
  df[1, 'accommodates']<- as.numeric(input$acc)
  df[1, 'review_scores_rating']<- as.numeric(input$rating)
  df[1, 'review_scores_cleanliness']<- as.numeric(input$clean)
  df[1, 'review_scores_checkin']<- as.numeric(input$checkin)
  df[1, 'review_scores_communication']<- as.numeric(input$communication)
  df[1, 'review_scores_location']<- as.numeric(input$location)
  df[1, 'review_scores_value']<- as.numeric(input$value)
  df[1, 'instant_bookable']<- as.numeric(input$bookable)
  # copy the data of the first row to all rows in the data frame
  df[1:length(cities),]<-df[1,]
  
  # store all possible cities in the cities column of the data frame
  df[1:length(cities),'city']<-cities
  
  # create a column in which the predicted regression price can later be stored
  df[,'price']<-0
  df$'price'<- df %>% mutate(pred = exp(!! tidypredict_fit(regression_final)))%>% select(pred)
  
  # arrange the price column in such a way that the highest price is on the top
  df<- df %>% arrange(desc(price))
  
  return(df)
}



## Shiny App

# Define UI for application 
ui <- fluidPage(
  
  # theme
  theme = shinytheme('superhero'),
  
  # title of application
  titlePanel("Airbnb price calculator"),
  
  # information about your listing
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "city", label = "City",
                  choices = cities,
                  selected = cities[1]),
      
      selectInput(inputId = "Property type", label = "Property type", 
                  choices = property_types,
                  selected = property_types[1]),
      
      selectInput(inputId = "superhost", label = "Host is superhost? ", 
                  choices = list("",'Yes'=1,'No'=0),
                  selected = 1),
      
      selectInput(inputId = "Room type", label = "Room type", 
                  choices = room_types,
                  selected = room_types[1]),
      
      numericInput(inputId = "acc", label = "Maximum number of guests", value = 6, min = 1, max = 16, step = 1),
      numericInput(inputId = "bath", label = "Number of bathrooms", value = 1, min = 0, max = 50, step = 1),
      
      selectInput(inputId = "bookable", label = "Is the listing instant bookable? ", 
                  choices = list("",'Yes'=1,'No'=0),
                  selected = 1),
      
      sliderInput(inputId = "rating", label = "Review score rating", value = 3, min = 0, max = 5, step = 1),
      sliderInput(inputId = "clean", label = "Review score cleanliness", value = 3, min = 0, max = 5, step = 1),
      sliderInput(inputId = "checkin", label = "Review score checkin", value = 3, min = 0, max = 5, step = 1),
      sliderInput(inputId = "communication", label = "Review score communication", value = 3, min = 0, max = 5, step = 1),
      sliderInput(inputId = "location", label = "Review score location", value = 3, min = 0, max = 5, step = 1),
      sliderInput(inputId = "value", label = "Review score value" , value = 3, min = 0, max = 5, step = 1),
    ),
   
    mainPanel(
      textOutput("out"),
      textOutput("extra"),
      tableOutput("table")
    )
  )
)


# fuction server
server <- function(input, output, session){
  
  #change the possible inputs based on the answer to the question "Are there reviews available for this listing?"
  observeEvent(input$ratings_present, {  
    updateNumericInput(session, input = "clean", value = 5, NA, min = 0,0, max = 5,0, step = 1)
    updateNumericInput(session, input = "checkin", value = 5, NA, min = 0,0, max = 5,0, step = 1)
    updateNumericInput(session, input = "communication", value = 5, NA, min = 0,0, max = 5,0, step = 1)
    updateNumericInput(session, input = "rating", value = 5, NA, min = 0,0, max = 5,0, step = 1)
    updateNumericInput(session, input = "location", value = 5, NA, min = 0,0, max = 5,0, step = 1)
    updateNumericInput(session, input = "value", value = 5, NA, min = 0,0, max = 5,0, step = 1)
  })
  
  # run the applicable regression analysis over the data that the user filled out
  output$out<-renderText({
    df<-df_creator(variable_list[,'x'], cities, regression_output, input, regression_model)
    # define the output
    paste("A reasonable price for one night at this Airbnb would be: €",  round(df[df$city==input$city,'price'],2))
  })
  
  output$out<-renderText({
    df<-df_creator(variable_list[,'x'], cities, regression_output, input, regression_model)
    # define the output
    paste("The predicted price for one night at this Airbnb would be: €",  round(df[df$city==input$city,'price'],2))
  })
  
  
  # add a extra line that introduces the table
  output$extra<- renderText({paste(" The number of bookings are based on the average number of annual bookings per city. Below you can find what the 
                                   price and the predicted annual revenue of a comparable Airbnb in other European cities would be: \n ")})
  
  # making df for annual revenue
  booked_annual = c(68,74,79,54,46,74,55,82,27,83,49,68,62,39,35,34,55,53,79,60,88,68,80) # created a dataframe with the average bookings of the European cities
  df_annual <- data.frame(cities, booked_annual)
  df_annual$booked_annual <- round(as.numeric(df_annual$booked_annual), 0)
  colnames(df_annual)[1] <- "city"
  colnames(df_annual)[2] <- "number of bookings"
  
  # show a table in which the user can see the advised price of comparable airbnb's in other cities
  output$table <- renderTable({
    df<-df_creator(variable_list[,'x'], cities, regression_output, input, regression_model)
    # extract only the relevant columns of the dataframe that we want to show to the user
    df_to_show<-df%>% select(city, 'price')
    df_to_show<- merge(df_to_show, df_annual, by='city')
    df_to_show['predicted annual revenue'] <- df_to_show$price*df_to_show$`number of bookings`
    df_to_show
  })
}

# Saving the output
write.csv(regression_output, file= "../../gen/analysis/output/regression_output.csv", fileEncoding = "UTF-8")

# Run the application 
shinyApp(ui = ui, server = server) 


