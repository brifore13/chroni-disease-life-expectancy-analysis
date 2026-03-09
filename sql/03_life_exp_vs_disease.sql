-- ========================================================
-- Analyze States comparing life expectancy and disease
-- Uses 'state_analysis' table view
-- ========================================================

-- ========================================================
-- 1. State Ranking by life expectancy
-- ========================================================
SELECT State, LifeExpectancy
FROM state_analysis
ORDER BY LifeExpectancy DESC;

-- ========================================================
-- 2. Calculate Average Disease Burden
--      Average All: arthritis, bphigh, cancer, casthma, chd,
--      copd, depression, diabetes, highchol, obesity, stroke
-- ========================================================

SELECT
    State,
    LifeExpectancy,
    -- sum non-null values
    ROUND((COALESCE(ARTHRITIS, 0) + COALESCE(BPHIGH, 0) + COALESCE(CANCER, 0) +
    COALESCE(CASTHMA, 0) + COALESCE(CHD, 0) + COALESCE(COPD, 0) + 
    COALESCE(DEPRESSION, 0) + COALESCE(DIABETES, 0) + COALESCE(HIGHCHOL, 0) +
    COALESCE(OBESITY, 0) + COALESCE(STROKE, 0))
    -- count non-null values 
    / NULLIF((CASE WHEN ARTHRITIS IS NOT NULL THEN 1 ELSE 0 END +
    CASE WHEN BPHIGH IS NOT NULL THEN 1 ELSE 0 END +
    CASE WHEN CANCER IS NOT NULL THEN 1 ELSE 0 END +
    CASE WHEN CASTHMA IS NOT NULL THEN 1 ELSE 0 END +
    CASE WHEN CHD IS NOT NULL THEN 1 ELSE 0 END +
    CASE WHEN COPD IS NOT NULL THEN 1 ELSE 0 END + 
    CASE WHEN DEPRESSION IS NOT NULL THEN 1 ELSE 0 END +
    CASE WHEN DIABETES IS NOT NULL THEN 1 ELSE 0 END +
    CASE WHEN HIGHCHOL IS NOT NULL THEN 1 ELSE 0 END +
    CASE WHEN OBESITY IS NOT NULL THEN 1 ELSE 0 END +
    CASE WHEN STROKE IS NOT NULL THEN 1 ELSE 0 END), 0), 1) AS DiseaseBurden
FROM state_analysis
ORDER BY LifeExpectancy DESC;