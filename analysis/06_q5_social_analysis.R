# --- import libraries ---
library(tidyverse)

# --- load data ---
social_analysis <- read.csv('data/processed/state_social_analysis.csv')

# --- explore data ---
head(social_analysis)
summary(social_analysis)

# -----------------------
# CORRELATION TESTS
# -----------------------

# --- 5a: Social Determinants vs. Life Expectancy
social_v_le <- cor.test(social_analysis$LifeExpectancy, social_analysis$SocialRisk)
social_v_le

# --- 5b: Social Determinants vs. Disease Burden
social_v_disease <- cor.test(social_analysis$DiseaseBurden, social_analysis$SocialRisk)
social_v_disease

# --- 5c: Correlation Strength of Social Determinants
social_cols <- social_analysis %>%
  select(LONELINESS:EMOTIONSPT)
correlations <- sapply(social_cols, function(x) {
  test <- cor.test(social_analysis$LifeExpectancy, x)
  c(correlation = test$estimate, p_value = test$p.value)
})
cor_df <- tibble(
  RiskFactor = colnames(social_cols),
  Correlation = round(as.numeric(correlations[1,]), 3),
  P_value = as.numeric(correlations[2,])
)
cor_df

ggplot(cor_df, aes(x = reorder(RiskFactor, abs(Correlation)), y = abs(Correlation))) +
  geom_col(fill = "tomato") +
  coord_flip() +
  labs(
    title = "Social Determinants vs. Life Expectancy",
    subtitle = "By state, 2022 | Correlation strength with life expectancy",
    x = "",
    y = "Correlation Strength (absolute value)"
  )

ggsave('visualizations/q5_social_vs_life_exp.png', width = 8, height = 6)







