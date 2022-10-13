DATA = ../../data
DPINPUT = ../../gen/data-preparation/input
DPOUTPUT = ../../gen/data-preparation/output

all: $(DPINPUT)/listings_download.csv $(DPOUTPUT)/listings_final.csv $(DPOUTPUT)/data_exploration.pdf

## download & merge the data
$(DPINPUT)/listings_download.csv: download_merge_data.R
	R --vanilla < download_merge_data.R

## clean the data
$(DPOUTPUT)/listings_final.csv: cleaning_data.R
	R --vanilla < cleaning_data.R

## explore the data
$(DPOUTPUT)/data_exploration.pdf: data_exploration.Rmd
	Rscript -e 'rmarkdown::render("data_exploration.Rmd")'
