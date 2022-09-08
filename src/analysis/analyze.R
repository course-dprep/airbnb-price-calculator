# load 
load("./gen/analysis/input/data_cleaned.RData")

# Estimate model 1 
m1 <- lm(V1 ~ V3 + V4,df_cleaned)

# Estimate model 2 
m2 <- lm(V1 ~ V3 + V4 + V5 , df_cleaned)

# Save results
save(m1,m2,file="./gen/analysis/output/model_results.RData")