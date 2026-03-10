-- =====================================================================
-- Q3: Do disease screenings or access to healthcare matter?
-- Analysis of disease burden vs. screening participation by state
-- =====================================================================
-- =====================================================================
-- 3a: Effect of screenings on life expectancy 
-- 3b: Effect of screenings on disease burden
-- 3c: Effect of healthcare access on life expectancy
-- 3d: Effect of healthcare access on disease burden
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
    -- Screenings: ACCESS2, BPMED, CHECKUP, CHOLSCREEN, COLON_SCREEN, DENTAL, MAMMOUSE
    ROUND((COALESCE(BPMED, 0) + COALESCE(CHECKUP, 0) +
    COALESCE(CHOLSCREEN, 0) + COALESCE(COLON_SCREEN, 0) + COALESCE(DENTAL, 0) + COALESCE(MAMMOUSE, 0))
    / NULLIF((CASE WHEN BPMED IS NOT NULL THEN 1 ELSE 0 END +
    CASE WHEN CHECKUP IS NOT NULL THEN 1 ELSE 0 END +
    CASE WHEN CHOLSCREEN IS NOT NULL THEN 1 ELSE 0 END +
    CASE WHEN COLON_SCREEN IS NOT NULL THEN 1 ELSE 0 END +
    CASE WHEN DENTAL IS NOT NULL THEN 1 ELSE 0 END + 
    CASE WHEN MAMMOUSE IS NOT NULL THEN 1 ELSE 0 END), 0), 1) AS ScreeningRate,
    ROUND(ACCESS2, 1) AS AccessBarrier
FROM state_analysis
WHERE DIABETES IS NOT NULL
ORDER BY LifeExpectancy DESC;