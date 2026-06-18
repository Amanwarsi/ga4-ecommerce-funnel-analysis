## Insight #1 — The funnel leaks are device-agnostic

**Source:** `sql/04_funnel_by_device.sql`

**Observation**
Conversion rates from view to purchase are tightly clustered across devices: desktop 6.13%, mobile 6.54%, and tablet 6.12%. This consistency holds across intermediate steps as well—for example, view→cart conversion is ~19.6% on desktop versus ~19.9% on mobile, showing negligible variation. The slight mobile uplift (+0.4pp) is minor and not considered a meaningful difference given the sample size.

**Implication**
The previously identified drop-offs—view→cart (~80%) and checkout→purchase (~56%)—are consistent across all device types. This suggests the issue is not tied to device-specific experience (e.g., mobile usability), but rather to broader factors such as product appeal, pricing, or overall checkout flow.

**Action**

* Avoid investing in device-specific optimizations (e.g., mobile-only fixes), as there is no clear evidence of device-related performance gaps.
* Focus on improving key funnel stages (product page and checkout experience) to address universal drop-offs.
* Since mobile accounts for ~40% of traffic and performs comparably to desktop, it remains a strong candidate for continued acquisition scaling.

**Caveat**
This analysis is based on an open funnel (presence of events within sessions, not strictly ordered paths). Differences between devices are small, so conclusions should be treated as directional rather than statistically definitive.
