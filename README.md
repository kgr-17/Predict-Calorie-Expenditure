# Predict Calorie Expenditure

This repository contains code and analysis for predicting calorie expenditure using synthetic data from the [Kaggle Playground Series S5E5 competition](https://www.kaggle.com/competitions/playground-series-s5e5/overview).

## Repository Structure

```
.
├── data/
│   ├── train.csv
│   ├── test.csv
│   └── sample_submission.csv
├── notebooks/
│   ├── 1_predict_calorie_expenditure_keytel_formula.ipynb
│   ├── 2_eda_and_fe_random_forest_regressor.ipynb
│   └── 3_predict_calorie_expenditure_lightgbm.ipynb
├── Dockerfile
├── docker-compose.yml
├── requirements.txt
├── Predict_Calorie_Expenditure.pdf
└── README.md
```

## Dataset

- **train.csv**: 750,000 samples with 9 columns (`id`, `Sex`, `Age`, `Height`, `Weight`, `Duration`, `Heart_Rate`, `Body_Temp`, `Calories` target)fileciteturn0file0.
- **test.csv**: Same features as `train.csv` without the `Calories` column.
- **sample_submission.csv**: Template for submission with `id` and `Calories` columns.

## Methodology

### 1. Baseline: Keytel Formula

Implemented a closed‑form physiological equation—Keytel formula—to estimate calories per minute, multiplied by duration. Serves as a benchmark with public RMSLE = 0.32672fileciteturn0file0.

### 2. Exploratory Data Analysis & Feature Engineering

- Univariate and bivariate analyses (histograms, boxplots, correlation heatmaps) to understand distributions and relationships.
- Engineered features:
  - `dur_temp`: Duration × Body_Temp (corr ≈ 0.96)
  - `delta_temp`: Body_Temp − 37 (corr ≈ 0.83)
  - K‑Means clusters for Heart Rate (4 zones) and Age (5 bins) to capture non‑linear effectsfileciteturn0file0.

### 3. Random Forest Regressor

- **Model**: `RandomForestRegressor(n_estimators=200, max_depth=10, random_state=42, n_jobs=-1)`
- **Evaluation**: 5‑fold CV with RMSLE = 0.1224 ± 0.0008.

### 4. LightGBM

- **Config**: Objective = `regression`, Metric = `l2` (MSE) for consistency between training and evaluation.
- **Tuning**: Cross‑validation to optimize hyperparameters.

## Results

| Model          | CV RMSLE         |
|----------------|------------------|
| Keytel Formula | 0.32672          |
| Random Forest  | 0.1224 ± 0.0008  |
| LightGBM       | 0.11732 |

## Notebooks

1. [Baseline: Keytel Formula](https://www.kaggle.com/code/yixuliu/predict-calorie-expenditure-keytel-formula)
2. [EDA & Random Forest](https://www.kaggle.com/code/yixuliu/eda-and-fe-random-forest-regressor)
3. [LightGBM Model](https://www.kaggle.com/code/yixuliu/predict-calorie-expenditure-lightgbm)

## Docker Setup

Build and launch the container:

```bash
docker build -t calorie-expender:latest .
docker run --rm -it -v $(pwd)/data:/app/data -p 8888:8888 calorie-expender:latest
```

Or use Docker Compose:

```bash
docker-compose up --build
```

This starts a JupyterLab server at http://localhost:8888.

## Report

The full project report is available here:

- [Predict_Calorie_Expenditure.pdf](Predict_Calorie_Expenditure.pdf) 

## Installation (Local)

Install dependencies from `requirements.txt`:

```bash
pip install -r requirements.txt
``` 
## Usage

1. Clone this repository.
2. Place the `train.csv`, `test.csv`, and `sample_submission.csv` files in the `data/` directory.
3. Open the notebooks in the `notebooks/` folder to reproduce analysis and model training.

## License

This project is released under the MIT License.
