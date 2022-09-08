# Load merged data 
load("./gen/data-preparation/temp/data_merged.RData")

# Drop observations with V1 <= -0.9
df_cleaned <- df_merged[df_merged$V1 > -0.9,]

# Remove V1
df_cleaned <- df_cleaned[,c(1,2,4:7)]

# Save cleaned data
save(df_cleaned,file="./gen/data-preparation/output/data_cleaned.RData")
