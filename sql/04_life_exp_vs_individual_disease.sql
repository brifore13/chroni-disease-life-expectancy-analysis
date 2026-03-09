-- ========================================================
-- Analyze Life Expectancy by each disease
-- Uses 'state_analysis' table view
-- ========================================================

-- ========================================================
-- 1. Life expectancy by individual disease percentage
-- diseases: arthritis, bphigh, cancer, casthma, chd,
--      copd, depression, diabetes, highchol, obesity, stroke
-- ========================================================

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
    STROKE
FROM state_analysis
WHERE DIABETES IS NOT NULL;
