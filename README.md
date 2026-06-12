
# GA4 E-commerce Funnel & Channel Analysis

**Status:** 🟡 Phase 0 — Business Brief (in progress: data profiling next)

## Business Brief

**Stakeholder:** Steve, Marketing Manager at a mid-size D2C e-commerce company

**Problem:** Website traffic is growing, but conversions and revenue are inconsistent. The marketing team lacks visibility into where users drop off in the purchase journey and which channels drive high-quality traffic.

**Key Question:** Where do users drop off in the purchase funnel, and which acquisition channels generate the highest conversion and revenue?

## KPIs

| # | KPI                       | Formula                                                                | Why it matters                                                 |
| - | ------------------------- | ---------------------------------------------------------------------- | -------------------------------------------------------------- |
| 1 | Session Conversion Rate   | purchases ÷ sessions                                                   | Measures overall efficiency of converting visitors into buyers |
| 2 | Funnel Drop-off Rate      | (users at previous step − users at next step) ÷ users at previous step | Identifies where users abandon the purchase journey            |
| 3 | Channel Conversion Rate   | purchases (by channel) ÷ sessions (by channel)                         | Compares effectiveness of each acquisition channel             |
| 4 | Revenue by Channel        | sum of purchase revenue grouped by channel                             | Highlights which channels drive actual revenue                 |
| 5 | Average Order Value (AOV) | total revenue ÷ number of purchases                                    | Indicates the value and quality of transactions                |

## Scope

**In scope:**

* Analysis of the purchase funnel (view_item → add_to_cart → begin_checkout → purchase)
* Channel-level performance (organic, paid, direct, referral)
* Device-level behavior (desktop, mobile, tablet)
* Session-level and event-level analysis using GA4 clickstream data
* Time-based trends within the available dataset (~3 months)

**Out of scope:**

* Marketing ROI and profitability — no cost data available for acquisition channels
* Post-purchase experience (delivery, returns, satisfaction) — dataset only covers pre-purchase events
* Customer lifetime value (LTV) — limited ability to track users across long time horizons due to anonymized IDs
* Cross-device tracking — users cannot be reliably linked across multiple devices

## Stack

BigQuery (SQL) · GA4 public dataset · Looker Studio · GitHub

## Project Phases

Brief → Data Profiling → SQL Transformation → Analysis → Dashboard → Insights & Recommendations
