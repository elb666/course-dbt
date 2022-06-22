{{
    config(
        materialized = 'table'
    )
}}

with

source as (

    select * from {{ source('staging','events')}}

),

renamed as (

    select

        event_id,
        session_id,
        user_id,
        page_url,
        created_at as created,
        event_type,
        order_id,
        product_id

    from source

)

select * from renamed