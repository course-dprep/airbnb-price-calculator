DATA = ../../data

all: $(DATA)/listings_download.csv $(DATA)/listings_final.csv

## download & merge the data
$(DATA)/listings_download.csv: download_merge_data.R
	mkdir -p $(DATA)
	R --vanilla < download_merge_data.R

## clean the data
$(DATA)/listings_final.csv: cleaning_data.R
	R --vanilla < cleaning_data.R


