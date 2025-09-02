# calculo Uplift
library(tidyverse)
df = read.table("Telco_YstarSortedGroup.csv",  header=TRUE, sep=";") 
Resp_tot=sum(df$Respondent)

df %>% 
  group_by(group) %>%
  summarize(nCustomers = n(),
            nResp      = sum(Respondent==1),
            nTResp     = sum(Contract2==1 & Respondent ==1),
            nCResp     = sum(Contract2==0 & Respondent ==1),
            TreatRate  = nTResp/Resp_tot*100,
            ContrRate  = nCResp/Resp_tot*100, 
            Uplift     = TreatRate-ContrRate,
            # minScore   = min(score),
            # maxScore   = max(score)
            )

# alterado depois de ver a pivottable
df$uplift=0
df$uplift[df$group==1]=  -14.70 
df$uplift[df$group==2]=    2.09
df$uplift[df$group==3]=   -3.65
df$uplift[df$group==4]=    5.62
df$uplift[df$group==5]=   10.00
df$uplift[df$group==6]=   14.80

df$persuadable=0
df$persuadable[df$uplift>0]=1 
print(paste ("persuadables=",sum(df$persuadable)))
print(paste ("%persuadables=",sum(df$persuadable)/count(df)))

df2 = df[order(df$customerID),] # ordenar por costumerID
write.table(df2,"Telco_YstarzUplift.csv", sep=";",row.names = FALSE)


