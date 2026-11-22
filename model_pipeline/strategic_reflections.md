1. Model Failure:  Your model underestimates delivery time on rainy days. Do you fix the model, the data, or the business expectations? 
There is a couple of steps that we can take to approach this problem.
We can check the data first to see the origin of the data and verify the accuracy of the data. If the data in not reliable we can work on data integrity.
According to the data provided we can see the distribution of Rainy data is significant less, so it could be the representation of the data, to fix that we could try duplicate the data until we have a more equal representation of Rainy data.
Weather
Clear    500
Rainy    204
Foggy    103
Snowy     97
Windy     96
If none of those work then we can look for better or more precise models.

2. Transferability:  The model performs well in Mumbai. It’s now being deployed in São Paulo. How do you ensure generalization? 
Verify that the measures are the same in both places (km, min, etc.)
Also check that the data used for the model had (ideally) diverse and representative training data from both cities.
Look for opportunities to implement reinforcement learning into the model.

3. GenAI Disclosure:  Generative AI tools are a great resource that can facilitate development, what parts of this project did you use GenAI tools for? How did you validate or modify their output? 
We used Copilot in the problem resolution for library installations (uvicorn) and the AI embedded in VSC for code writing.
There was no use of AI tools in any other part of this project. I did however, used internet resources listed below

4. Your Signature Insight:  What's one non-obvious insight or decision you're proud of from this project? 
An interesting insight is the distribution of the categorical features, they are not equal which could affect the results of the predictions by lack of representation.
With the assumption that the data will not be under much human interaction, we created a preprocessing pipeline that takes into account categorical features using one-hot encoding. Also ran two popular models for regression with parameters testing to get the best parameters by model and then make a decision of what model to choose based on evaluation metrics. 

5. Going to Production: How would you deploy your model to production? What other components would you need to include/develop in your codebase? Please be as detailed each step of the process, and feel free to showcase some of these components in the codebase. 
After the creation of the training pipeline in which we do the data validation, preparation, the model training and evalution, we can save the model.
Then we can create an inference pipeline for Deployment to get a product that can predict. Starting with preparing, training and testing the API App. As a proof of concept, we did it with Fast API. 
Finally, we work on deploying the API in a package that is portable, scalable, and isolated environment for the ML application, making it truly production-ready. 
Once deployed its important to monitor theperformance of the app.

Sources:
--https://towardsdatascience.com/a-guide-to-21-feature-importance-methods-and-packages-in-machine-learning-with-code-85a841f8b319/
--https://www.geeksforgeeks.org/python/how-to-show-values-on-seaborn-barplot/
--https://www.youtube.com/watch?v=x57vAQdBohQ
--https://github.com/DanilZherebtsov/ml-docker-flask-api
--https://github.com/rara1512/FastAPI-for-ML-models/blob/main/readme.md