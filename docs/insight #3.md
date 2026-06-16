## Insight #3 — High-interest products failing to convert

**Source:** `sql/05_view_vs_purchase_products.sql`

**Observation:**
Among the most-viewed products, two patterns appear:
(a) high views but low (nonzero) conversion: e.g. *Google Navy Speckled Tee* (56,466 views, 0.28%) and *Super G Unisex Joggers* (52,758 views, 0.54%)
(b) high views but exactly zero purchases: *Google Women’s Striped L/S* (42,142 views), *Google F/C Long Sleeve Tee Charcoal* (34,275 views)

**Implication:**
Tier (a) means there is clear demand, but something in the product experience (pricing, images, or product details) is discouraging purchase.
Tier (b) could be either a tracking/data issue or a real business problem (e.g. out-of-stock or unavailable product), and I can’t distinguish between the two because inventory and tracking validation data are not available in this dataset.

**Action:**

* For (a): Optimize product pages — review pricing, improve images/descriptions, and test changes to increase conversion on already high-interest items.
* For (b): First validate data and availability — check tracking accuracy and inventory status before making business decisions, then fix or remove broken listings if confirmed.

**Caveat:**
Analysis is based on event-level data without inventory, pricing history, or product availability context, so zero-purchase cases may not reflect true customer behavior.
