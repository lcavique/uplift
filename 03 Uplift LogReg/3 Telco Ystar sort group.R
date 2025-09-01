# Uplift
df = read.table("Telco_YstarScore.csv",  header=TRUE, sep=";") 
df2 = df[order(-df$score),] # ordenar por score

Ngroups=10
df2$group=0
N=nrow(df2) 
n=round(N/Ngroups,digits=0)+1
for (i in 1:N){df2[i,]$group=floor(i/n)+1}

write.table(df2,"Telco_YstarScoreGroup.csv", sep=";",row.names = FALSE)

