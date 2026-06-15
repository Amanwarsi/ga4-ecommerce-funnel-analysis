-- 01_funnel_overview.sql
-- Question: Where do users drop off in the purchase funnel? (Steve KPI #2)
-- Grain: one row per session, flagged by furthest funnel step reached
-- Key finding: view->cart -80% (browsing), checkout->purchase -56% (friction = priority fix)

WITH base_events AS (
  SELECT
    user_pseudo_id,
    (SELECT value.int_value
     FROM UNNEST(event_params)
     WHERE key = 'ga_session_id') AS session_id,
    event_name
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
),

session_funnel AS (
  SELECT
    user_pseudo_id,
    session_id,
    MAX(IF(event_name = 'view_item',      1, 0)) AS reached_view_item,
    MAX(IF(event_name = 'add_to_cart',    1, 0)) AS reached_add_to_cart,
    MAX(IF(event_name = 'begin_checkout', 1, 0)) AS reached_checkout,
    MAX(IF(event_name = 'purchase',       1, 0)) AS reached_purchase
  FROM base_events
  GROUP BY user_pseudo_id, session_id
)

SELECT
  SUM(reached_view_item)   AS viewed_item,
  SUM(reached_add_to_cart) AS added_to_cart,
  SUM(reached_checkout)    AS began_checkout,
  SUM(reached_purchase)    AS purchased
FROM session_funnel;
