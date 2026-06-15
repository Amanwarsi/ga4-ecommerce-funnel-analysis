-- 02_channel_conversion.sql
-- Question: Which channels bring buyers vs browsers? (Steve KPI #3)
-- Key finding: referral converts best (1.66%) among real channels;
--   cpc (paid) is lowest (0.98%) AND costs money -> audit before scaling.
-- Note: (data deleted) & <Other> are obfuscation artifacts -> excluded from conclusions.

WITH base_events AS (
  SELECT
    user_pseudo_id,
    (SELECT value.int_value
     FROM UNNEST(event_params)
     WHERE key = 'ga_session_id') AS session_id,
    event_name,
    traffic_source.medium AS channel
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
),

session_funnel AS (
  SELECT
    user_pseudo_id,
    session_id,
    ANY_VALUE(channel) AS channel,
    MAX(IF(event_name = 'view_item',   1, 0)) AS reached_view_item,
    MAX(IF(event_name = 'purchase',    1, 0)) AS reached_purchase
  FROM base_events
  GROUP BY user_pseudo_id, session_id
)

SELECT
  channel,
  COUNT(*)                                          AS total_sessions,
  SUM(reached_purchase)                             AS purchases,
  ROUND(SUM(reached_purchase) / COUNT(*) * 100, 2)  AS conversion_rate_pct
FROM session_funnel
GROUP BY channel
ORDER BY total_sessions DESC;
