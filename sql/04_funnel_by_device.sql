-- 04_funnel_by_device.sql
-- Question: Does any device leak harder in the funnel? (Steve)
-- Key finding: NO device penalty - all 6.1-6.5% view->purchase, mobile == desktop
--   at every step. Funnel leaks are device-agnostic (product/UX, not mobile UX).

WITH base_events AS (
  SELECT
    user_pseudo_id,
    (SELECT value.int_value
     FROM UNNEST(event_params)
     WHERE key = 'ga_session_id') AS session_id,
    event_name,
    device.category AS device
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
),

session_funnel AS (
  SELECT
    user_pseudo_id,
    session_id,
    ANY_VALUE(device) AS device,
    MAX(IF(event_name = 'view_item',      1, 0)) AS reached_view_item,
    MAX(IF(event_name = 'add_to_cart',    1, 0)) AS reached_add_to_cart,
    MAX(IF(event_name = 'begin_checkout', 1, 0)) AS reached_checkout,
    MAX(IF(event_name = 'purchase',       1, 0)) AS reached_purchase
  FROM base_events
  GROUP BY user_pseudo_id, session_id
)

SELECT
  device,
  SUM(reached_view_item)   AS viewed_item,
  SUM(reached_add_to_cart) AS added_to_cart,
  SUM(reached_checkout)    AS began_checkout,
  SUM(reached_purchase)    AS purchased,
  ROUND(SUM(reached_purchase) / SUM(reached_view_item) * 100, 2) AS view_to_purchase_pct
FROM session_funnel
GROUP BY device
ORDER BY viewed_item DESC;
