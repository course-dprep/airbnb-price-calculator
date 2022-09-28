library('tidyverse')


data_files <- list.files("cities/")  # Load city files
data_files


all_data=lapply(data_files[1:23], function(fn) {
    read_csv(paste0("cities/", fn))
    })



df <- bind_rows(all_data)
