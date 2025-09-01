# prepare

df = read.table("Telco_bin2.csv",  header=TRUE, sep=";")

df$TotalCharges[is.na(df$TotalCharges)]=2283

df$Responder=0
df$Responder[df$Churn2==0]=1  

write.table(df,"Telco_bin2a.csv", sep=";",row.names = FALSE)