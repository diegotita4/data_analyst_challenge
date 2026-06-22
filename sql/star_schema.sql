-- Dim_Race: one row per race
CREATE OR REPLACE TABLE dim_race AS
SELECT
    ROW_NUMBER() OVER (ORDER BY track_id, race_date, race_number) AS race_id,
    track_id,
    race_date,
    race_number,
    distance_id,
    course_type,
    track_condition,
    race_type,
    purse,
    post_time
FROM read_parquet('{RACE_PATH}');

-- Dim_Jockey: one row per jockey
CREATE OR REPLACE TABLE dim_jockey AS
SELECT
    ROW_NUMBER() OVER (ORDER BY jockey) AS jockey_id,
    jockey AS jockey_name
FROM (SELECT DISTINCT jockey FROM read_parquet('{FEATURES_PATH}'));

-- Fact_Performance: one row per horse per race
CREATE OR REPLACE TABLE fact_performance AS
SELECT
    r.race_id,
    j.jockey_id,
    f.program_number,
    f.weight_carried,
    f.odds,
    f.implied_prob,
    f.prob_decile,
    f.won,
    f.position_at_finish,
    f.speed_early,
    f.speed_mid,
    f.speed_late,
    f.fatigue_raw,
    f.fatigue_z,
    f.early_position,
    f.late_position,
    f.position_change,
    f.pace_cluster_label
FROM read_parquet('{FEATURES_PATH}') f
JOIN dim_race r
    ON f.track_id = r.track_id AND f.race_date = r.race_date AND f.race_number = r.race_number
JOIN dim_jockey j
    ON f.jockey = j.jockey_name;