# Topic 1: Green premium of energy-renovated older apartments in Switzerland

*Updated version (26.11.2026). Changes compared with the first version: Switzerland instead of the canton of Zurich, two data sources (flatfox and ImmoScout24), two sub-questions on the type of renovation, floor removed from the controls.*

## Task 1: Business objectives and hypotheses

### 1. Problem definition

- Many rental apartments in Switzerland are in older buildings that do not meet current energy standards.
- Energy renovations are expensive. Owners and investors lack evidence on whether tenants pay higher rents after an energy renovation.
- Energy renovations are often carried out together with other renovations (new kitchen, new bathroom). A simple comparison of renovated and non-renovated apartments cannot show whether a higher rent is paid for the energy measures or for the new interior.
- Without this evidence, renovation decisions are hard to justify, both for the owner and for banks offering green renovation loans.

### 2. Objective

- Build a rent prediction model (hedonic pricing model) for rental apartments in buildings built before 1990 in Switzerland.
- Use the model to estimate the rent premium of energy-renovated apartments compared with non-renovated apartments.
- Separate the effect of energy measures from the effect of other renovated parts (kitchen, bathroom, floors, complete renovation).

### 3. Research questions

**Main research question:**
Among rental apartments in buildings built before 1990 in Switzerland, how much higher is the net rent per m² of energy-renovated apartments compared with non-renovated apartments, controlling for living area, number of rooms, building age and municipality characteristics?

**Sub-question 1:**
Is the rent premium of an energy renovation higher than the rent premium of a general (non-energy) renovation?

**Sub-question 2:**
Which renovated parts are associated with a higher net rent per m²: complete renovation, kitchen, bathroom, floors, or energy measures (windows, heating, insulation, roof, solar)?

### 4. Hypotheses

- **H0 (main):** There is no difference in net rent per m² between energy-renovated and non-renovated older apartments.
- **H1 (main):** Energy-renovated older apartments have a significantly higher net rent per m² than non-renovated older apartments.
- **H0 (sub-question 1):** The rent premium of an energy renovation is equal to the rent premium of a general renovation.
- **H1 (sub-question 1):** The rent premium of an energy renovation is different from the rent premium of a general renovation.
- **H0 (sub-question 2):** Energy measures are not associated with net rent per m² when the renovated interior parts are controlled for.
- **H1 (sub-question 2):** Energy measures are associated with a higher net rent per m² when the renovated interior parts are controlled for.

### 5. Expected added value of the data analysis

- **Owners and asset managers:** compare the estimated extra rent with the cost of an energy renovation to support renovation (capex) decisions, and see which renovated parts pay off.
- **Banks:** evidence for pricing green renovation loans and for climate-risk assessment of mortgage portfolios.
- **Valuation:** renovation status and renovated parts as measurable value drivers in rent and property valuation models.
- **Policy:** shows whether the market rewards energy renovation.

## Task 2: Suitable data and data sources

### 1. Apartment listings: flatfox.ch and ImmoScout24.ch (Switzerland, rental apartments, buildings built before 1990)

- Data collection: web scraping of both platforms; flatfox public Web API for listing attributes (e.g. Minergie) and net rent.
- Apartments advertised on both platforms are kept only once (same postcode, rooms, living area, gross rent and construction year).
- **Target variable:** net rent per m² (net rent / living area). Gross rent per m² is used as a robustness check.
- **Apartment characteristics:** living area (m²), number of rooms, furnished / temporary listing.
- **Location:** postcode and locality (street for ImmoScout24).
- **Building age and renovation:** year built and year renovated.
- **Description text:** used to identify the renovation group and the renovated parts with keywords.

### 2. Renovation groups and renovated parts (built from the listing data)

- **Not renovated:** no renovation year and no renovation keywords.
- **General renovation:** e.g. "renoviert", "neue Küche", "neues Bad", or a renovation year.
- **Energy renovation:** e.g. "energetisch saniert", "Minergie", "Wärmepumpe", "neue Fenster", "Fassade".
- **Renovated parts:** complete renovation, kitchen, bathroom, floors, paint; energy measures: windows, heating, insulation/facade, roof, solar, Minergie.
- Listings that are probably new buildings ("Neubau", "appartements neufs") are excluded.

### 3. Municipality-level data: SFSO "Regionalporträts 2021: Kennzahlen aller Gemeinden"

- Sheet `data_for_import`: population, population density, share of foreigners, employment, mean taxable income.
- Used as control variables for location quality and purchasing power.
- Combined with the listings by BFS municipality number, using the official postcode directory of swisstopo ("Amtliches Ortschaftenverzeichnis", postcode → municipality, with coordinates).

### 4. Possible extension: Federal Register of Buildings and Dwellings (GWR)

- Construction year and heating system per building, matched by address.
- Fills in missing year built and identifies buildings with heat pumps.

## Methods (overview)

- Data storage: SQLite database with SQL queries from Python.
- Exploratory data analysis: summary statistics, cross tables, histograms, boxplots, scatterplots, correlation matrix, map of the apartments.
- Statistical tests: ANOVA (net rent per m² by renovation group), Chi-squared test (renovation group × language region), correlation analysis (with p-values).
- Models: multiple linear regression (main model and model with renovated parts) and random forest regression; evaluation with R² and RMSE on a test sample.

## Limitations

- Listing rents are asking rents, not contract rents.
- Listings do not always describe the renovation type (many say only "renoviert"), so some apartments may be assigned to the wrong group or have unknown renovated parts.
- The group of energy-renovated apartments is small (about 40–45 apartments), so the estimated premium is uncertain.
- The floor is not available for flatfox listings and is therefore not used as a control variable.
- The analysis shows a correlation, not a causal effect.
