## Dataset Information:
- Dataset Name: Food Delivery Time Prediction 🛵
- Number of Rows and Columns: Rows (1000), Columns (9)

## Data Summary and Descriptive Statistics
- Number of duplicates in this dataset: 0
- Missing values:
Weather has: 30 missing values
Traffic_Level has: 30 missing values
Time_of_Day has: 30 missing values
Courier_Experience_yrs has: 30 missing values


## Key patterns
**Observations**
- Average Delivery Time for Scooters and Bikes is a little faster than by car
- There seems to be a normal distribution for Delivery_Time_min with a concentration between 40-70 min
**Positive relations**
- Distance_km and Delivery_Time_min (0.82) as shown by the Spearman Correlation Matrix and the scatter plot
- Average Delivery Time and Traffic Level
**No visible relation**
- Delivery Time and Courier Experience

## Outliers
We can observe a couple of outliers in the relation between Delivery Time (minutes) and Courier Experience (Years). Later when we check the boxplot for Delivery_Time_min we see the similar outliers, meaning that the outliers are present in the Delivery_Time_min variable, however, we are keeping the records in the data.

## Assumptions
- Used missing value replacement for better metrics.
Mode for Weather, Traffic_Level and Time_of_Day
Median for Courier_Experience_yrs
- Didn't standardize input data because the algorithms used don't need it