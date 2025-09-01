# calculo Lift
library(tidyverse)
df = read.table("Telco_bin2ScoreGroup.csv",  header=TRUE, sep=";") 
Resp_tot=sum(df$Responder)

df %>% 
  group_by(group) %>%
  summarize(nCustomers = n(),
            nResp      = sum(Responder==1),
            percResp   = nResp/Resp_tot,
            minScore   = min(score)
            )

# alterado depois de ver a pivottable

df$persuadable=0
df$persuadable[df$score>0.8]=1 

print(paste ("persuadables=",sum(df$persuadable)))
print(paste ("%persuadables=",sum(df$persuadable)/count(df)))
  
df2 = df[order(df$customerID),] # ordenar por costumerID
write.table(df2,"Telco_Lift.csv", sep=";",row.names = FALSE)


