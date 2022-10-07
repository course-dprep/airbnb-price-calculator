## 1) download & merge the data
all: listings_download.csv listings_final.csv

listings_download.csv: download_merge_data.R
	R --vanilla < download_merge_data.R

listings_final.csv: cleaning_data.R
	R --vanilla < cleaning_data.R


