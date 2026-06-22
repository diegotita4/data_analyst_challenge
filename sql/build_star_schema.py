import duckdb
from pathlib import Path

PROCESSED_DATA_DIR = Path("../data/processed")

RACE_PATH = str(PROCESSED_DATA_DIR / "race.parquet")
FEATURES_PATH = str(PROCESSED_DATA_DIR / "horse_race_features_final.parquet")

sql = Path("star_schema.sql").read_text()
sql = sql.replace("{RACE_PATH}", RACE_PATH).replace("{FEATURES_PATH}", FEATURES_PATH)

con = duckdb.connect()
con.execute(sql)

for table in ["dim_race", "dim_jockey", "fact_performance"]:
    df = con.sql(f"SELECT * FROM {table}").df()
    df.to_parquet(PROCESSED_DATA_DIR / f"{table}.parquet", index=False)
    print(f"{table}: {df.shape}")