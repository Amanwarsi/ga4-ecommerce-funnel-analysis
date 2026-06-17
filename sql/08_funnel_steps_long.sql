CREATE OR REPLACE TABLE `project-b6e85d36-d29f-4599-b32.ga4_analysis.funnel_steps` AS
SELECT '1. Viewed Item'    AS step, SUM(reached_view_item)   AS sessions FROM `project-b6e85d36-d29f-4599-b32.ga4_analysis.session_summary`
UNION ALL
SELECT '2. Added to Cart'  AS step, SUM(reached_add_to_cart) AS sessions FROM `project-b6e85d36-d29f-4599-b32.ga4_analysis.session_summary`
UNION ALL
SELECT '3. Began Checkout' AS step, SUM(reached_checkout)    AS sessions FROM `project-b6e85d36-d29f-4599-b32.ga4_analysis.session_summary`
UNION ALL
SELECT '4. Purchased'      AS step, SUM(reached_purchase)    AS sessions FROM `project-b6e85d36-d29f-4599-b32.ga4_analysis.session_summary`;
