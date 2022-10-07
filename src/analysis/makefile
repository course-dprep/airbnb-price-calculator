## 1) download & merge the data
all: listings_download.csv 

listings_download.csv: download_merge_data.R
R --vanilla < download_merge_data.R


## 2) cleaning the data
all: listings_final.csv

listings_final.csv: cleaning_data.R
R --vanilla < cleaning_data.R


#3) regression analysis

all: regression_output_listings.csv variable_list_listings.csv regression_output.yml

regression_output_listings.csv: regression_analysis.R
R --vanilla < regression_analysis.R

variable_list_listings.csv: regression_analysis.R
R --vanilla < regression_analysis.R		

regression_output.yml: regression_analysis.R
R --vanilla < regression_analysis.R


#4) shiny app
all: regression_output.csv

regression_output.csv: shiny_app.R
		R --vanilla < shiny_app.R






