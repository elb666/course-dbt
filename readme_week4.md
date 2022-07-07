
**Product funnel is defined with 3 levels for our dataset:**

  - Sessions with any event of type page_view
  - Sessions with any event of type add_to_cart
  - Sessions with any event of type checkout

```sql
with session_counts as (
  select
      sum((page_view_count > 0)::int) as count_of_sessions_with_page_view
    , sum((add_to_cart_count > 0)::int) as count_of_sessions_with_add_to_cart
    , sum((checkout_count > 0)::int) as count_of_sessions_with_checkout
  from dbt_eric_b_marketing.fact_sessions
)
--select * from session_counts; 
select
    round(count_of_sessions_with_add_to_cart::numeric / count_of_sessions_with_page_view, 2) as add_to_cart_conversion
  , round(count_of_sessions_with_checkout::numeric / count_of_sessions_with_add_to_cart, 2) as checkout_conversion
from session_counts
```
|add_to_cart_conversion|checkout_conversion|
|---|-------|
|0.81 | 0.77|


