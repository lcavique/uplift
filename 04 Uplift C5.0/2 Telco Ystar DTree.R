# Classification Tree ID3 >> C4.5 >> C5.0
library(C50) 
library(tidyverse) 
df = read.table("Telco_bin2Ystar.csv",  header=TRUE, sep=";") 
df2= select (df, c(Ystar, StreamingMovies2, StreamingTV2, OnlineBackup2, TechSupport2, 
                   DeviceProtection2, tenure, MonthlyCharges, InternetService2, OnlineSecurity2,gender2))
df2$Ystar<-as.factor(df2$Ystar)

set.seed (2022); N=nrow(df2) # conjunto treino
train <- sample (1:N, as.integer(0.90*N))
crtl= C5.0Control(minCases = as.integer(0.01*N))
model <- C5.0(Ystar ~ ., data = df2,# [train,], ##################################
                                    #control=crtl, 
                                    rules=TRUE)
#plot (model); 
summary(model)

pred <- predict (model, newdata = df2[-train,],type="class") # conjunto teste
t <- table(df2$Ystar[-train ], pred,dnn=c("Observed Class","Predicted Class")) # matriz confusao
print(t); accuracy= sum(diag(t))/sum(t); print (accuracy)

# alterado depois de correr o C5.0
df$score=0
df$score[df$tenure<=1 & df$InternetService2<=0 ]=(1-0.595)
df$score[df$tenure>1  & df$tenure<=13 & df$MonthlyCharges<=69.5]=(1-0.586)
df$score[df$tenure>13 & df$MonthlyCharges<=69.5]=0.746
df$score[df$tenure<=1 & df$InternetService2>0]=0.730
df$score[df$MonthlyCharges>69.5]=0.682

write.table(df,"Telco_YstarScore.csv", sep=";",row.names = FALSE)