# =======================================================
# 01 - Initial Data Exploration
# Purpose: Understand structure of each dataset before
#          cleaning, joining, or analyzing
# =======================================================

# --- Load libraries ---
library(tidyverse)

# --- Set file paths ---
places_file <- "data/raw/PLACES__County_Data_(GIS_Friendly_Format),_2025_release_20260306.csv"
life_exp_state_file <- "data/raw/U.S._Life_Expectancy_at_Birth_by_State_and_Census_Tract_-_2010-2015_20260306.csv"
life_exp_sex_2018 <- "data/raw/U.S._State_Life_Expectancy_by_Sex,_2018_20260306.csv"
life_exp_sex_2019 <- "data/raw/U.S._State_Life_Expectancy_by_Sex,_2019_20260306.csv"
life_exp_sex_2020 <- "data/raw/U.S._State_Life_Expectancy_by_Sex,_2020_20260306.csv"
life_exp_sex_2021 <- "data/raw/U.S._State_Life_Expectancy_by_Sex,_2021_20260306.csv"

# =======================================================
# 1. CDC PLACES (County Level)
# =======================================================
places <- read_csv(places_file)

# explore data
cat("PLACES dimensions:", dim(places), "\n")
colnames(places)
head(places)
summary(places)
glimpse(places)

# =======================================================
# 2. USALEEP - Life Expectancy by Census Tract (2010-2015)
# =======================================================
usaleep <- read_csv(life_exp_state_file)

# explore data
cat("USALEEP dimensions:", dim(usaleep), "\n")
colnames(usaleep)
head(usaleep)
summary(usaleep)
glimpse(usaleep)

# =======================================================
# 3. Life Expectancy by State & Sex (2018-2021)
# =======================================================
le_2018 <- read_csv(life_exp_sex_2018)
le_2019 <- read_csv(life_exp_sex_2019)
le_2020 <- read_csv(life_exp_sex_2020)
le_2021 <- read_csv(life_exp_sex_2021)

# explore data
colnames(le_2018)
head(le_2018)
unique(le_2019$Sex)
glimpse(le_2020)
