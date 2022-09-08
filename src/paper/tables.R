# Load results
load("./gen/analysis/output/model_results.RData")

# Load in additional package to export to latex table
require(stargazer) 

# Export to latex table (omits f-stat since messes up table)
stargazer(m1,m2,out="./gen/paper/output/table1.tex",
            title = "Example results", label = "tab:example",
            omit.stat=c("f")) 
