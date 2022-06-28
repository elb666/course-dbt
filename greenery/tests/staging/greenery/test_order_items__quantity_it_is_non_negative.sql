  select *
  from {{ ref('stg_greenery__order_items') }}
  where quantity < 0