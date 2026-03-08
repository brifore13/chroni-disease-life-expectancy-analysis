-- ============================================================
-- 01 - Create Clean Tables
-- Purpose: Convert raw CSV imports into properly typed tables
-- All measure columns are age-adjusted prevalence (%)
-- Original column names: [MEASURE]_AdjPrev
-- Renamed to: [MEASURE] for readability
-- Empty strings converted to NULL
-- ============================================================
-- Drop existing clean tables if they exist
DROP TABLE IF EXISTS places_clean;
DROP TABLE IF EXISTS life_exp_clean;
DROP TABLE IF EXISTS usaleep_clean;
-- ============================================================
-- PLACES: County-level chronic disease & health measures
-- ============================================================
CREATE TABLE places_clean AS
SELECT
  StateAbbr,
  StateDesc,
  CountyName,
  CountyFIPS,
  CAST(NULLIF(TotalPopulation, '') AS INTEGER) AS TotalPopulation,
  CAST(NULLIF(TotalPop18plus, '') AS INTEGER) AS TotalPop18plus,

  -- Health Outcomes (Diseases)
  CAST(NULLIF(ARTHRITIS_AdjPrev, '') AS REAL) AS ARTHRITIS,
  CAST(NULLIF(BPHIGH_AdjPrev, '') AS REAL) AS BPHIGH,
  CAST(NULLIF(CANCER_AdjPrev, '') AS REAL) AS CANCER,
  CAST(NULLIF(CASTHMA_AdjPrev, '') AS REAL) AS CASTHMA,
  CAST(NULLIF(CHD_AdjPrev, '') AS REAL) AS CHD,
  CAST(NULLIF(COPD_AdjPrev, '') AS REAL) AS COPD,
  CAST(NULLIF(DEPRESSION_AdjPrev, '') AS REAL) AS DEPRESSION,
  CAST(NULLIF(DIABETES_AdjPrev, '') AS REAL) AS DIABETES,
  CAST(NULLIF(HIGHCHOL_AdjPrev, '') AS REAL) AS HIGHCHOL,
  CAST(NULLIF(OBESITY_AdjPrev, '') AS REAL) AS OBESITY,
  CAST(NULLIF(STROKE_AdjPrev, '') AS REAL) AS STROKE,

  -- Lifestyle Risk Factors
  CAST(NULLIF(BINGE_AdjPrev, '') AS REAL) AS BINGE,
  CAST(NULLIF(CSMOKING_AdjPrev, '') AS REAL) AS CSMOKING,
  CAST(NULLIF(LPA_AdjPrev, '') AS REAL) AS LPA,
  CAST(NULLIF(SLEEP_AdjPrev, '') AS REAL) AS SLEEP,

  -- Screening & Prevention
  CAST(NULLIF(ACCESS2_AdjPrev, '') AS REAL) AS ACCESS2,
  CAST(NULLIF(BPMED_AdjPrev, '') AS REAL) AS BPMED,
  CAST(NULLIF(CHECKUP_AdjPrev, '') AS REAL) AS CHECKUP,
  CAST(NULLIF(CHOLSCREEN_AdjPrev, '') AS REAL) AS CHOLSCREEN,
  CAST(NULLIF(COLON_SCREEN_AdjPrev, '') AS REAL) AS COLON_SCREEN,
  CAST(NULLIF(DENTAL_AdjPrev, '') AS REAL) AS DENTAL,
  CAST(NULLIF(MAMMOUSE_AdjPrev, '') AS REAL) AS MAMMOUSE,

  -- Health Status
  CAST(NULLIF(GHLTH_AdjPrev, '') AS REAL) AS GHLTH,
  CAST(NULLIF(MHLTH_AdjPrev, '') AS REAL) AS MHLTH,
  CAST(NULLIF(PHLTH_AdjPrev, '') AS REAL) AS PHLTH,

  -- Disabilities
  CAST(NULLIF(HEARING_AdjPrev, '') AS REAL) AS HEARING,
  CAST(NULLIF(VISION_AdjPrev, '') AS REAL) AS VISION,
  CAST(NULLIF(COGNITION_AdjPrev, '') AS REAL) AS COGNITION,
  CAST(NULLIF(MOBILITY_AdjPrev, '') AS REAL) AS MOBILITY,
  CAST(NULLIF(SELFCARE_AdjPrev, '') AS REAL) AS SELFCARE,
  CAST(NULLIF(INDEPLIVE_AdjPrev, '') AS REAL) AS INDEPLIVE,
  CAST(NULLIF(DISABILITY_AdjPrev, '') AS REAL) AS DISABILITY,
  CAST(NULLIF(TEETHLOST_AdjPrev, '') AS REAL) AS TEETHLOST,

  -- Social Determinants
  CAST(NULLIF(LONELINESS_AdjPrev, '') AS REAL) AS LONELINESS,
  CAST(NULLIF(FOODSTAMP_AdjPrev, '') AS REAL) AS FOODSTAMP,
  CAST(NULLIF(FOODINSECU_AdjPrev, '') AS REAL) AS FOODINSECU,
  CAST(NULLIF(HOUSINSECU_AdjPrev, '') AS REAL) AS HOUSINSECU,
  CAST(NULLIF(SHUTUTILITY_AdjPrev, '') AS REAL) AS SHUTUTILITY,
  CAST(NULLIF(LACKTRPT_AdjPrev, '') AS REAL) AS LACKTRPT,
  CAST(NULLIF(EMOTIONSPT_AdjPrev, '') AS REAL) AS EMOTIONSPT

FROM places_county;    

-- ============================================================
-- Life Expectancy by State & Sex (2018-2021 combined)
-- ============================================================

CREATE TABLE life_exp_clean AS
SELECT
    State,
    Sex,
    CAST(NULLIF(LEB, '') AS REAL) AS LifeExpectancy,
    CAST(NULLIF(SE, '') AS REAL) AS StandardError,
    NULLIF(Quartile, '') AS Quartile,
    2018 AS Year
FROM life_exp_2018
WHERE State != 'United States'

UNION ALL

SELECT
    State,
    Sex,
    CAST(NULLIF(LEB, '') AS REAL) AS LifeExpectancy,
    CAST(NULLIF(SE, '') AS REAL) AS StandardError,
    NULLIF(Quartile, '') AS Quartile,
    2019 AS Year
FROM life_exp_2019
WHERE State != 'United States'

UNION ALL

SELECT
    State,
    Sex,
    CAST(NULLIF(LE, '') AS REAL) AS LifeExpectancy,
    CAST(NULLIF(SE, '') AS REAL) AS StandardError,
    NULLIF(Quartile, '') AS Quartile,
    2020 AS Year
FROM life_exp_2020
WHERE State != 'United States'

UNION ALL

SELECT
    State,
    Sex,
    CAST(NULLIF(LE, '') AS REAL) AS LifeExpectancy,
    CAST(NULLIF(SE, '') AS REAL) AS StandardError,
    NULLIF(Quartile, '') AS Quartile,
    2021 AS Year
FROM life_exp_2021
WHERE State != 'United States';

-- ============================================================
-- USALEEP: Census Tract Life Expectancy (2010-2015)
-- ============================================================

CREATE TABLE usaleep_clean AS
SELECT
    State,
    County,
    "Census Tract Number" AS CensusTract,
    CAST(NULLIF("Life Expectancy", '') AS REAL) AS LifeExpectancy,
    NULLIF("Life Expectancy Range", '') AS LifeExpRange,
    CAST(NULLIF("Life Expectancy Standard Error", '') AS REAL) AS LifeExpSE
FROM usaleep;