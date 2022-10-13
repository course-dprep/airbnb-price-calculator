ANOUTPUT = ../../gen/analysis/output

all: $(ANOUTPUT)/regression_output.csv

$(ANOUTPUT)/regression_output.csv: shiny_app.R
		R --vanilla < shiny_app.R
