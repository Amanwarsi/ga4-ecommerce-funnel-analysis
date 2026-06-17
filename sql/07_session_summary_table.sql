CREATE OR REPLACE TABLE `project-b6e85d36-d29f-4599-b32.ga4_analysis.session_summary` AS
WITH base_events AS (
  SELECT
    user_pseudo_id,
    (SELECT value.int_value
     FROM UNNEST(event_params)
     WHERE key = 'ga_session_id') AS session_id,
    event_name,
    PARSE_DATE('%Y%m%d', event_date) AS event_date,
    device.category AS device,
    traffic_source.medium AS channel,
    ecommerce.purchase_revenue AS revenue
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
)

SELECT
  user_pseudo_id,
  session_id,
  ANY_VALUE(device)  AS device,
  ANY_VALUE(channel) AS channel,
  MIN(event_date)    AS session_date,
  MAX(IF(event_name = 'view_item',      1, 0)) AS reached_view_item,
  MAX(IF(event_name = 'add_to_cart',    1, 0)) AS reached_add_to_cart,
  MAX(IF(event_name = 'begin_checkout', 1, 0)) AS reached_checkout,
  MAX(IF(event_name = 'purchase',       1, 0)) AS reached_purchase,
  SUM(IF(event_name = 'purchase', revenue, 0)) AS revenue
FROM base_events
GROUP BY user_pseudo_id, session_id;
