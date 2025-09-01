# discriminat analysis
df = read.table("Telco_bin2Ystar.csv",  header=TRUE, sep=";") # abrir ficheiro

# Linear Discriminant Analysis with Jacknifed Prediction
library(MASS)
fit <- lda(Ystar ~ tenure+MonthlyCharges+TotalCharges+InternetService2, 
           data=df, na.action="na.omit", CV=TRUE)
#fit # show results

# predicted score
df$score=fit$posterior[,"1"]

# using confusion matrix
t = table(df$Ystar, fit$class)
diag(prop.table(t, 1))
sum(diag(prop.table(t)))

write.table(df,"Telco_YstarScore.csv", sep=";",row.names = FALSE)