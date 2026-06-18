## Insight #2 — Revenue is seasonal, not inconsistent

**Source:** `sql/05_revenue_time_trend.sql`

**Observation**
Revenue follows a clear seasonal pattern: it rises through November, peaks sharply around **Black Friday / Cyber Monday**, and sustains high levels into early–mid December (holiday shopping period). It then drops steeply after the **shipping cutoff before Christmas**, entering a prolonged low through late December and early January, with only a small recovery mid-January.

**Implication**
What appears as “inconsistent revenue” is actually **predictable seasonality**. Demand is concentrated in a short holiday window, while post-holiday periods naturally see reduced purchasing activity. This means performance should be evaluated against seasonal expectations, not as a uniform trend.

**Action**

* **Front-load marketing efforts:** Increase ad spend and promotional activity leading into Black Friday and early December to maximize peak demand.
* **Prepare operations for peak:** Ensure inventory, logistics, and staffing are optimized before the holiday surge.
* **Plan for the January slump:** Use the low-demand period for retention campaigns, remarketing, and clearance sales to maintain engagement and recover value from existing users.
* **Avoid over-investing post-peak:** Reduce acquisition spend in late December–early January when conversion potential is naturally lower.

**Caveat:** 
Based on a single Nov 2020–Jan 2021 window. The holiday-driven shape is unmistakable within this period,
but confirming it recurs annually would require multiple years of data. Claims are about this period, not a guaranteed yearly cycle.
