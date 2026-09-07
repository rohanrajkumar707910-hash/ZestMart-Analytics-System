# 🛒 RetailPulse India — ZestMart Analytics System

> End-to-end Business Intelligence System built on a fictional
> 50-store Indian retail chain using Excel, SQL, Python & Power BI

![Excel](https://img.shields.io/badge/Excel-217346?style=flat&logo=microsoft-excel&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=mysql&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)
![PowerBI](https://img.shields.io/badge/Power_BI-F2C811?style=flat&logo=powerbi&logoColor=black)

---

## 📌 Project Overview

ZestMart is a fictional Indian retail chain with 50+ stores across
6 cities — Delhi, Mumbai, Bangalore, Chennai, Kolkata, and Gaya.
This project builds a complete analytics pipeline from raw data
to boardroom-ready dashboards.

| Detail | Info |
|--------|------|
| 🏪 Stores | 10 stores across 5 cities |
| 📦 Products | 20 Indian retail products |
| 👥 Customers | 20 customers |
| 💼 Employees | 20 employees |
| 🧾 Transactions | 200 sales records |
| 📅 Period | January 2023 — December 2023 |

---

## 🗂️ Project Structure

ZestMart-Analytics-System/
│
├── 📊 Excel/
│ └── ZestMart_RawData.xlsm # 10 sheets, 2229 formulas, 3 macros
│
├── 🗄️ SQL/
│ └── Zestmart_sql.sql # 47 queries — joins, CTEs, window functions
│
├── 🐍 Python/
│ └── ZestMart_Python_Analysis.ipynb # 6 notebooks — EDA, Matplotlib, Seaborn
│
├── 📈 PowerBI/
│ └── ZestMart_Dashboard.pbix # 4 dashboards — star schema + DAX
│
└── 🖼️ Charts/
└── 16 PNG charts # Matplotlib + Seaborn visualizations


---

## 📊 Phase 1 — Excel (Days 1–4)

**File:** `ZestMart_RawData.xlsm`

| Sheet | Purpose |
|-------|---------|
| Products | 20 products with price, category, supplier |
| Stores | 10 stores across 5 cities |
| Customers | 20 customers with segment info |
| Employees | 20 employees with salary & role |
| Sales_Raw | 200 raw transactions |
| Sales_Enriched | 2200 formulas — INDEX-MATCH, IF, HLOOKUP |
| KPI_Summary | SUMIF, COUNTIF, AVERAGEIF, XLOOKUP |
| Monthly_Targets | HLOOKUP source — 10 stores × 12 months |
| Pivot_Analysis | 3 pivot tables + 3 pivot charts |
| Data_Entry | Validated form + 3 macros |

**Key Skills Used:**
- `INDEX-MATCH` — replaced VLOOKUP for robust lookups
- `HLOOKUP` — monthly targets by store
- `IF` & `Nested IF` — order category & performance rating
- `SUMIF / COUNTIF / AVERAGEIF` — city-wise KPIs
- `XLOOKUP` — dynamic city search
- `Pivot Tables & Charts` — revenue, products, performance
- `Data Validation` — dropdowns for city, category, store
- `Macros & VBA` — RefreshPivots, HighlightSummary, ExportPDF

---

## 🗄️ Phase 2 — SQL (Days 5–10)

**File:** `Zestmart_sql.sql`
**Database:** `zestmart_db` — MySQL

### Schema

products ──┐
stores ────┤── sales ──── returns
customers ─┘
employees ── stores


### Query Categories (47 total)

| Category | Queries |
|----------|---------|
| SELECT, WHERE, ORDER BY | 7 |
| GROUP BY, HAVING | 5 |
| INNER, LEFT, RIGHT, FULL JOIN | 5 |
| INSERT, UPDATE, DELETE | 6 |
| Subqueries & CTEs | 5 |
| Window Functions | 5 |
| Indexing & EXPLAIN | 7 |
| Verification queries | 7 |

**Key Skills Used:**
- All 4 JOIN types
- CTEs (`WITH` clause) — chained 2 CTEs
- Window Functions — `ROW_NUMBER`, `RANK`, `LAG`, `LEAD`
- Query Optimization — `CREATE INDEX`, `EXPLAIN`

---

## 🐍 Phase 3 — Python (Days 11–16)

**File:** `ZestMart_Python_Analysis.ipynb`
**Platform:** Google Colab

### Notebooks

| Day | Topic | Key Work |
|-----|-------|----------|
| Day 11 | Raw Python | CSV read/write, Lists, Dicts, Functions |
| Day 12 | NumPy | Arrays, vectorized ops, correlation matrix |
| Day 13 | Pandas | Clean, merge, groupby, pivot_table |
| Day 14 | EDA | 10 business questions answered |
| Day 15 | Matplotlib | 8 publication-quality charts |
| Day 16 | Seaborn | 8 advanced statistical charts |

### EDA — 10 Business Questions Answered
1. Which city generates highest revenue?
2. Which product category is most profitable?
3. Which store performs best?
4. What is the monthly sales trend?
5. Who are the top 10 customers?
6. Which product sells most?
7. Does discount increase sales?
8. What is customer segment distribution?
9. Which zone performs best?
10. Full business summary report

### Charts Created (16 total)

**Matplotlib (8):** Bar, Line, Horizontal Bar, Pie, Scatter, Grouped Bar, Heatmap, 6-Panel

**Seaborn (8):** Pairplot, Boxplot, Violin, Regression, Correlation Heatmap, Countplot, Clustermap, 6-Panel

---

## 📈 Phase 4 — Power BI (Days 17–20)

**File:** `ZestMart_Dashboard.pbix`

### Data Model

zestmart_full (fact) ──── stores (dim)
──── city_summary (dim)
──── city_monthly_revenue (dim)
employees ──────────────── stores (dim)


### DAX Measures (12+)
```dax
Total Revenue    = SUM(zestmart_full[net_amount])
Total Profit     = SUM(zestmart_full[profit])
Total Orders     = COUNTROWS(zestmart_full)
Avg Order Value  = AVERAGE(zestmart_full[net_amount])
Profit Margin %  = DIVIDE(SUM([profit]), SUM([net_amount]), 0) * 100
Premium Revenue  = CALCULATE(SUM([net_amount]), [segment]="Premium")
YTD Revenue      = CALCULATE(SUM([net_amount]), DATESYTD([sale_date]))
```

### 4 Dashboards

| Dashboard | Audience | Visuals |
|-----------|----------|---------|
| Executive Overview | CEO | KPIs, Revenue trend, City map, Products |
| Operations | Manager | Store perf, Discount analysis, Zone matrix |
| HR Analysis | HR | Headcount, Salary, Role distribution |
| Customer Intelligence | Marketing | Segments, Age group, Top customers |

---

## 📊 Key Insights

| Insight | Finding |
|---------|---------|
| 💰 Total Revenue | Rs 17.94 Lakhs |
| 🏆 Best City | Kolkata |
| 📦 Top Category | Electronics |
| 🎯 Avg Profit Margin | 23.82% |
| 📉 Discount Impact | Near zero correlation (0.021) |
| 👥 Premium Customers | 7 out of 20 (35%) |

---

## 🔢 Project Stats

| Metric | Count |
|--------|-------|
| Excel Formulas | 2,229 |
| SQL Queries | 47 |
| Python Charts | 16 |
| Power BI Dashboards | 4 |
| DAX Measures | 12+ |
| Total Days | 20 |

---

## 👤 About

**Rohan Kumar**
Data Analytics Fresher | BA Student @ VGU CDOE (2028)
📍 Gaya, Bihar

🔗 [LinkedIn](https://linkedin.com/in/rohan-kumar-a01878371/)
🐙 [GitHub](https://github.com/rohanrajkumar707910-hash)

> Open to Data Analyst Internships & Entry-Level Roles

→ Commit changes click karo ✅

STEP 5 — Final Check

Repository kuch aisi dikhni chahiye:

ZestMart-Analytics-System/
├── 📁 Excel/
├── 📁 SQL/
├── 📁 Python/
├── 📁 PowerBI/
├── 📁 Charts/
└── 📄 README.md  ← sabse important!
STEP 6 — LinkedIn Pe Share Karo
🚀 Excited to share my 20-day Data Analytics Project!

📊 RetailPulse India — ZestMart Analytics System

Built an end-to-end BI system on a fictional Indian
retail chain:

✅ Excel — 2,229 formulas, Pivot Tables, Macros
✅ MySQL — 47 queries, Window Functions, CTEs
✅ Python — EDA, 16 Charts (Matplotlib + Seaborn)
✅ Power BI — 4 Dashboards, DAX, Star Schema

🔗 GitHub:https://github.com/rohanrajkumar707910-hash/ZestMart-Analytics-System

#DataAnalytics #Python #SQL #PowerBI #Excel
#DataAnalyst #OpenToWork #ZestMart
