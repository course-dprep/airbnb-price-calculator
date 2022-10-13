ANINPUT = ../../gen/analysis/input

all: $(ANINPUT)/regression_output_listings.csv $(ANINPUT)/variable_list_listings.csv $(ANINPUT)/regression_output.yml

$(ANINPUT)/regression_output_listings.csv $(ANINPUT)/variable_list_listings.csv $(ANINPUT)/regression_output.yml: regression_analysis.R
		R --vanilla < regression_analysis.R



