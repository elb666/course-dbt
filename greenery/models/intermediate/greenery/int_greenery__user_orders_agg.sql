{{
    config(
        materialized='table'
    )
}}

with

orders as (

    select * from {{ ref('int_greenery__orders_agg' ) }}

),

users as (

    select * from {{ ref('stg_greenery__users' ) }}

),

/* calculate how many orders the person has placed */
user_order_agg as (

    select

        orders.user_id,
        count(*) as order_count,
        avg(orders.order_cost)::numeric(10,2) as average_order_cost,
        avg(orders.order_total_cost)::numeric(10,2) as average_order_total_cost,
        avg(orders.total_number_of_items)::numeric(10,1) as average_number_of_items_ordered,
        min(orders.created) as first_order_date,
        max(orders.created) as last_order_date
    
    from orders
    group by orders.user_id

),


final as (

    select

        users.*,
        coalesce(user_order_agg.order_count, 0) as order_count,
        user_order_agg.average_order_cost,
        user_order_agg.average_order_total_cost,
        user_order_agg.average_number_of_items_ordered,
        user_order_agg.first_order_date,
        user_order_agg.last_order_date

    from users
    left join user_order_agg
      on users.user_id = user_order_agg.user_id

)

select * from final