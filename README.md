# AACT Prospective Cancer Trials — SQL Cohort & Patterns

Mini-project using the public **AACT** (Aggregated Analysis of ClinicalTrials.gov) Postgres database.

## What this repo contains
- `sql/01_create_view.sql` – builds a view of **prospective, completed, cancer-related** trials.
- `sql/02_breast_cancer_count.sql` – counts unique **breast cancer** studies.
- `sql/03_intervention_distribution.sql` – distribution of **intervention types**.
- `sql/04_interesting_patterns.sql` – quick text mining for **common terms** and **biomarker hits** (EGFR, HER2, ALK, PD-1/PD-L1, BRCA).

## How to run (pgAdmin)
1. Connect to AACT (provided by CTTI) in pgAdmin.
2. Open `01_create_view.sql` and run it once to create the view.
3. Run each query in `02`, `03`, `04`.  
   - Export results (CSV) and take a screenshot of the grid.

## Results (fill these after you run)
- **Breast cancer studies (distinct NCT IDs):** `TBD`
- **Intervention type distribution (top lines):**
