# note: Comments for most of the repetitive codes (i.e. setting directory, etc.) are omitted.
        # They can be found in previous files (partly the reason why I organized them in numbers)

library(MASS)
setwd("~/Desktop/R Studio/RStudio_mycode/RStudio_customization-for-me/R")
options(scipen = 999) 
df <- Cars93
View(df)

## <1. Correlation Analysis> ##

# Covariance vs Correlation? : relationship and the dependency between two variables
  # Covariance: indicates the direction of the linear relationship between variables
    # but is unit-dependent, meaning it is difficult for direct comparison btw. variables
  # **Correlation: "standardized covariance". 
                  # measures both the magnitude (strength) and direction of the linear relationship between two variables
  # source: https://towardsdatascience.com/let-us-understand-the-correlation-matrix-and-covariance-matrix-d42e6b643c22 

# (Correlation of non-parametric data: using Spearman, Kendall) 
  # from Levshina, ch.6, 2015

lex <- c(47, 89, 131, 186, 245, 284, 362, 444, 553, 627)
gram <- c(0, 2, 1, 3, 5, 9, 7, 16, 25, 34)

plot(gram ~ lex, main="Vocabulary size and grammatical complexity", 
     xlab="Productive vocabulary size", ylab="Grammatical complexity score")
lines(lowess(gram ~ lex))

cor.test(gram, lex, method="spearman", alternative="greater")
cor.test(gram, lex, method="kendall", alternative="greater")

# **Correlation Test: PEARSON'S R

# 1) scatter plot

df.sub <- subset(df, select=c(Horsepower, Price, MPG.city, RPM)) # create smaller dataset containing variables of interest using subset
pairs(df.sub) # scatter plot matrix

  # OR... 

library(PerformanceAnalytics) # **using package: PerformanceAnalytics
chart.Correlation(df.sub, histogram=TRUE, method="pearson", pch=19) # displays histograpm, scatter line, significance

# 2) correlation test
  # Note that here we are dealing with the SAMPLING DISTRIBUTION of the correlation coefficient. 
  # Thus we are able to calculate t statistics, df, and confidence level (+ p-value)
cor.test(df$Horsepower, df$Price, alternative=c("two.sided"), method="pearson", conf.level=0.95) # t-test method

# 3) Fisher's Z-transformation
  # Why? To transform the sampling distribution of Pearson's r into a normal distribution.
fisher <- fisherz(0.7882176) # from PSYCH package: rho = 'r' value derived from above test.
fisher

fish <- function(r) {0.5*(log(1+r)-log(1-r))} # define function manually. 
fish(0.7882176)

### Some Considerations When Correlation...

# ASSUMPTIONS
  # 1) Linear relationship btw. X and Y. 
        # Check visually via scatterplot
        # This determines what type of correlation test you will use
  # 2) Homeoscedasticty
        # Not so strictly controlled.
        # However, heteroscedastic data will return different CorCoefficient depending on size of X & Y.
  # 3) Outlier/truncated data
  # 4) Heterogeneous groups (i.e. male/female)
        # Analyze separately, or display different groups (examples below)

# example 1: using package car --> different shapes for groups
library(car)
scatterplot(Price ~ Horsepower|Origin, data=df, 
            regLine=FALSE, grid=FALSE, legend=FALSE, smooth=FALSE, col="black")


# example 2: displaying different colors --> my_cols
my_cols <- c("#00AFBB", "#FC4E07")  
pairs(df.sub, pch=19, cex=0.5, col=my_cols[df$Origin], lower.panel=NULL) # 'pch' = fill in shape, 'cex' = thickness of shape

plot(df$Price, df$Horsepower, pch=19, cex=0.8, col=my_cols[df$Origin])

## <2. Simple Linear Regression> ##

# If correlations determines that there is a linear relationship, 
  # REGRESSION ANALYSIS determines 'what kind of' linear relationship. 
    # Y = b0 + b1X + e

# Assumptions 
    # NORMALITY and INDIVIDUALITY of residuals 
      # meaning, residuals must not follow a regression pattern --> residuals are RANDOM
      # e ~ iid N(0, s^2)
    # Homoscedasticity of residuals

# Regression Coefficient
  # minimizes the SSE (sum of squared of errors) --> BEST LINE b1 = SCP/SSx 

# Evaluation of Variance
  # Yi - Y(mean) = (total) DEVIATION 
  # Y^ - Y(mean) = PREDICTED VALUE - MEAN
  # Yi - Y^ = RESIDUAL 
  # SSy = SSresidual + SSregression --> How much of Y variance can be explained (predicted) by SSregression?
    # r^2: SSregression / SSy(deviation)
      # (in linear regression, this is equal to the squared correlation coefficient of X and Y.)
        # --> coefficient of determination (EFFECT SIZE) = R^2  

df.linear <- lm(df$Price ~ df$Horsepower)
abline(df.linear, lty=1) # draw regression line
summary(df.linear) 
  # CHECK: coefficients, multiple R^2, 
          # p-value (notice that there are two p-values: one for slope, another for model)

confint(df.linear, level=0.95) # Confidence interval for parameter
anova(df.linear) # Analysis of Variance table

# predicted value and residuals according to regression model
pred <- predict(df.linear)
resid <- residuals(df.linear)
values <- data.frame(pred, resid)
values

# does the same thing.
individual <- data.frame(df.linear$fitted.values, df.linear$residuals)
individual

# Normality check of residuals
  # using Q-Q Plot
qqnorm(df.linear$residuals) # x-axis: expected residuals assuming ND
qqline(df.linear$residuals) # y-axis actual residuals

  # using Shapiro-Wilk test
shapiro.test(df.linear$residuals)

  # using residual plot
plot(df.linear$fitted.values, df.linear$residuals)
abline(0,0)
  # --> non-homoscedastic

# Independence check 
dwt(df.linear) # Durbin-Watson test

