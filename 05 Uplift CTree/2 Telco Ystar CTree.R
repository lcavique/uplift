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

# alterado depois de correr o C5.0
df$group=0
df$group[df$tenure<=46 & df$StreamingMovies2<=0 & df$tenure<=34]=1
df$group[df$tenure<=46 & df$StreamingMovies2<=0 & df$tenure >34]=2
df$group[df$tenure<=46 & df$StreamingMovies2 >0]=3
df$group[df$tenure >46 & df$tenure<=67 & df$MonthlyCharges<=26.9]=4
df$group[df$tenure >46 & df$tenure<=67 & df$MonthlyCharges >26.9]=5
df$group[df$tenure >46 & df$tenure >67]=6

write.table(df,"Telco_YstarGroup.csv", sep=";",row.names = FALSE)