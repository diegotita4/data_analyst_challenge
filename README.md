# Data Analyst Challenge — RAC

Statistical analysis of NYRA thoroughbred racing data (2019 season)
for the Data Analyst Jr. position at RAC.

## What this project does

Takes GPS tracking data, race results, and betting odds from three New
York racetracks (Aqueduct, Belmont, Saratoga) across the full 2019
season and turns them into actionable insights for trainers, vets, and
racing operations.

Four main questions answered:
1. How do horses' positions change during a race, and why?
2. Are pacing strategies significant or coincidental?
3. What factors drive horse fatigue, and which horses should get a
   post-race check?
4. How well does the betting market actually predict outcomes?

## Key findings

- **Pacing strategy matters** (p < 0.001): horses that go out fast and
  fade finish worst on average. Sustained overall speed is the strongest
  strategy of the three profiles identified.
- **Fatigue is explainable**: weight carried, race distance, and track
  condition together explain ~34% of fatigue variation (R² = 0.34).
  Sloppy tracks and heavier loads are the biggest risk factors.
- **320 horses (~2%)** show unusual deceleration patterns relative to
  their own race — flagged as candidates for post-race veterinary review.
- **The betting market works**, but with a systematic bias: implied
  probabilities overstate true win chances due to the track's takeout
  fee. AUC = 0.78, Brier score = 0.102.

## Data source

"Big Data Derby 2022" competition dataset (NYRA / NYTHA, via Kaggle).
Raw CSV files are not included in this repo (tracking table is ~320MB).
Place them in `data/raw/` before running the notebooks.

## Project structure

```
notebooks/
├── 01_eda_data_quality.ipynb        # load, audit, clean
├── 02_feature_engineering.ipynb     # pace, fatigue, position features
└── 03_statistical_validation.ipynb  # clustering, regression, market test
sql/
├── star_schema.sql                  # dimensional model definition
└── build_star_schema.py             # builds Parquet files for Power BI
data/
└── processed/                       # clean Parquet files (model output)
powerbi/
└── data_analyst_challenge.pbix      # 4-page dashboard
```

## How to run

```bash
# 1. Clone and set up environment
git clone https://github.com/diegotita4/data_analyst_challenge.git
cd data_analyst_challenge
python -m venv .venv
source .venv/bin/activate        # macOS / Linux
.venv\Scripts\Activate.ps1       # Windows PowerShell
pip install -r requirements.txt

# 2. Place raw CSV files in data/raw/

# 3. Run notebooks in order (01 → 02 → 03)

# 4. Build the star schema
cd sql
python build_star_schema.py

# 5. Open powerbi/data_analyst_challenge.pbix in Power BI Desktop
```

## Tech stack

Python (pandas, DuckDB, scikit-learn, statsmodels, scipy) · SQL · Power BI

## License

MIT