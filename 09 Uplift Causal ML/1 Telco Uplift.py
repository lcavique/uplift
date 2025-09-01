# causalML uplift
import pandas as pd 
import numpy as np
import matplotlib.pyplot as plt
df = pd.read_csv("Telco_bin2Ystar.csv", sep=";")

from causalml.inference.tree import UpliftTreeClassifier
treatment = (df['Ystar'] == 1).astype(int)
treatment_str = np.where(treatment == 1, 'treatment', 'control')
X = df[[ 'StreamingMovies2', 'StreamingTV2', 'OnlineBackup2', 'TechSupport2', 'DeviceProtection2', 'tenure', 'MonthlyCharges', 'InternetService2','OnlineSecurity2', 'gender2']].copy()
y = df['Respondent']

uplift_model = UpliftTreeClassifier(max_depth=5,min_samples_leaf=100, n_reg=100, evaluationFunction='KL', control_name='control')

uplift_model.fit(X=X, treatment=treatment_str, y=y)
uplift_preds = uplift_model.predict(X=X)
ITE = uplift_preds[:, 1] - uplift_preds[:, 0]


# Sort, divide into 5 groups, calculate averages
sorted_ITE = sorted(ITE)
groups = np.array_split(sorted_ITE, 10)
averages = [np.mean(group) for group in groups]

# Plot
plt.bar(range(1, 10+1), averages)
plt.xlabel('Groups')
plt.ylabel('Average')
plt.title('Group Averages')
plt.show()

print("Group averages:", [round(avg, 2) for avg in averages])
