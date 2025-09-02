# bar chart with diff bins
library(ggplot2)

#group nCustomers nResp nTResp nCResp TreatRate ContrRate Uplift
#<int>      <int> <int>  <int>  <int>     <dbl>     <dbl>  <dbl>
#  1     1       1309   899    184    715      3.56     13.80  -10.30 
#  2     2       2062  1913   1431    482     27.70      9.32   18.30 
#  3     3       3672  2362   1339   1023     25.90     19.80    6.11



df <- data.frame(group = c( "G1",  "G2",  "G3"),
                 nobs  = c( 1309,  2062,  3672),
                 value = c(-10.3,  18.3,  6.11))
        
df      

# Calculate the future positions
df$right <- cumsum(df$nobs) + 1*c(0:(nrow(df)-1))
df$left  <- df$right - df$nobs
head(df)

ggplot(df, aes(ymin = 0)) + 
  geom_rect(aes(xmin = left, xmax = right, ymax = value) )+
  xlab("group") + 
  ylab("value") 
