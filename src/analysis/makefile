TEMP = ../../gen/temp

all: $(TEMP)/regression_output_listings.csv $(TEMP)/variable_list_listings.csv $(TEMP)/regression_output.yml

$(TEMP)/regression_output_listings.csv: regression_analysis.R
		R --vanilla < regression_analysis.R

$(TEMP)/variable_list_listings.csv: regression_analysis.R
		R --vanilla < regression_analysis.R		

$(TEMP)/regression_output.yml: regression_analysis.R
		R --vanilla < regression_analysis.R


