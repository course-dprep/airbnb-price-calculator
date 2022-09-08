# Copy output from data-preparation into input folder 
# This step really depends no how files are shared across the different stages (e.g. if whole pipeline
# is on a single machine, could directly access output folder from prepaaration stage)
file.copy("./gen/data-preparation/output/data_cleaned.RData","./gen/analysis/input/data_cleaned.RData")
