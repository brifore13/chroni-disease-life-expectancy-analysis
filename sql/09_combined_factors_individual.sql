-- =====================================================================
-- Q6: What factors impact life expectancy the strongest?
-- Analysis of multifactorial variables vs. life expectancy
-- =====================================================================
-- =====================================================================
-- 6b: Which individuals factors impact life expectancy the strongest?
-- =====================================================================

SELECT
    State,
    LifeExpectancy,
    ARTHRITIS,
    BPHIGH,
    CANCER,
    CASTHMA,
    CHD,
    COPD,
    DEPRESSION,
    DIABETES,
    HIGHCHOL,
    OBESITY,
    STROKE,
    BINGE,
    CSMOKING,
    LPA,
    SLEEP,
    ACCESS2,
    BPMED,
    CHECKUP,
    CHOLSCREEN,
    COLON_SCREEN,
    DENTAL,
    MAMMOUSE,
    LONELINESS,
    FOODSTAMP,
    FOODINSECU,
    HOUSINSECU,
    SHUTUTILITY,
    LACKTRPT,
    EMOTIONSPT
FROM state_analysis
WHERE DIABETES IS NOT NULL
ORDER BY LifeExpectancy DESC;