


setwd("~/Desktop/R Studio/RStudio_mycode/RStudio_customization-for-me/R")
options(scipen = 999) 

## <1. one-sample t-test> ##
library(psych)

qt(0.900, df=15, lower.tail=TRUE) # t-value and probability
pt(1.340606, df=15, lower.tail=TRUE) # 'lower.tail=TRUE' --> probability from the lower tail.

testGroup <- c(6, 7, 11, 5, 12, 6, 9)
summary(testGroup)
describe(testGroup)

t.test(testGroup, mu=11, alternative="two.sided", conf.level=.99)
t.test(testGroup, mu=11, alternative="less", conf.level=.99) # or "greater" if other side
results <- t.test(testGroup, mu=11, alternative="two.sided", conf.level=.99)
results$statistic # returns t value
results$parameter
results$p.value
results$estimate # mean of variable x

## <2. Independent samples t test> p. 241


