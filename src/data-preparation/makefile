all: listings_download.csv listings_final.csv

## download & merge the data
listings_download.csv: download_merge_data.R
	R --vanilla < download_merge_data.R

## clean the data
listings_final.csv: cleaning_data.R
	R --vanilla < cleaning_data.R


