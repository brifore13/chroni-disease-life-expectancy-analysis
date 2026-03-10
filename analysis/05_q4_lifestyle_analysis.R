# --- import library ---
library(tidyverse)

# --- load data ---
lifestyle_analysis <- read.csv('data/processed/state_lifestyle_analysis.csv')

# --- explore data ---
head(lifestyle_analysis)
summary(lifestyle_analysis)

# -----------------------
# CORRELATION TESTS
# -----------------------

# --- 4a: Lifestyle Risk vs. Life Expectancy
lifestyle_v_le <- cor.test(lifestyle_analysis$LifeExpectancy, lifestyle_analysis$LifestyleRisk)
lifestyle_v_le

# --- 4b: Lifestyle Risk vs. Disease Burden
lifestyle_v_disease <- cor.test(lifestyle_analysis$DiseaseBurden, lifestyle_analysis$LifestyleRisk)
lifestyle_v_disease

# --- 4c: Correlation Strength of Lifestyle Risk Factors
lifestyle_cols <- lifestyle_analysis %>%
  select(BINGE:SLEEP)
correlations <- sapply(lifestyle_cols, function(x) {
  test <- cor.test(lifestyle_analysis$LifeExpectancy, x)
  c(correlation = test$estimate, p_value = test$p.value)
})
cor_df <- tibble(
  RiskFactor = colnames(lifestyle_cols),
  Correlation = round(as.numeric(correlations[1,]), 3),
  P_value = as.numeric(correlations[2,])
)
cor_df

# --- plot correlation strength
ggplot(data=cor_df, aes(x = reorder(RiskFactor, abs(Correlation)), y = abs(Correlation), fill = Correlation > 0)) +
  geom_col() +
  coord_flip() +
  scale_fill_manual(values = c("TRUE" = "steelblue", "FALSE" = "tomato"),
                    labels = c("TRUE" = "Positive", 
                               "FALSE" = "Negative"),
                    name = "Direction") +
  labs(
    title = "Lifestyle Risk Factors vs. Life Expectancy",
    subtitle = "By state 2022 | correlation strength with life expectancy",
    x = "",
    y = "Correlation Strength (absolute value)"
  )

ggsave('visualizations/q4_lifestyle_vs_life_exp.png', width = 8, height = 6)












