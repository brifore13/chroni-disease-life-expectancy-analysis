-- =====================================================================
-- Q3: Does lifestyle matter?
-- Analysis of disease burden vs. lifestyle risk factors
-- =====================================================================
-- =====================================================================
-- 4a: Effect of lifestyle on life expectancy
-- 4b: Effect of lifestyle on disease burden
-- =====================================================================

SELECT
    State,
    LifeExpectancy,
    -- DiseaseBurden: Average weighted disease burden by population
    ROUND((COALESCE(ARTHRITIS, 0) + COALESCE(BPHIGH, 0) + COALESCE(CANCER, 0) +
    COALESCE(CASTHMA, 0) + COALESCE(CHD, 0) + COALESCE(COPD, 0) + 
    COALESCE(DEPRESSION, 0) + COALESCE(DIABETES, 0) + COALESCE(HIGHCHOL, 0) +
    COALESCE(OBESITY, 0) + COALESCE(STROKE, 0))
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
    CASE WHEN STROKE IS NOT NULL THEN 1 ELSE 0 END), 0), 1) AS DiseaseBurden,
    -- Lifestyle risk factors: BINGE, CSMOKING, LPA, SLEEP
    ROUND((COALESCE(BINGE, 0) + COALESCE(CSMOKING, 0) +
    COALESCE(LPA, 0) + COALESCE(SLEEP, 0)) 
    / NULLIF((CASE WHEN BINGE IS NOT NULL THEN 1 ELSE 0 END +
    CASE WHEN CSMOKING IS NOT NULL THEN 1 ELSE 0 END +
    CASE WHEN LPA IS NOT NULL THEN 1 ELSE 0 END +
    CASE WHEN SLEEP IS NOT NULL THEN 1 ELSE 0 END), 0), 1) AS LifestyleRisk,
    BINGE,
    CSMOKING,
    LPA,
    SLEEP
FROM state_analysis
WHERE DIABETES IS NOT NULL
ORDER BY LifeExpectancy DESC;