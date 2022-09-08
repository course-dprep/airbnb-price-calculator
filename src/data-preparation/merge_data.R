# Load datasets into R 
df1 <- read.csv("./gen/data-preparation/input/dataset1.csv")
df2 <- read.csv("./gen/data-preparation/input/dataset2.csv")

# Merge on id
df_merged <- merge(df1,df2,by="id")

# Save merged data
save(df_merged,file="./gen/data-preparation/temp/data_merged.RData")