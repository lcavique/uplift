# sort the groups

df = read.table("Telco_YstarGroup.csv",  header=TRUE, sep=";") 
df2 = df[order(-df$group),] # ordenar por score

write.table(df2,"Telco_YstarSortedGroup.csv", sep=";",row.names = FALSE)