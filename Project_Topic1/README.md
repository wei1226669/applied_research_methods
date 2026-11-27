# Topic 1: Green premium of energy-renovated older apartments in Switzerland

All data and Jupyter notebooks of the project. The research questions are in [Topic_1_updated.md](Topic_1_updated.md).

## Run the notebooks in this order

All notebooks read and write files in the folder `Data/` (relative paths, so the folder `Project_Topic1` can be copied or zipped as a whole). They run in the course environment (Python 3.11, `requirements.txt` of the course).

| # | Notebook | What it does | Input (in `Data/`) | Output (in `Data/`) |
|---|---|---|---|---|
| 01 | `01_flatfox_web_api.ipynb` | Queries the flatfox Web API for each listing (attributes e.g. Minergie, net rent). Takes about 7 minutes; the result is already saved, so it only needs to be run again to update the data. | `flatfox_switzerland_rent_apartments_pre1991.csv` | `flatfox_api_attributes.csv` |
| 02 | `02_flatfox_data_preparation.ipynb` | Prepares the flatfox data (regex, missing values, duplicates, years, rent per m², renovation groups, Minergie) | `flatfox_switzerland_rent_apartments_pre1991.csv`, `flatfox_api_attributes.csv` | `flatfox_pre1991_prepared.csv` |
| 03 | `03_immoscout24_data_preparation.ipynb` | Prepares the ImmoScout24 data in the same way | `immoscout24_mieten_400.csv` | `immoscout24_pre1990_prepared.csv` |
| 04 | `04_combine_and_clean.ipynb` | Combines both platforms, removes apartments listed on both, final cleaning (duplicates, missing rents, outliers) | both prepared files | `apartments_pre1990_combined.csv`, `apartments_pre1990_clean.csv` |
| 05 | `05_renovation_details.ipynb` | Finds the renovated parts and energy measures in the descriptions, flags possible new buildings | `apartments_pre1990_clean.csv` | `apartments_pre1990_renovation_details.csv` |
| 06 | `06_open_data_enrichment.ipynb` | Postcode → municipality (swisstopo), joins municipality data (SFSO Regionalporträts 2021), removes new buildings | `apartments_pre1990_renovation_details.csv`, `AMTOVZ_CSV_WGS84.csv`, `municipality_data_with_taxable_income.xlsx` | `apartments_pre1990_enriched.csv` |
| 07 | `07_database_sqlite.ipynb` | Stores the data in a SQLite database (2 tables) and runs SQL queries | `apartments_pre1990_enriched.csv` | `topic1_apartments.db` |
| 07b | `07b_database_postgresql.ipynb` | Optional: the same database in **PostgreSQL** (tables with keys, index, view, SQL queries incl. `FILTER` and window functions) and a check that the data equal the SQLite database. Needs a running PostgreSQL server: run `bash Project_Topic1/setup_postgresql.sh` once in the Codespace terminal. Notebooks 08 and 09 do not depend on it. | `apartments_pre1990_enriched.csv`, `topic1_apartments.db` | PostgreSQL database `topic1` |
| 08 | `08_exploratory_data_analysis.ipynb` | EDA (tables and plots), map, ANOVA, Chi-squared test, correlation analysis | `topic1_apartments.db` | `../map_apartments.html` |
| 09 | `09_models.ipynb` | Multiple linear regression (2 models), random forest and regression tree, R², RMSE, cross-validation, robustness checks, interpretation | `topic1_apartments.db` | – |

## Data sources

| File | Source |
|---|---|
| `flatfox_switzerland_rent_apartments_pre1991.csv` | web scraping of flatfox.ch (rental apartments, Switzerland, built up to 1990), Web Scraper extension |
| `flatfox_api_attributes.csv` | flatfox public Web API (`https://flatfox.ch/api/v1/public-listing/<id>/`) |
| `immoscout24_mieten_400.csv` | web scraping of immoscout24.ch (rental apartments, Switzerland, built up to 1990), Web Scraper extension |
| `AMTOVZ_CSV_WGS84.csv` | swisstopo, *Amtliches Ortschaftenverzeichnis mit Postleitzahl und Perimeter* (open data, data.geo.admin.ch, 26.11.2026) |
| `municipality_data_with_taxable_income.xlsx` | SFSO, *Regionalporträts 2021: Kennzahlen aller Gemeinden* (from the course, Week 9) |
