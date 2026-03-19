# 📊 Superstore Analytics — End-to-End Data Analytics Project

![SQL](https://img.shields.io/badge/MySQL-Star_Schema-blue?style=flat-square)
![Python](https://img.shields.io/badge/Python-Pandas_·_Seaborn-green?style=flat-square)
![PowerBI](https://img.shields.io/badge/Power_BI-5_Page_Dashboard-orange?style=flat-square)
![Dataset](https://img.shields.io/badge/Dataset-Kaggle_Superstore-lightgrey?style=flat-square)

> A full-stack data analytics project on global retail data (2011–2014) — from raw CSV ingestion through SQL Star Schema design and Python EDA, to a 5-page interactive Power BI dashboard with actionable business insights.

---

## 🚀 Key Highlights
*A quick summary of the project, tools, and key business impact.*

- Built a **complete end-to-end pipeline**: CSV → SQL Star Schema → Python → Power BI
- Designed a **relational data model** with 1 fact table + 3 dimension tables
- Identified critical **25% discount threshold** — crossing it causes direct profit losses
- Quantified **$100K+ annual profit loss** from returns — traced to Furniture & Central region
- Flagged **9,312 late shipments** causing measurable profitability drag in operations
- Developed a **5-page interactive Power BI dashboard** with DAX measures & drill-down filters
- Wrote **7 modular SQL scripts + 7 Python notebooks** — one per analytical domain
- Engineered **YoY & MoM profit trend features** — confirmed 51.54% year-over-year growth

---

## 📈 Business KPIs at a Glance

| Metric | Value |
|---|---|
| Total Sales | $12.64M |
| Total Profit | $1.47M |
| Profit Margin | 11.61% |
| Total Orders | 25K+ |
| Total Customers | 1,590 |
| Return Rate | 4.68% |

---

## 💼 Business Value
*Translating data into decisions that directly impact the bottom line.*

| What It Enables | How |
|---|---|
| **Identify profit leakage** | Pinpoint exactly which products, regions, and discount levels are destroying margin |
| **Optimise discount strategy** | Enforce data-backed pricing rules that eliminate loss-making orders at the source |
| **Improve operational efficiency** | Reduce late shipments and return costs that quietly erode profit every quarter |
| **Drive data-based decisions** | Replace gut-feel pricing and logistics calls with evidence from 25K+ order records |

---

## 🔧 Project Pipeline

### Stage 01 — SQL (Data Engineering & Analysis)
- Imported raw Kaggle CSV into MySQL as `orders_raw`
- Designed a **Star Schema** (1 fact + 3 dimension tables)
- Wrote 8 modular query scripts covering all analytical domains
- **Tools:** MySQL, DDL/DML, Joins, CTEs, Aggregations

### Stage 02 — Python (Visualisation & Feature Engineering)
- Connected MySQL to Python via **SQLAlchemy**
- Built 7 dedicated Jupyter notebooks mirroring SQL query structure
- Engineered **YoY & MoM profit trend** features for time-series analysis
- **Tools:** Pandas, SQLAlchemy, Matplotlib, Seaborn, Jupyter

### Stage 03 — Power BI (Interactive Dashboard)
- Imported the Star Schema directly into Power BI
- Built a `dates` dimension table from `order_date` (Month, Year columns)
- Created **DAX measures** for all KPIs across 5 interactive dashboard pages
- **Tools:** Power BI, DAX, Power Query, Bing Maps

---

## 🧠 Design Decisions
*Intentional architectural choices — not just execution, but thinking like a data professional.*

| Decision | Why |
|---|---|
| **Star Schema** over flat table | Better query performance, reduced redundancy, and scalable for Power BI relationships |
| **Modular SQL scripts** per domain | Each script is independently readable, testable, and maintainable — not one monolithic file |
| **SQL queries reused in Python** via SQLAlchemy | Ensures the visualisation layer always stays consistent with the database logic |
| **Date dimension table** in Power BI | Enables proper time-series filtering and time intelligence DAX functions |

---

## 🗄️ Database Schema (Star Schema)

```
          ┌──────────────┐                    ┌─────────────┐
          │   Products   │                    │   Returns   │
          │──────────────│                    │─────────────│
          │ product_id PK│                    │ return_id PK│
          │ product_name │                    │ returned    │
          │ category     │                    └──────┬──────┘
          │ sub_category │                           │ 1:N
          └──────┬───────┘                           │
                 │ 1:N              ┌────────────────▼───────────────┐
                 └─────────────────►│          orders (FACT)          │
                                    │────────────────────────────────│
          ┌──────────────┐          │ order_id      (PK)             │
          │  Customers   │          │ product_id    (FK)             │
          │──────────────│          │ customer_id   (FK)             │
          │ customer_id  ├─────────►│ return_id     (FK)             │
          │ customer_name│          │ order_date  · ship_date        │
          │ segment      │          │ sales · profit · discount      │
          │ region       │          │ quantity · shipping_cost       │
          └──────────────┘          │ ship_mode                      │
                                    └────────────────────────────────┘
          ┌──────────────┐
          │  Dates(PBI)  │ ← Built in Power BI from order_date
          │──────────────│
          │ order_date PK│
          │ month · year │
          └──────────────┘
```

---

## 📓 Analysis Modules
*Each domain has a paired SQL script and Python notebook — modular and independently runnable.*

| # | Module | Key Output |
|---|---|---|
| 1.1 | Exploratory Data Analysis | Correlation matrix, distribution analysis, data cleaning. Profit–discount correlation of –0.32; sales highly right-skewed |
| 1.2 | Sales & Profit Analysis | YoY & MoM trend engineering. Confirmed 51.54% YoY growth. Technology = highest margin; Furniture = lowest |
| 1.3 | Regional & Geographic Analysis | Central region leads volume. Canada = highest profit margin %. Southeast Asia & EMEA show high sales but near-zero margin |
| 1.4 | Customer Segment Analysis | Consumer segment drives most revenue. Identified top-value customers and flagged loss-generating accounts for review |
| 1.5 | Discount & Profitability Analysis | Defined the **25% discount breakeven threshold**. Discounts above this consistently generate losses — enforcing this limit can significantly improve overall margins |
| 1.6 | Return Analysis | 4.68% return rate eroding $800K+ in sales and $100K+ in profit. Furniture has the highest return rate (6%) — addressing it would directly protect annual profitability |
| 1.7 | Shipping & Operations Analysis | 9,312 late shipments (>5 days). Standard Class drives $7.6M in sales. Reducing late orders in the Central region would meaningfully improve total profit |

---

## 📊 Dashboard Preview
*5-page interactive Power BI dashboard with DAX measures, cross-page slicers, and drill-down capabilities.*

### 1. Business Performance Overview
> Sales trend 2011–2014, category breakdown, return rates, segment comparison.

![Business Performance Overview](images/1_overview.png)

---

### 2. Product & Profitability
> Top products by sales & profit, discount bucket analysis, sub-category margins.

![Product & Profitability](images/2_product_profit.png)

---

### 3. Customer Behavior Analysis
> Segment revenue, top customers by profit and sales, avg orders per customer.

![Customer Behavior Analysis](images/3_customer.png)

---

### 4. Regional & Operational Performance
> World map, regional sales vs profit, shipping costs, return rates by region.

![Regional & Operational Performance](images/4_regional.png)

---

### 5. Loss & Risk Analysis
> 13K loss orders, $920.7K total loss, discount impact, return loss by category.

![Loss & Risk Analysis](images/5_loss_making.png)

---

## ⚠️ Key Business Problems Identified

- 📉 **Over-discounting causing negative margins** — discounts regularly exceed the 25% loss threshold, especially in Furniture where Tables average ~30% discount
- 🗑️ **Loss-making products still actively sold** — items like Tables and select Furniture lines generate consistent losses per order due to over-discounting
- 🔁 **High return cost in Furniture** — 6% return rate eroding $100K+ in annual profit, concentrated in the Central region
- ⏰ **9,312 late shipments reducing profitability** — delayed orders show measurably lower profit vs on-time fulfilment, worst in the Central region
- 🌍 **Regional inefficiencies** — Southeast Asia & EMEA generate high revenue but near-zero margins due to discount and logistics costs
- 👤 **Unprofitable customer accounts** — certain high-volume customers generate net losses for the business due to uncapped discount usage

---

## 💡 Key Findings

**1. Steady Revenue Growth — $2.3M → $4.3M (2011–2014)**
Consistent 4-year expansion at 51.54% YoY growth, with a predictable and sharp November–December seasonal peak each year.

**2. Technology Leads; Furniture Bleeds**
Technology is the highest-margin category. Furniture generates $4.7M in sales but has the weakest margins — damaged by aggressive discounting and a 6% return rate that together erode profitability.

**3. 25% Discount = The Loss Threshold**
Discounts above 25% consistently generate negative profit margins — enforcing this threshold across all product lines can eliminate loss-making orders and significantly improve overall profitability.

**4. Southeast Asia & EMEA — Profit Gap**
Both regions show high sales volume but near-zero margins. Driven by above-average discount rates and elevated shipping costs — high revenue here is a liability, not an asset, without cost restructuring.

**5. Returns Cost $100K+ in Annual Profit**
A 4.68% return rate has eroded $800K+ in sales. Furniture's 6% return rate is the highest category — reducing it through better product descriptions and packaging would directly protect annual profit.

**6. 9,312 Late Shipments Drain Profitability**
Late orders (>5 days) generate measurably lower profit than on-time orders. The problem is concentrated in the Central region — the busiest market, most operationally strained.

---

## ✅ Business Recommendations

**1. 🚫 Enforce a Hard 25% Discount Cap**
Tables average ~30% discount; select items reach 70–80% — all sold at a direct loss. A system-wide ceiling at 25% would eliminate loss-making orders and recover significant margin, especially in Furniture.

**2. 🌏 Fix SE Asia & EMEA Unit Economics**
High sales with near-zero margins is a liability, not growth. A discount and logistics cost review must happen before scaling these regions further.

**3. 📦 Reduce Furniture Return Rate**
At 6%, Furniture's return rate is the highest category and most recoverable. Improving product descriptions, packaging, and large-item shipping quality could recover a significant share of the $100K+ annual return loss.

**4. ⏱️ Fix Late Shipments in the Central Region**
Invest in Central region fulfilment capacity. Pre-position inventory before Q4 peaks. Late orders directly reduce per-order profit at the company's highest-volume, highest-risk market.

**5. 🎯 Audit Loss-Generating Customer Accounts**
High sales, negative profit customers should have discount access reviewed individually. The issue is uncapped discounting — not the customers. Fixing the pricing agreements protects margin without losing the relationship.

---

## 📌 Sample SQL Queries

**Sales & Profit by Category**
```sql
SELECT p.category,
       SUM(o.sales)   AS total_sales,
       SUM(o.profit)  AS total_profit,
       ROUND(SUM(o.profit) / SUM(o.sales) * 100, 2) AS profit_margin_pct
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY total_profit DESC;
```

**Identifying the Discount Loss Threshold**
```sql
SELECT
    CASE
      WHEN discount = 0      THEN 'No Discount'
      WHEN discount <= 0.20  THEN '0–20%'
      WHEN discount <= 0.25  THEN '20–25%'
      ELSE                        'Above 25% (Loss Zone)'
    END AS discount_bucket,
    COUNT(*)              AS order_count,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY discount_bucket
ORDER BY total_profit DESC;
```

---

## 🛠️ Tech Stack

| Layer | Tools |
|---|---|
| Data Engineering | MySQL, SQL DDL/DML, Joins, CTEs, Aggregations |
| Python Analysis | Pandas, SQLAlchemy, Matplotlib, Seaborn, Jupyter |
| Business Intelligence | Power BI, DAX, Power Query, Bing Maps |
| Data Source | Kaggle — Superstore Global Sales Dataset (2011–2014) |

---

## 📂 Explore the Project

- 🗄️ **SQL Scripts** → [`/SQL`](./SQL)
- 🐍 **Python Analysis** → [`/Python`](./Python)
- 📊 **Power BI Dashboard** → [`/PowerBI`](./PowerBI)

---

## 📁 Repository Structure

```
superstore-analytics/
│
├── README.md
├── images/
│   ├── 1_overview.png
│   ├── 2_product_profit.png
│   ├── 3_customer.png
│   ├── 4_regional.png
│   └── 5_loss_making.png
│
├── SQL/
│   ├── 0_Data_Preparation.sql
│   ├── 01_Data_validation.sql
│   ├── 02_Sales_&_profit_Analysis.sql
│   ├── 03_Region_geographic_analysis.sql
│   ├── 04_Customer_segment_analysis.sql
│   ├── 05_Discount_&_profitability_Analysis.sql
│   ├── 06_Return_Analysis.sql
│   └── 07_Shipping_&_operations_Analysis.sql
│
├── Python/
│   ├── 1.1_EDA_Superstore_DB.ipynb
│   ├── 1.2_Sales_&_Profit_analysis.ipynb
│   ├── 1.3_Regional_&_geographic_analysis.ipynb
│   ├── 1.4_Customer_segment_analysis.ipynb
│   ├── 1.5_Discount_&_Profitability_analysis.ipynb
│   ├── 1.6_Return_analysis.ipynb
│   └── 1.7_Shipping_&_Operation_Analysis.ipynb
│
└── PowerBI/
    └── Superstore_Dashboard.pbix
```

---

*Superstore Analytics · SQL · Python · Power BI · Kaggle Superstore Dataset · 2011–2014*
