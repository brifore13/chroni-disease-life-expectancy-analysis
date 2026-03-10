-- =====================================================================
-- Analysis of top 10 vs. bottom 10 states by life expectancy
-- =====================================================================

-- TOP 10 States by Life Expectancy
SELECT 
    State, 
    LifeExpectancy, 
    ,
    'Top 10' AS GroupLabel
FROM state_analysis
WHERE DIABETES IS NOT NULL
ORDER BY LifeExpectancy DESC
LIMIT 10;

-- BOTTOM 10 States by Life Expectancy
SELECT State, LifeExpectancy, 'Bottom 10' AS GroupLabel
FROM state_analysis
WHERE DIABETES IS NOT NULL
ORDER BY LifeExpectancy ASC
LIMIT 10;