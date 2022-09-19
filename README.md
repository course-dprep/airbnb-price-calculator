# Airbnb - How Much Can You Make?
This project estimates how the different characteristics of an Airbnb affect the asking price. We created a tool to accurately predict the rental properties annual revenue. This tool helps investors/home owners make a good investment or avoid loss. 

## Research motivation

Investors looking for a second and potentially passive source of income may consider buying and renting a property. In traditional real estate investing the objective is purchasing a home with the intention of leasing it out permanently (usually for a period of six months and longer). However, as Airbnb and other platforms for vacation rentals have recently grown in popularity, there are more chances for property owners to create a passive income stream. Yet, this does not imply that it will turn out to be a valid investment for everyone. Depending on specific characteristics (e.g. demographics, accommodation and competitors) investing on a short-term rental may not be wise. For this reason, we created an estimation tool that future Airbnb owners can use to accurately forecast their profits.

### Research question
_How do the characteristics of an Airbnb affect the asking price to accurately predict the rental properties annual revenue?_ 

## Research method

The estimating tool will be accessible to everyone on a website. The website visitor must fill out specific information about their accommodation. The data used to determine the estimated yearly income are:

- average daily price for different listings 
- monthly average occupancy rate for each city taken into account

The average daily price considered will be based on competitors that have similar characteristics in terms of: 
- demographics (neighborhood, nearby facilities) 
- accommodation (e.g. rating, amenities, type of accommodation)

To collect the required data a web scraper for InsideAirbnb.com was built.

## Relevance


## repository overview


### Dependencies

Please follow the installation guide on http://tilburgsciencehub.com/.

- Python. [Installation guide](https://tilburgsciencehub.com/building-blocks/configure-your-computer/statistics-and-computation/python/).
- R. [Installation guide](https://tilburgsciencehub.com/building-blocks/configure-your-computer/statistics-and-computation/r/).
- Make. [Installation guide](https://tilburgsciencehub.com/building-blocks/configure-your-computer/automation-and-workflows/make/).

- For Python, make sure you have installed below packages:
```
pip install bs4
pip install selenium
```

- For R, make sure you have installed below packages:
```
install.packages("tidyverse")
install.packages("ggfortify")
install.packages("yaml")
install.packeges("shiny")
install.packages("googledrive")
install.packages("tidypredict")
install.packages("car")
install.packages("base")
install.packages("data.table")
install.packages("broom")
install.packages("haven")
install.packages("readxl")
```

### Running the code


## Authors
[Cas Rooijackers](https://github.com/casrooij), [Gennaro Santoro](https://github.com/Ginseng-Effect), [Jesper Krauth](https://github.com/jesperkrauth), [Ludovica Donatelli](https://github.com/ludoivca), [Patrick de Graaf](https://github.com/Patrickdeg)
