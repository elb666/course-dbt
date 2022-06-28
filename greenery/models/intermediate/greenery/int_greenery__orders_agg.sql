{{
    config(
        materialized='table'
    )
}}

with

orders as (

    select * from {{ ref('stg_greenery__orders' ) }}

),

order_items as (

    select * from {{ ref('stg_greenery__order_items' ) }}

),

order_items_agg as (

    select

        order_items.order_id,
        sum(order_items.quantity) as total_number_of_items

    from order_items
    group by 1
),

final as (

    select

        orders.*,
        order_items_agg.total_number_of_items
    
    from orders
    left join order_items_agg
      on orders.order_id = order_items_agg.order_id

)

select * from final