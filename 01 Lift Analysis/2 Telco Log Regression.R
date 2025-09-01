# logistic regression
library(caTools)    # For Logistic regression
library(ROCR)       # For ROC curve to evaluate model
df = read.table("Telco_bin2a.csv",  header=TRUE, sep=";")

log_model = glm(Responder ~ tenure+MonthlyCharges+TotalCharges+InternetService2, 
            family = "binomial", data=df)
summary(log_model)

# Predict test data based on logistic model
prediction = predict(log_model, df, type = "response")
df$score=prediction
prediction= ifelse(prediction >=0.5, 1, 0)

# using confusion matrix
t=table(df$Responder, prediction)
print(t)
accuracy= sum(diag(t))/sum(t)
print (accuracy)

write.table(df,"Telco_bin2Score.csv", sep=";",row.names = FALSE)