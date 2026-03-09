# --- import libraries ---
library(tidyverse)

# --- load data ---
disease_individual <- read.csv("data/processed/state_disease_individual.csv")

# --- explore data ---
head(disease_individual)
summary(disease_individual)

# --- correlation tests ---
disease_cols <- disease_individual %>%
  select(ARTHRITIS:STROKE)
correlations <- sapply(disease_cols, function(x) {
  test <- cor.test(disease_individual$LifeExpectancy, x)
  c(correlation = test$estimate, p_value = test$p.value)
})

# --- rank by strongest correlation ---
cor_df <- data.frame(
  Disease = colnames(disease_cols),
  Correlation = round(as.numeric(correlations[1,]), 3),
  P_Value = as.numeric(correlations[2,])
)

cor_df <- cor_df %>% arrange(Correlation)
print(cor_df)

ggplot(data=cor_df, aes(x = reorder(Disease, abs(Correlation)), y = abs(Correlation))) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Correlation of Individual Disease with Life Expectancy",
    subtitle = "By state, 2022 | Stronger correlation = stronger association with lower LE",
    x = "",
    y = "Correlation Strength (absolute value)"
  )

ggsave("visualizations/q2_disease_correlation_ranking.png", width = 8, height = 6)
