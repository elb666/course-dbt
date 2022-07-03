What is our overall conversion rate?<br>
Conversion rate is defined as the
number of unique sessions with a purchase event / total number of unique sessions
 
```sql
with sessions_agg as (
    select
      sum((checkout_count > 0)::int) as sessions_with_purchase_event,
      count(*) as total_sessions
    FROM fact_sessions
)
SELECT
    sessions_with_purchase_event::numeric / total_sessions as conversion_rate
FROM  sessions_agg;
```

Conversion_rate = 62%


 What is our conversion rate by product?<br>
 Conversion rate by product is defined as<br>
 the number of unique sessions with a purchase event of that product 
      /
total number of unique sessions that viewed that product
```sql
SELECT
    product_name,
    page_view_count,
    add_to_cart_count, -- pretending that add_to_cart == purchase_event
    add_to_cart_count::numeric / page_view_count as conversion_rate
FROM fact_product_facts
```
 



