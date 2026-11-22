**Modeling logic**
Boosting is one of the Sequential Ensemble techniques. This technique is usually applied to the data with high bias and low variance.
XGBoost and LightGBM are the 2 popular boosting algorithms.
We test them both with different parameters to get the best parameters for each algorithm. Then we compare scores to select the best model.
In this case we got:
XGBoost
Score on train data =  0.8036
Score on test data =  0.8003
MAE on test data = 6.7233
LightGBM
Score on train data: 0.817
Score on test data: 0.792
MAE on test data: 6.7521
With this information we can deduce that the best model is **XGBoost**.

**Metric choice**
Accuracy: proportion of correct predictions made by the model out of all predictions.
MAE: average of the absolute differences between the predicted and actual values.

**Tuning approach**
We performed parameter tuning, dividing the data sample into 5 parts. Choose the best parameters for XGBoost and LightGBM.
Parameters used for XGBoost:
{'learning_rate': 0.1,
 'max_depth': 3,
 'min_child_weight': 3,
 'n_estimators': 50,
 'subsample': 0.8}
Parameters used for LightGBM:
{'learning_rate': 0.05, 
 'max_depth': 3,
 'min_child_weight': 1, 
 'n_estimators': 200, 
 'num_leaves': 31, 
 'subsample': 0.8}