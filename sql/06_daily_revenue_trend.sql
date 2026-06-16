-- 06_daily_revenue_trend.sql
-- Question: Is revenue inconsistent, or seasonal? (Steve's premise)
-- Key finding: Clearly holiday-driven - BFCM + Dec peak, shipping-cutoff drop,
--   Jan slump. "Inconsistent" is actually predictable seasonality.

WITH base_events AS (
  SELECT
    user_pseudo_id,
    (SELECT value.int_value
     FROM UNNEST(event_params)
     WHERE key = 'ga_session_id') AS session_id,
    event_name,
    PARSE_DATE('%Y%m%d', event_date) AS event_date,
    ecommerce.purchase_revenue AS revenue
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
),

daily AS (
  SELECT
    event_date,
    COUNT(DISTINCT IF(event_name = 'purchase', session_id, NULL)) AS purchase_sessions,
    SUM(IF(event_name = 'purchase', revenue, 0)) AS revenue
  FROM base_events
  GROUP BY event_date
)

SELECT
  event_date,
  purchase_sessions,
  ROUND(revenue, 2) AS revenue
FROM daily
ORDER BY event_date;
