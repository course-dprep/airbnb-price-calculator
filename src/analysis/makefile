## regression analysis

all: regression_output_listings.csv variable_list_listings.csv regression_output.yml

regression_output_listings.csv: regression_analysis.R
R --vanilla < regression_analysis.R

variable_list_listings.csv: regression_analysis.R
R --vanilla < regression_analysis.R		

regression_output.yml: regression_analysis.R
R --vanilla < regression_analysis.R


