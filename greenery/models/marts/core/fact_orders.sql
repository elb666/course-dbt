{{
    config(
        materialized='table'
    )
}}

with

orders as (

    select * from {{ ref('stg_greenery__orders' ) }}

),

order_items_agg as (

    select * from {{ ref('int_greenery__orders_agg' ) }}

),

final as (

    select

        orders.order_id,
        orders.user_id,
        orders.promo_id,
        orders.address_id,
        orders.created,
        orders.order_cost,
        orders.shipping_cost,
        orders.order_total_cost,
        orders.tracking_id,
        orders.shipping_service,
        orders.estimated_delivery,
        orders.delivered,
        orders.order_status,
        order_items_agg.total_number_of_items

     from orders
     left join order_items_agg
         on orders.order_id = order_items_agg.order_id

)

select * from final