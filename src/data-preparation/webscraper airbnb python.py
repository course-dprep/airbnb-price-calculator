# # Python webscraper Inside Airbnb
# This webscraper is build to extract all the "listing.csv.gz" download links from Inside Airbnb at one. 
# These different download links are saved into a csv that is the basis to download all the data in R Studio. 
# 

# ### 1) Import the packages

from bs4 import BeautifulSoup
from time import sleep
import pandas as pd


# ### 2) Prepare Selenium

from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager

driver = webdriver.Chrome(ChromeDriverManager().install())

inside_airbnb_url= "http://insideairbnb.com/get-the-data.html"
driver.get(inside_airbnb_url)


# ### 3) set up the url to scrape

inside_airbnb_url= "http://insideairbnb.com/get-the-data.html"
driver.get(inside_airbnb_url)


# ### 4) Load the page source and open it with BeautifulSoup

res = driver.page_source # Load the page source
soup = BeautifulSoup(res, features="html.parser") # Open the page source with BeautifulSoup
cities_list=soup.find_all('tbody') # Create a list of all the cities (identified by 'tbody')
identifier_list=soup.find_all('h3') # Create a list that provides the identifier of the city (which is: the city, province/state, and country)


# ### 5) The loop to get data from all the EU cities

city_data=[] # Creating a list to store the data in
for city in range(len(cities_list)):
    tmp_url = cities_list[city].find("a").get('href') # Open the first "a" in each 'tbody' (since the listings.csv.gz file is here) and only extract the 'href' (which is the link of the csv.gz file)
    identifier = identifier_list[city].text # Get the identifier that corresponds to this city (i.e. the city, state/province, country variable)
    country = identifier.split(",",3)[-1] # Save the country, which is always the last part of the identifier that seperates city, state/province and country by comma's.
    city = identifier.split(",",3)[0] # 
    
    # Store the city, country and URL link in a temporary dictionary:
    city_info = {"Country": country, "City": city ,"Link": tmp_url}
    
    # Append the temporary dictionary to the list of all cities:
    city_data.append(city_info) 


# ### 6) Save the data to a csv

(pd.DataFrame(city_data)).to_csv("Airbnb_listing_urls.csv", index=False, sep=';') 

