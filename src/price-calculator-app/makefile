TEMP = ../../gen/temp

all: $(TEMP)/regression_output.csv

$(TEMP)/regression_output.csv: shiny_app.R
		R --vanilla < shiny_app.R
