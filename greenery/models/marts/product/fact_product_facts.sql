{{
    config(
        materialized='table'
    )
}}

with

products_agg as (

    select * from {{ ref('int_greenery__products_agg' ) }}

),

final as (

    select
        *
    from products_agg

)

select * from final