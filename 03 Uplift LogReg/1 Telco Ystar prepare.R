df = read.table("Telco_bin2.csv",  header=TRUE, sep=";")

df$TotalCharges[is.na(df$TotalCharges)]=2283

df$Respondent=0
df$Respondent[df$Churn2==0]=1  

df$Ystar=0
df$Ystar[(df$Contract2==1) & (df$Respondent==1)]=1

summary(df)
sum(df$Ystar)
write.table(df,"Telco_bin2Ystar.csv", sep=";",row.names = FALSE)