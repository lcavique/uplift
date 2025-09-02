# Classification Tree ID3 >> C4.5 >> C5.0
library(C50) 
library(tidyverse) 
df = read.table("Telco_bin2Ystar.csv",  header=TRUE, sep=";") 
df2= select (df, c(Ystar, StreamingMovies2, StreamingTV2, OnlineBackup2, TechSupport2, 
                   DeviceProtection2, tenure, MonthlyCharges, InternetService2, OnlineSecurity2,gender2))

df2$Ystar<-as.factor(df2$Ystar)

set.seed (2022); N=nrow(df2) # conjunto treino
train <- sample (1:N, as.integer(0.75*N)) 
crtl= C5.0Control(minCases = as.integer(0.001*N))
model <- C5.0(Ystar ~ ., data = df2[train,],control=crtl, rules=TRUE)
#plot (model); 
summary(model)

pred <- predict (model, newdata = df2[-train,],type="class") # conjunto teste
t <- table(df2$Ystar[-train ], pred,dnn=c("Observed Class","Predicted Class")) # matriz confusao
print(t); accuracy= sum(diag(t))/sum(t); print (accuracy)

# alterado depois de correr o C5.0
df$group=0
df$group[df$tenure<=13]=1
df$group[df$tenure>13 & df$MonthlyCharges<=69.5]=2
df$group[df$MonthlyCharges>69.5]= 3

write.table(df,"Telco_YstarGroup.csv", sep=";",row.names = FALSE)