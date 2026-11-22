from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field
import joblib
import numpy as np

app = FastAPI()

# Load the trained model
model = joblib.load("xgboost_regressor_model.pkl")

# Pydantic data class defines the input format for incoming POST requests
class Data(BaseModel):
    Distance_km: float
    Preparation_Time_min: float
    Courier_Experience_yrs: float
    Weather_Foggy: bool
    Weather_Rainy: bool
    Weather_Snowy: bool
    Weather_Windy: bool
    Traffic_Level_Low: bool
    Traffic_Level_Medium: bool
    Time_of_Day_Evening: bool
    Time_of_Day_Morning: bool
    Time_of_Day_Night: bool
    Vehicle_Type_Car: bool
    Vehicle_Type_Scooter: bool

    model_config = {
        "json_schema_extra": {
            "example": {
                "Distance_km": 16.23,
                "Preparation_Time_min": 6,
                "Courier_Experience_yrs": 0,
                "Weather_Foggy": False,
                "Weather_Rainy": False,
                "Weather_Snowy": False,
                "Weather_Windy": False,
                "Traffic_Level_Low": False,
                "Traffic_Level_Medium": True,
                "Time_of_Day_Evening": True,
                "Time_of_Day_Morning": False,
                "Time_of_Day_Night": False,
                "Vehicle_Type_Car": False,
                "Vehicle_Type_Scooter": False
            }
        }
    }

# Define the request model to accept an instance of the Data model
class PredictionRequest(BaseModel):
    features: Data

# Define the response model
class PredictionResponse(BaseModel):
    prediction: float

# Create a GET endpoint, which returns a welcome message
# Helps users know the API is running and where to send data
@app.get("/")
async def get_root():
    return {"message": "Welcome to the Food Delivery Time Prediction API. Use the /predict endpoint to get predictions."}

# Prediction endpoint
@app.post("/predict", response_model=PredictionResponse)
async def predict(request: PredictionRequest):

    feature_names = model.get_booster().feature_names

    if feature_names is None:
        raise HTTPException(
            status_code=500,
            detail="The model does not have feature names."
        )

    feature_dict = request.features.model_dump()

    feature_values = [
        feature_dict.get(name, 0)
        for name in feature_names
    ]

    features_array = np.array([feature_values])

    prediction = model.predict(features_array)[0]

    return PredictionResponse(
        prediction=float(prediction)
    )