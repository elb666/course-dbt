{{
    config(
        materialized='table'
    )
}}

with

products as (

    select * from {{ ref('stg_greenery__products') }}

),

final as (

    select

        product_id,
        product_name,
        price,
        inventory
 
    from products

)

select * from final