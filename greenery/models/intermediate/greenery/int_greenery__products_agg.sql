{{
    config(
        materialized='table'
    )
}}

with

orders as (

    select * from {{ ref('stg_greenery__orders' ) }}

),

products as (

    select * from {{ ref('stg_greenery__products' ) }}

),

order_items as (

    select * from {{ ref('stg_greenery__order_items' ) }}

),

order_items_agg as (

    select

        order_items.product_id,
        sum(order_items.quantity) as total_quantity_sold,
        count(distinct order_items.order_id) as number_of_times_ordered,
        min(orders.created) as first_sale_date,
        max(orders.created) as most_recent_sale_date,
        count(distinct orders.user_id) as number_of_purchasers

    from order_items
    join orders
      on order_items.order_id = orders.order_id
    group by 1
),

final as (

    select

        products.*,
        order_items_agg.total_quantity_sold,
        order_items_agg.total_quantity_sold * products.price as total_dollar_amount_sold,
        order_items_agg.number_of_times_ordered,
        order_items_agg.number_of_purchasers,
        order_items_agg.first_sale_date,
        order_items_agg.most_recent_sale_date

    from products
    left join order_items_agg
      on products.product_id = order_items_agg.product_id
   
)

select * from final