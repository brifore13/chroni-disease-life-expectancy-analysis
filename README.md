# The Geography of Chronic Disease and Life Expectancy in America

An analysis of how chronic disease prevalence relates to life expectancy across U.S. counties and states, using CDC PLACES and NCHS data.

## Project Overview
This project examines the relationship between chronic disease burden (diabetes, obesity, high blood pressure, high cholesterol, physical inactivity) and life expectancy at the county and state level across the United States. The goal is to identify geographic patterns, quantify risk factor contributions, and surface insights relevant to public health resource allocation.

## Data Sources
| Dataset | Source | Level | Download |
|---------|--------|-------|----------|
| CDC PLACES (2025 release) | CDC/BRFSS | County | [data.cdc.gov](https://data.cdc.gov/500-Cities-Places/PLACES-County-Data-GIS-Friendly-Format-2024-releas/i46a-9kgh) |
| Life Expectancy by State & Sex (2018-2022) | NCHS | State | [cdc.gov](https://www.cdc.gov/nchs/data-visualization/state-life-expectancy/2022.htm) |
| USALEEP Life Expectancy (2010-2015) | NCHS | Census Tract | [data.cdc.gov](https://data.cdc.gov/National-Center-for-Health-Statistics/U-S-Life-Expectancy-at-Birth-by-State-and-Census-T/5h56-n989) |

> **Note:** Raw data files are not included in this repository due to size. See download links above to reproduce.

## Tools & Technologies

- **SQL** — Data extraction, transformation, and joins
- **R** — Statistical analysis, regression modeling, exploratory data analysis
- **Tableau** — Interactive dashboards ([Tableau Public link coming soon])

## Project Structure
```
├── data/
│   ├── raw/              # Original datasets (not tracked in Git)
│   └── processed/        # Cleaned, joined data ready for analysis
├── sql/
│   └── *.sql             # Data transformation and exploration queries
├── analysis/
│   └── *.Rmd             # R Markdown analysis notebooks
├── visualizations/
│   ├── screenshots/      # Dashboard screenshots for README
│   └── *.twbx            # Tableau workbooks (not tracked)
├── docs/
│   └── data_dictionary.md
└── README.md
```

# Author
Bri Foreman, 2026