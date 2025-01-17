{{
    config(
        materialized='table'
    )
}}

with

user_orders_agg as (

    select * from {{ ref('int_greenery__user_orders_agg' ) }}

),

final as (

    select
        *
    from user_orders_agg

)

select * from final