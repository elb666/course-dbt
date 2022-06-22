{{
    config(
        materialized='table'
    )
}}

with

users as (

    select * from {{ ref('stg_greenery__users' ) }}

),

addresses as (

    select * from  {{ ref('stg_greenery__addresses') }}

),

final as (

    select

        users.user_id,
        users.first_name,
        users.last_name,
        users.email_address,
        users.phone_number,
        users.created,
        users.updated,
        users.address_id,
        addresses.street_address,
        addresses.zipcode,
        addresses.state,
        addresses.country

    from users
    left join addresses
        on users.address_id = addresses.address_id

)

select * from final