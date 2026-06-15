-- 03_revenue_by_channel.sql
-- Question: Which channels generate revenue & highest-value orders? (KPIs #4, #5)
-- Key finding: organic = revenue backbone (volume); referral = best quality
--   (top conv + top AOV) -> growth target; cpc worst on all 3 -> audit spend.

WITH base_events AS (
  SELECT
    user_pseudo_id,
    (SELECT value.int_value
     FROM UNNEST(event_params)
     WHERE key = 'ga_session_id') AS session_id,
    event_name,
    traffic_source.medium AS channel,
    ecommerce.purchase_revenue AS revenue
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
),

session_summary AS (
  SELECT
    session_id,
    ANY_VALUE(channel) AS channel,
    MAX(IF(event_name = 'purchase', 1, 0)) AS purchased,
    SUM(IF(event_name = 'purchase', revenue, 0)) AS session_revenue
  FROM base_events
  GROUP BY user_pseudo_id, session_id
)

SELECT
  channel,
  SUM(purchased)                                          AS purchases,
  ROUND(SUM(session_revenue), 2)                          AS total_revenue,
  ROUND(SUM(session_revenue) / NULLIF(SUM(purchased), 0), 2) AS aov
FROM session_summary
GROUP BY channel
ORDER BY total_revenue DESC;
