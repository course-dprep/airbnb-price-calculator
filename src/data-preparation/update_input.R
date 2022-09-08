# Copy the raw data into input folder 
# This step really depends no how files are shared across the different stages (e.g. if whole pipeline
# is on a single machine, could directly access data from data directory)
file.copy("./data/dataset1/dataset1.csv","./gen/data-preparation/input/dataset1.csv")
file.copy("./data/dataset2/dataset2.csv","./gen/data-preparation/input/dataset2.csv")
