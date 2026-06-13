# Data Dictionary — GA4 Obfuscated Sample E-commerce

**Source:** `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
**Grain:** one row = one event | **Range:** 2020-11-01 to 2021-01-31 (92 daily tables)
**Volume:** ~4.3M events, ~270K users

| Field                      | Type              | Description                                                                                          | Notes                                                                      |
| -------------------------- | ----------------- | ---------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------- |
| event_date                 | STRING            | Date on which the event occurred (format: YYYYMMDD)                                                  | Useful for daily aggregation and filtering                                 |
| event_timestamp            | INTEGER           | Exact time the event occurred in microseconds                                                        | Can be converted to readable timestamp; not needed for high-level analysis |
| event_name                 | STRING            | Name of the user action/event (e.g., page_view, add_to_cart, purchase)                               | Core field for funnel analysis                                             |
| user_pseudo_id             | STRING            | Anonymous identifier assigned to each user                                                           | Used to track user behavior across sessions (not true user identity)       |
| device.category            | STRING            | Type of device used (desktop, mobile, tablet)                                                        | Useful for device-level segmentation                                       |
| traffic_source.source      | STRING            | Origin of the traffic (e.g., google, youtube, direct)                                                | High-level traffic origin                                                  |
| traffic_source.medium      | STRING            | Marketing channel type (e.g., organic, cpc, referral, none)                                          | Used for channel performance analysis                                      |
| event_params               | RECORD (REPEATED) | Nested key-value pairs containing additional event details (e.g., page_title, transaction_id, value) | Requires UNNEST() to extract specific parameters                           |
| ecommerce.purchase_revenue | FLOAT             | Revenue generated from a purchase event                                                              | Only populated for purchase-related events                                 |
| items                      | RECORD (REPEATED) | List of items associated with an event (product details like name, price, quantity)                  | Requires UNNEST(); useful for product-level analysis                       |

---

## Data Quality Observations

* Some traffic channels appear as **"(data deleted)"** or **"<Other>"**, indicating incomplete or anonymized attribution
* The **user_id** field is mostly empty, limiting the ability to track users across devices or sessions reliably
* Data is **event-level and denormalized**, requiring transformation (UNNEST) for structured analysis
* Dataset covers only ~3 months, which limits long-term analysis like retention or lifetime value
