{{
    config(
        materialized = 'table'
    )
}}

with

source as (

    select * from {{ source('staging','orders') }}

),

renamed as (

    select

        order_id,
        user_id,
        promo_id,
        address_id,
        created_at as created,
        order_cost,
        shipping_cost,
        order_total as order_total_cost,
        tracking_id,
        shipping_service,
        estimated_delivery_at as estimated_delivery,
        delivered_at as delivered,
        status as order_status

    from source

)

select * from renamed