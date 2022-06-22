{{
    config(
        materialized = 'table'
    )
}}

with

source as (

    select * from {{ source('staging','addresses') }}

),

renamed as (

    select

        address_id,
        address as street_address,
        zipcode,
        state,
        country

    from source

)

select * from renamed