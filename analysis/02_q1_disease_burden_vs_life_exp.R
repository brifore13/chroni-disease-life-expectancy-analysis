# --- import library ---
library(tidyverse)

# --- load data ---
disease_burden <- read.csv('data/processed/state_disease_burden.csv')

# --- explore data ---
head(disease_burden)
summary(disease_burden)

# --- correlation test ---
cor_result <- cor.test(disease_burden$LifeExpectancy, disease_burden$DiseaseBurden)
cor_result

# --- linear regression ---
model <- lm(LifeExpectancy ~ DiseaseBurden, data=disease_burden)
summary(model)

# --- visualize ---
ggplot(data=disease_burden, aes(DiseaseBurden, LifeExpectancy)) +
  geom_point() + geom_smooth(method="lm") +
  labs(
    title = "State Life Expectancy vs. Average Disease Burden",
    subtitle = "Sources: CDC PLACES 2025, NCHS 2022",
    x = "Average Disease Prevalence(%)",
    y = "Life Expectancy at Birth (years)") +
  scale_y_continuous(limits = c(70, 82), breaks = seq(70, 82, 2)) +
  scale_x_continuous(limits = c(14, 22), breaks = seq(14, 22, 2))

ggsave("visualizations/q1_disease_burden_vs_life_exp.png", width = 8, height = 6)
