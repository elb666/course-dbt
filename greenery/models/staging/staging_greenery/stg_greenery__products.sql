{{
    config(
        materialized = 'table'
    )
}}

with

source as (

    select * from {{ source('staging','products')}}

),

renamed as (

    select

        product_id,
        name as product_name,
        price,
        inventory

    from source

)

select * from renamed