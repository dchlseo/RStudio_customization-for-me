library(MASS)
setwd("~/Desktop/R Studio/RStudio_mycode/RStudio_customization-for-me/R")
options(scipen = 999) 
df <- Cars93
View(df)

## Creating dataframe containing the variables of interest 
  # Price, Horsepower, MPG.city, RPM, NonUSA, DriveTrain
  # Categorical variables (i.e. NonUSA/Origin, DriveTrain) must be converted into dummy variables (i.e. 0 and 1)

# 1. Create subset
df.sub <- subset(df, select=c(Price, Horsepower, MPG.city, RPM, Origin, DriveTrain))
