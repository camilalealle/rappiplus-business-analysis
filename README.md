# RappiPlus | Business Performance, Retention & Experimentation

**Python · SQL (PostgreSQL) · Power BI · Statistical Testing**

🌐 **English** · [Español](README_ES.md)

Six months of e-commerce data from Argentina, Colombia and Mexico (January–June 2025), taken from data validation to business recommendations: profitability, customer behavior, conversion funnel, cohort retention and an A/B test.

---

## Contents

1. [Executive Summary](#executive-summary)
2. [Business Questions](#business-questions)
3. [Dashboard](#dashboard)
4. [Key Findings](#key-findings)
5. [Data Quality and Validation](#data-quality-and-validation)
6. [Recommendations](#recommendations)
7. [Methodology](#methodology)
8. [Limitations](#limitations)
9. [Repository Structure](#repository-structure)
10. [How to Run](#how-to-run)
11. [About This Project](#about-this-project)

---

## Executive Summary

- **~60% gross margin, ~30% after marketing.** Estimated gross margin was **60.16%**; after marketing spend, estimated contribution margin fell to **29.77%**. Marketing absorbs about half of gross profit.
- **One product loses money.** Laptop-Gaming-16GB generated an estimated gross loss of **93,621.66** (margin **-8.63%**).
- **Customers come back, but not every month.** **85.54%** of buyers purchased more than once, yet only **37–42%** of each month's buyers purchased again the following month.
- **Sales showed no sustained growth.** Monthly sales were **2.46% lower** in June than in January.
- **The checkout redesign should not be rolled out yet.** The observed uplift (+0.60 pp) was **not statistically significant** (p = 0.4161), and the test only had power to detect effects of about **2 pp**.
- **Data cleaning changed the picture.** 10 extreme-quantity orders accounted for about **81.4% of the recorded amount**; without excluding them, every revenue figure would be distorted.

---

## Business Questions

| # | Question | Answer in |
|---|---|---|
| 1 | Can we trust the data? | [Data Quality and Validation](#data-quality-and-validation) |
| 2 | Are we making money? | [Profitability](#1-profitability-before-and-after-marketing) |
| 3 | Where do users drop off? | [Conversion Funnel](#4-conversion-funnel) |
| 4 | Do users come back? | [Customer Behavior](#3-customer-behavior-and-retention) |
| 5 | Did the product change work? | [A/B Test](#5-ab-test-checkout-redesign) |

---

## Dashboard

### Executive Overview

![RappiPlus Executive Overview](dashboard/Screenshots/executive_overview.png)

### Customer Analytics

![RappiPlus Customer Analytics](dashboard/Screenshots/customer_analytics.png)

📄 [Dashboard PDF](dashboard/RappiPlus%20Dashboard.pdf) · 📊 [Power BI file (.pbix)](dashboard/RappiPlus%20Dashboard.pbix)

---

## Key Findings

### 1. Profitability before and after marketing

| Metric | Value | Margin |
|---|---:|---:|
| Confirmed sales revenue (Jan 1 – Jun 30) | 9,622,281.56 | — |
| Estimated gross profit (Jan 1 – Jun 30) | 5,781,149.93 | 60.16% |
| Marketing spend (Jan 1 – Jun 29) | 2,871,843.53 | — |
| **Estimated contribution after marketing** | **2,813,813.64** | **29.77%** |

*Gross margin uses only sales with available product costs (revenue base: 9,610,018.94). The after-marketing calculation uses a comparable scope: the overlapping period (Jan 1–Jun 29), known countries and channels, and sales with available costs (revenue: 9,450,739.67; gross profit: 5,685,657.17, also 60.16%). It is a descriptive estimate, not attributed campaign profit or net profit. Logistics, fees and other operating costs are not included. All amounts are expressed in a single monetary unit across the three countries, as provided in the dataset.*

### 2. Product profitability

- Vacuum-Pro-Black and Sneakers-Urban-42 generated the highest estimated gross profit.
- **Laptop-Gaming-16GB** was the only product with a gross loss: **-93,621.66** (**-8.63%** margin).
- Four products showed margins above 90%. These figures depend on catalog costs and should be validated before pricing decisions.

### 3. Customer behavior and retention

| Metric | Value |
|---|---:|
| Sales orders | 24,936 |
| Purchasing customers | 7,640 |
| Repeat purchase rate (Jan–Jun) | 85.54% |
| Average orders per customer | 3.26 |
| Orders per customer per active month | 1.29 |
| Revenue per customer per active month | 497.66 |
| Next-month repurchase rate (pooled, Jan–May) | 39.82% (monthly range: 37.25% – 41.99%) |
| Cohort retention (D7–D28 after registration) | 39.82% – 43.98% |

Most customers buy again within the semester, but around 60% of a month's buyers do not purchase in the following month. Retention stayed stable across registration cohorts, with no sign of improvement over time.

### 4. Conversion funnel

The funnel views highlight **checkout and payment as stages worth investigating**, but event counts alone do not confirm where users abandoned their purchases.

| Stage | Users reaching the stage (any order) | Users completing the stages in strict sequence |
|---|---:|---:|
| First visit | 7,796 | 7,796 |
| Select item | 7,582 | 6,728 |
| Add to cart | 7,634 | 4,983 |
| Begin checkout | 7,208 | 2,663 |
| Add payment info | 6,250 | 919 |
| Purchase | 6,240 | 258 (3.31%) |

- In the strict-sequence view, the largest relative drop occurs between payment info and purchase (**-71.93%**).
- In the any-order view, the largest drop occurs between beginning checkout and adding payment info (7,208 → 6,250).
- **3.31% is the strict-sequence completion rate, not the overall sales conversion rate.** Event counts span sessions and dates; a visitor-to-purchaser conversion rate would require a consistent population and time window. See [Data Quality and Validation](#data-quality-and-validation).
- **Purchasers differ by source and definition.** Sales records show **7,640** purchasing customers; event data shows **6,240** users with a *purchase* event, and only **258** who completed every stage in strict order. The funnel describes navigation paths in the event log; the customer metrics above come from sales records.

### 5. A/B test: checkout redesign

| Group | Users | Conversions | Conversion rate |
|---|---:|---:|---:|
| Control | 4,965 | 779 | 15.69% |
| Treatment | 5,035 | 820 | 16.29% |

- Observed uplift: **+0.60 pp** (+3.80% relative).
- Two-sided z-test: **p = 0.4161**; 95% CI: **[-0.84, +2.03] pp**. The interval includes zero.
- No sample ratio mismatch (SRM p = 0.4839).

- **Power:** with ~5,000 users per group (α = 0.05, 80% power), the minimum detectable effect was about **2.0 pp**. Detecting a +0.60 pp uplift would require roughly **58,600 users per group**.

**Decision:** the result is inconclusive, not evidence that the redesign has no effect. Do not roll out based on this test; re-test with a predefined minimum detectable effect and a sample size sized for it.

### 6. Marketing efficiency

- Revenue-to-spend ratios ranged from **3.06 to 3.51** across nine country-channel combinations; paid search ranked highest in all three countries.
- Daily spend and daily sales showed **negligible correlation** (Pearson -0.069 to +0.098).
- These are descriptive indicators, not attribution or ROAS.

---

## Data Quality and Validation

**Issues found and treated**

- 100 duplicate rows removed.
- 610 missing values across eight columns; missing costs were **not** replaced with zero.
- 10 extreme-quantity orders represented about **81.4% of the recorded amount**. They were excluded from the analysis and saved separately for auditing.
- 4 orders with negative quantities treated as possible returns.
- Inconsistent country and category labels standardized; 101 marketing channels and 50 of 80 missing product categories recovered from reference data.

**Inconsistencies flagged for follow-up**

- **New buyers vs. registrations.** The share of first-time buyers *observed in the available orders* falls month after month (see *New vs. Returning Customers* in the dashboard), while registrations remain at 1,444–1,687 users per monthly cohort. A first observed purchase is not necessarily a customer’s first-ever purchase. These sources and definitions must be reconciled before drawing conclusions about acquisition.
- **Event tracking.** More users recorded *add to cart* (7,634) than *select item* (7,582), and fewer users have a *purchase* event (6,240) than appear as buyers in sales records (7,640). This suggests incomplete or inconsistent event tracking.
- **Coverage.** Marketing data ends on June 29, while orders run through June 30. Marketing comparisons use only the overlapping period.

---

## Recommendations

1. **Review Laptop-Gaming-16GB** pricing, discounts and costs, and validate the unusually high margins of other products.
2. **Work on next-month repurchase.** Test retention actions aimed at the ~60% of monthly buyers who do not return the following month.
3. **Investigate checkout and payment friction**, and audit event tracking before using the funnel as a KPI.
4. **Improve marketing measurement** (attribution, customer acquisition cost) before reallocating budget; the estimated contribution calculation is descriptive, not campaign-level attribution.
5. **Re-run the checkout experiment** with a predefined minimum detectable effect and sample size (≈58,600 users per group to detect +0.6 pp, or decide whether a ~2 pp effect is the minimum worth acting on).

---

## Methodology

| Step | Question | Tools | Notebook |
|---|---|---|---|
| 1 | Can we trust the data? | Python, Pandas | [01_data_quality](notebooks/01_data_quality.ipynb) |
| 2 | Prepare clean datasets | Python, Pandas | [02_data_cleaning](notebooks/02_data_cleaning.ipynb) |
| 3 | Are we making money? | Python, Matplotlib | [03_business_analysis](notebooks/03_business_analysis.ipynb) |
| 4 | Where do users drop off? Do they return? | PostgreSQL, SQLAlchemy | [04_sql_analysis](notebooks/04_sql_analysis.ipynb) · [SQL files](sql/) |
| 5 | Did the change work? | SciPy (z-test, chi-square) | [05_ab_testing](notebooks/05_ab_testing.ipynb) |
| 6 | How do we communicate it? | Power BI, DAX | [dashboard](dashboard/) |

The original files are preserved in `data/raw/`, and the cleaned outputs are in `data/processed/`.

---

## Limitations

- The analysis covers six months (January–June 2025). Long-term trends cannot be established.
- Profit estimates exclude sales with missing costs and possible returns. The after-marketing contribution excludes other operating costs and is not net profit.
- Revenue-to-spend ratios and correlations do not establish causality or advertising attribution.
- Cohort retention measures activity on specific days after registration, not continuous activity or repeat purchases. “New” buyers are first observed within the available sales data, not necessarily new historically.
- The project uses an educational dataset, so some patterns may reflect how the data was generated rather than real customer behavior.

---

## Repository Structure

```text
rappiplus-business-analysis/
├── dashboard/        # Power BI file, PDF and screenshots
├── data/
│   ├── raw/          # Original datasets
│   └── processed/    # Cleaned datasets and excluded outliers
├── notebooks/        # 01–05 analysis notebooks
├── sql/              # Funnel and cohort queries
├── .env.example      # Database connection template
├── requirements.txt
├── README.md         # English version
└── README_ES.md      # Spanish version
```

---

## How to Run

<details>
<summary>Setup instructions</summary>

### 1. Clone the repository

```bash
git clone https://github.com/camilalealle/rappiplus-business-analysis.git
cd rappiplus-business-analysis
```

### 2. Create and activate a virtual environment

```bash
python -m venv .venv
```

**Windows (PowerShell):**

```powershell
.\.venv\Scripts\Activate.ps1
```

**macOS / Linux:**

```bash
source .venv/bin/activate
```

### 3. Install dependencies

```bash
python -m pip install -r requirements.txt
```

### 4. Run the notebooks

Open the project in VS Code or Jupyter and select the Python interpreter/kernel from `.venv`.

Run the notebooks in order:

1. `01_data_quality.ipynb`
2. `02_data_cleaning.ipynb`
3. `03_business_analysis.ipynb`
4. `04_sql_analysis.ipynb`
5. `05_ab_testing.ipynb`

**Important:** Run the notebooks with `notebooks/` as the working directory so their relative data paths resolve correctly.

**PostgreSQL:** Notebook `04_sql_analysis.ipynb` requires authorized access to an external PostgreSQL database. Copy `.env.example` to `.env`, add valid connection credentials, and ensure the required tables are accessible. Credentials are not included in the repository. The saved SQL queries and notebook outputs can still be reviewed without a database connection.

Without PostgreSQL access, you can run notebooks 01, 02, 03 and 05 independently.

</details>

---

## About This Project

Developed by **Camila Leal Ledesma** as the final project of the TripleTen Data Analytics program, and extended independently with additional validation, statistical checks and documentation.

[LinkedIn](https://www.linkedin.com/in/camila-leal-ledesma) · [GitHub](https://github.com/camilalealle)