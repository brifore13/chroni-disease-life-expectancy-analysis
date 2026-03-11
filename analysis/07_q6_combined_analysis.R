# --- import library ---
library(tidyverse)
library(broom)

# --- load data ---
combined_categories <- read.csv('data/processed/state_combined_categories.csv')
combined_individual <- read.csv('data/processed/state_combined_individual.csv')
head(combined_categories)
head(combined_individual)

# ============================================================
# CORRELATION TESTS
# ============================================================

# --- 6a: Multiple regression: all categories vs life expectancy ---
model_categories <- lm(LifeExpectancy ~ DiseaseBurden + ScreeningRate + 
                         AccessBarrier + LifestyleRisk + SocialRisk, 
                       data = combined_categories)
summary(model_categories)

# --- Follow-up: What drives disease burden? ---
model_disease_drivers <- lm(DiseaseBurden ~ ScreeningRate + AccessBarrier +
                              LifestyleRisk + SocialRisk, 
                            data = combined_categories)
summary(model_disease_drivers)

# --- 6b: Individual risks impact on life expectancy ---
model_individual <- lm(LifeExpectancy ~ ., data = combined_individual %>% select(-State))
summary(model_individual)

# Social risk vs lifestyle risk
cor.test(combined_categories$SocialRisk, combined_categories$LifestyleRisk)

# Social risk vs access barriers
cor.test(combined_categories$SocialRisk, combined_categories$AccessBarrier)

# Social risk vs screening rate
cor.test(combined_categories$SocialRisk, combined_categories$ScreeningRate)

# ============================================================
# Visualizations
# ============================================================

# --- Coefficient plot: category-level regression ---
model_tidy <- tidy(model_categories) %>%
  filter(term != "(Intercept)") %>%
  mutate(significant = p.value < 0.05)

ggplot(model_tidy, aes(x = reorder(term, abs(estimate)), y = abs(estimate), fill = significant)) +
  geom_col() +
  coord_flip() +
  scale_fill_manual(values = c("TRUE" = "tomato", "FALSE" = "gray70"),
                    labels = c("TRUE" = "Significant (p < 0.05)", 
                               "FALSE" = "Not significant"),
                    name = "") +
  labs(
    title = "Multivariate Predictors of Life Expectancy",
    subtitle = "Coefficient magnitude | Only disease burden is significant when all factors compete",
    x = "",
    y = "Coefficient (absolute value)"
  )
ggsave('visualizations/q6_combined_categories_vs_life_exp.png', width = 8, height = 6)


# --- Causal pathway diagram ---
ggplot() +
  # Labels
  annotate("text", x = 1, y = 4.5, label = "Lifestyle Risk", fontface = "bold", size = 3.6) +
  annotate("text", x = 1, y = 2.5, label = "Social Determinants", fontface = "bold", size = 3.6) +
  annotate("text", x = 1, y = 0.5, label = "Screening / Access", fontface = "bold", size = 3.6) +
  annotate("text", x = 5, y = 2.5, label = "Disease\nBurden", fontface = "bold", size = 4) +
  annotate("text", x = 9, y = 2.5, label = "Life\nExpectancy", fontface = "bold", size = 4) +
  # Arrows
  annotate("segment", x = 2.5, xend = 4, y = 4.5, yend = 2.8, 
           arrow = arrow(length = unit(0.3, "cm")), linewidth = 1) +
  annotate("segment", x = 2.5, xend = 4, y = 2.5, yend = 2.5, 
           arrow = arrow(length = unit(0.3, "cm")), linewidth = 0.5, linetype = "dashed") +
  annotate("segment", x = 2.5, xend = 4, y = 0.5, yend = 2.2, 
           arrow = arrow(length = unit(0.3, "cm")), linewidth = 0.5, linetype = "dashed") +
  annotate("segment", x = 6, xend = 8, y = 2.5, yend = 2.5, 
           arrow = arrow(length = unit(0.3, "cm")), linewidth = 1.5) +
  # Statistics labels under each category
  annotate("text", x = 1, y = 4.0, label = "p < 0.001 ***", size = 3, color = "black") +
  annotate("text", x = 1, y = 1.9, label = "p = 0.90 (NS)", size = 3, color = "gray50") +
  annotate("text", x = 1, y = -0.1, label = "p = 0.22 (NS)", size = 3, color = "gray50") +
  annotate("text", x = 7, y = 2.9, label = "p < 0.001 ***", size = 3, color = "black") +
  annotate("text", x = 7, y = 2.1, label = "R² = 0.83", size = 3, color = "black") +
  # Title
  labs(title = "Causal Pathway: What Drives Life Expectancy?",
       subtitle = "Multivariate regression results | Only significant pathways shown as solid lines") +
  theme_gray() +
  theme(plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
        plot.subtitle = element_text(size = 10, hjust = 0.5, color = "gray40"),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        axis.title = element_blank(),
        panel.grid = element_blank()) +
  xlim(-0.5, 10.5) +
  ylim(-0.5, 5.5)
ggsave("visualizations/q6_causal_pathway.png", width = 10, height = 6)


