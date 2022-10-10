TEMP = ../../gen/temp
PAPER = ../../gen/paper/output

all: $(TEMP)/regression_output_listings.csv $(TEMP)/variable_list_listings.csv $(TEMP)/regression_output.yml $(PAPER)/plot_assumptions.pdf

$(TEMP)/regression_output_listings.csv: regression_analysis.R
		R --vanilla < regression_analysis.R

$(TEMP)/variable_list_listings.csv: regression_analysis.R
		R --vanilla < regression_analysis.R		

$(TEMP)/regression_output.yml: regression_analysis.R
		R --vanilla < regression_analysis.R

$(PAPER)/plot_assumptions.pdf: regression_analysis.R
		R --vanilla < regression_analysis.R

