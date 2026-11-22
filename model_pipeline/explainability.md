Feature importance tools
We are using Embedded methods for reducing the model's features by identifying the most informative features. 
Both algorithms used use embedded methods so they have the built-in ability to compute feature importances or select features.
- LightGBM unique features are (a) its ability to filter out data instances with small gradients and focus on more critical instances, (b) 'Exclusive Feature Bundling'(EFB): _LightGB_M reduces the number of features by bundling mutually exclusive features (those that very infrequently are non-zero at the same time). 
- XGBoost can effectively use all available CPU cores or clusters to create the tree in parallel. It also utilizes cache optimization.

We don't implement any additional feature importance tools.