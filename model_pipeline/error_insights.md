When and why the model fails:
- Algorithmm limitations:
Compared to LightGBM, XGBoost grows trees depth-wise (level-wise), while LightGBM grows trees leaf-wise. This makes XGBoost less efficient with large datasets.
- Organization limitations:
If there is no well-defined success criteria, the project could keep on going in loops because ML is an iterative process.

If the data is not reliable or is not up to date, it could result in unaccurate predictions.