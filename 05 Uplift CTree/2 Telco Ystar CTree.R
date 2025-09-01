# Classification Tree CART
library(tidyverse)
library(party)
library(partykit)
df = read.table("Telco_bin2Ystar.csv",  header=TRUE, sep=";") 
df2= select (df, c(Ystar, StreamingMovies2, StreamingTV2, OnlineBackup2, TechSupport2, 
                   DeviceProtection2, tenure, MonthlyCharges, InternetService2, OnlineSecurity2,gender2))
df2$Ystar<-as.factor(df2$Ystar)

crt=ctree_control(minsplit = 1500)
fit <- ctree(Ystar ~ StreamingMovies2 + StreamingTV2 + OnlineBackup2 + TechSupport2 + 
                    DeviceProtection2 + tenure + MonthlyCharges + InternetService2 +
                    OnlineSecurity2 +gender2, data=df2, control=crt)
plot(fit, main="Conditional Inference Tree")
fit
t = table(predict(fit), df2$Ystar)
print(t); accuracy= sum(diag(t))/sum(t); print (accuracy)

# alterado depois de correr DecTree
df$score=0
df$score[df$tenure<=46 & df$StreamingMovies2<=0 & df$tenure<=34]=(1-0.476)
df$score[df$tenure<=46 & df$StreamingMovies2<=0 & df$tenure >34]=(1-0.339)
df$score[df$tenure<=46 & df$StreamingMovies2 >0]=(1-0.379)
df$score[df$tenure >46 & df$tenure<=67 & df$MonthlyCharges<=26.9]=(1-0.026)
df$score[df$tenure >46 & df$tenure<=67 & df$MonthlyCharges >26.9]=(1-0.287)
df$score[df$tenure >46 & df$tenure >67]=(1-0.060)

write.table(df,"Telco_YstarScore.csv", sep=";",row.names = FALSE)