-- 05_view_vs_purchase_products.sql 

WITH item_events AS (
  SELECT
    event_name,
    item.item_name AS product
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
  UNNEST(items) AS item
  WHERE event_name IN ('view_item', 'purchase')
)

SELECT
  product,
  COUNTIF(event_name = 'view_item') AS views,
  COUNTIF(event_name = 'purchase')  AS purchases,
  ROUND(COUNTIF(event_name = 'purchase') / NULLIF(COUNTIF(event_name = 'view_item'), 0) * 100, 2) AS view_to_purchase_pct
FROM item_events
GROUP BY product
HAVING views >= 1000
ORDER BY views DESC
LIMIT 20;
