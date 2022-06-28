{{
    config(
        materialized='table'
    )
}}

with

users as (

    select * from {{ ref('int_greenery__user_orders_agg' ) }}

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
        users.order_count,
        users.user_address,
        addresses.street_address,
        addresses.zipcode,
        addresses.state,
        addresses.country

    from users
    left join addresses
        on users.user_address = addresses.address_id

)

select * from final