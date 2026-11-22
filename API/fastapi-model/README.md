API Prototype

This project provides a simple web API built with FastAPI to serve a trained XGBoost model. It allows users to send input feature data via a POST request and receive predictions from the model.

Because of technical problems with Docker we were not a able to containerize the API for portability. But the neccesary files are available.

## Features

*   Serves a pre-trained XGBoost model.
*   Provides a `/predict` endpoint for making predictions.
*   Uses Pydantic for request data validation.
*   Includes automatic interactive API documentation (Swagger UI and ReDoc).

## Instructions

(1) Clone the repository.

(2) Install dependencies:

    pip install -r requirements.txt

(3) Run the Server

To start the API server locally, run the following command in your terminal from the project's root directory:

    uvicorn main:app --reload

The server will typically start on `http://127.0.0.1:8000`.

## Usage

**(1) Access API Documentation:**

Once the server is running, open your web browser and navigate to:
*   `http://127.0.0.1:8000/docs` for interactive Swagger UI documentation.
*   `http://127.0.0.1:8000/redoc` for alternative ReDoc documentation.

You can view the expected request format and test the `/predict` endpoint directly from the Swagger UI.

**(2) Send a Prediction Request (Example using `curl`):**

You can send a `POST` request to the `/predict` endpoint with the input features in the JSON body. Open a new terminal (while the server is running) and use a command like `curl`:

```bash
curl -X POST http://127.0.0.1:8000/predict \
     -H "Content-Type: application/json" \
     -d '{
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
         }'
```

The server will respond with a JSON object containing the prediction, such as:

```json
{"Prediction for row 5": 52.451744079589844}
```

1. With terminal navigate to the root of this repository
2. Build docker image
docker build -t image_name .
3. Run container
docker run --name container_name -p 8000:8000 image_name
4. Output will contain
INFO: Uvicorn running on http://0.0.0.0:8000

Use this url in chrome to see the model frontend; use http://0.0.0.0:8000/docs for testing the model in the web interface.

5. Query model
Via web interface (chrome):
http://0.0.0.0:8000/docs -> test model

Via python client:
client.py

Via curl request:
curl -X POST "http://0.0.0.0:8000/predict" -H "accept: application/json" -H 