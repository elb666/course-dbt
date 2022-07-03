{{
    config(
        materialized='table'
    )
}}

with

events as (

    select * from {{ ref('stg_greenery__events') }}

),

product_session_events_agg as (

    select

          product_id
        {{ count_event_type_logic() }}
 
    from events
    group by 1
),

final as (

    select

          product_id
        , page_view_count
        , add_to_cart_count

    from product_session_events_agg

)

select * from final