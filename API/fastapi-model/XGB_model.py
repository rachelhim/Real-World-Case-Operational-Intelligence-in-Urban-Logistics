import os
import pandas as pd
from xgboost import XGBRegressor
from sklearn.model_selection import train_test_split
from sklearn.metrics import root_mean_squared_error, mean_absolute_error
import joblib

# load the data
project_path = r'C:\Users\ronit\PG\API\fastapi-model'
data_path = os.path.join(project_path, "data", "Food_Delivery_Times.csv")
data = pd.read_csv(data_path)

# Missing values
data['Weather'] = data['Weather'].fillna(data['Weather'].mode()[0])
data['Traffic_Level'] = data['Traffic_Level'].fillna(data['Traffic_Level'].mode()[0])
data['Time_of_Day'] = data['Time_of_Day'].fillna(data['Time_of_Day'].mode()[0])
data['Courier_Experience_yrs'] = data['Courier_Experience_yrs'].fillna(data['Courier_Experience_yrs'].median())
        
# One-hot encode categorical variables
df = pd.get_dummies(data, columns=['Weather', 'Traffic_Level', 'Time_of_Day', 'Vehicle_Type'], drop_first=True)
df = df.drop(['Order_ID'], axis=1)  # Drop Order_ID as it's not a feature for prediction

# Split the data into training and testing sets
train_data, test_data = train_test_split(df, test_size = 0.30, random_state=250)  
target_column = 'Delivery_Time_min'

# Save test data for evaluation
test_data_path = os.path.join(project_path, "data", "test_data.csv") 
test_data.to_csv(test_data_path, index=False)

X_train = train_data.drop(target_column, axis=1)
y_train = train_data[target_column]
X_test = test_data.drop(target_column, axis=1)
y_test = test_data[target_column]

# Model Training
model = XGBRegressor(learning_rate=0.1,
                      max_depth=3,
                      min_child_weight=3,
                      n_estimators=50,
                      subsample=0.8,
                      random_state=42,
                      objective='reg:squarederror', 
                      eval_metric='mae')
model.fit(X_train, y_train)

# Evaluate model
predictions = model.predict(X_test)
rmse = root_mean_squared_error(y_test, predictions)
mae = mean_absolute_error(y_test, predictions)
print(f"RMSE: {rmse}")
print(f"MAE: {mae}")

# Dump the model in a pickle file
joblib.dump(model, "xgboost_regressor_model.pkl")

# Print completion message
print('File execution complete')