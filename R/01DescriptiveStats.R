#### <1. basic setup for data processing> ####
# TIP. Only use this file as template. Create new file for each project. 

# sample data from MASS package
install.packages("MASS") # skip if already installed
library(MASS)

setwd("~/Desktop/R Studio/RStudio_mycode/RStudio_customization-for-me/R")
options(scipen = 999) # scientific notation to decimal points

##importing external files

# 1. If data file extension is '.txt' 
# 'delim': reads data with boundaries made with TAB
# **naming is arbitrary. Fill in file name accordingly.
data <- read.delim("~/Desktop/R Studio/RStudio_mycode/data.txt") # file has to be inside directory folder

# 2. if data file extension is '.xlsx'
# you need library(readxl). 
library(readxl)
data <- read_excel("data.xlsx")

# 3. if data file extension is '.csv'
data <- read.csv("data.csv", header = TRUE) # if file contains header

View(data) # opens tab for dataframe

View(Cars93)
df <- Cars93
View(df)

## **Central Tendency Measures + Dispersion
# WHY? CTM: summarizing data while minimizing loss. (mode, median, mean)
# WHY? Dispersion: making assumptions about the distribution of data --> crucial for probability calculation! 
# TIP: using the below methods, roughly imagine the shape of the data distribution. --> This will help a lot!

library(psych) # includes "describe" function 
str(df) # use to check variable type (Factor, num, int, etc.)
summary(subset(df, select = c(MPG.city, Price, DriveTrain))) # subset: shows selected variables
describe(df[c("MPG.city", "Price", "DriveTrain")]) # includes SD, median, mean, skew/kurtosis, N-size

# change variable types


# (mode requires additional package) : while suitable for nominal scale, not so much for continuous variables.
library(modeest)
mfv(df$DriveTrain)
mfv(df$Price)

# ******** deal with missing values!!

#### <2.Tables and Graphs> ####

## Frequency Distribution
# shows the distribution of INDIVIDUAL SCORES within a measurement score.

# 1. frequency distribution of QUALITATIVE data
qual.data <- df$DriveTrain
table(qual.data) # you can see here that there are 3 categories: FRONT, REAR, 4WD + frequency
barplot(table(qual.data), ylim=c(0,80), xlab="x_name",
        ylab="y_name", axis.lty="solid", space=1,
        main="PLOT_NAME")

# 2. frequency distribution of QUANTITATIVE data

quant.data <- df$MPG.city
quant.data # this simply lays out all the data values. 
table(quant.data) # table function displays values + FREQ. --> easier to see the rough distribution.
hist(quant.data) 

## <3.Probability: Normal Distribution> ##

pnorm(1.33, 0, 1) # cumulative probability of z score(1.33), when SND
1-pnorm(1.33, 0, 1) # probability of excessive value
qnorm(0.9082409, 0, 1) # z score of probability(0.9); when SND
1-qnorm(0.9082409, 0, 1)

# unloading package from memory
detach("package:MASS", unload=TRUE) 
detach("package:psych", unload=TRUE)
detach("package:modeest", unload=TRUE)

### REVIEW
# Familiarizing with DESCRIPTIVE DATA:
# allows us to present data in a simplified manner, which in turn enables further hypothesis testing.
# **Habituate yourself to scan through Central Tendency Measures and Dispersion!
