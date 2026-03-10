# ---import libraries---
library(tidyverse)

# ---load data---
screening_analysis <- read.csv('data/processed/state_screening_analysis.csv')

# ---explore data---
head(screening_analysis)
summary(screening_analysis)

# -----------------------
# CORRELATION TESTS
# -----------------------

# --- 3a: Screening Rate vs. Life Expectancy
screen_v_le <- cor.test(screening_analysis$LifeExpectancy, screening_analysis$ScreeningRate)
screen_v_le

# --- 3b: Screening Rate vs. Disease Burden
screen_v_disease <- cor.test(screening_analysis$DiseaseBurden, screening_analysis$ScreeningRate)
screen_v_disease

# --- 3c: Access Barrier vs. Life Expectancy
access_v_le <- cor.test(screening_analysis$LifeExpectancy, screening_analysis$AccessBarrier)
access_v_le

# --- 3c: Access Barrier vs. Disease Burden
access_v_disease <- cor.test(screening_analysis$DiseaseBurden, screening_analysis$AccessBarrier)
access_v_disease


ggplot(data=screening_analysis, aes(AccessBarrier, LifeExpectancy)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(
    title = "Healthcare Access Barriers vs. Life Expectancy",
    subtitle = "By state 2022 | r = -0.3, p = 0.036",
    x = "Lack of Health Insurance (%)",
    y = "Life Expectancy at Birth (years)"
  )
ggsave("visualizations/q3_access_vs_life_exp.png", width = 8, height = 6)

