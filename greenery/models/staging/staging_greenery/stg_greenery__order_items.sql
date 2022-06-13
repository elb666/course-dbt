{{ config(materialized="table") }}

with

source as (

    select * from {{ source('staging','order_items')}}

),

renamed as (

    select

        order_id,
        product_id,
        quantity

    from source

)

select * from renamed