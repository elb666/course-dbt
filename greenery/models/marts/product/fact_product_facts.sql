{{
    config(
        materialized='table'
    )
}}

with

products_agg as (

    select * from {{ ref('int_greenery__products_agg' ) }}

),

product_sessions as (

    select * from {{ ref('int_greenery__product_sessions')}}
),

final as (

    select
        products_agg.*,
        product_sessions.page_view_count,
        product_sessions.add_to_cart_count

    from products_agg
    left join product_sessions
      on products_agg.product_id = product_sessions.product_id

)

select * from final