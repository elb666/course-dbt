{{
    config(
        materialized = 'table'
    )
}}

with

source as (

    select * from {{ source('staging','users')}}

),

renamed as (

    select

        user_id,
        first_name,
        last_name,
        email as email_address,
        phone_number,
        created_at as created,
        updated_at as updated,
        address_id as user_address

    from source

)

select * from renamed