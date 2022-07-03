{{
    config(
        materialized='table'
    )
}}

with

events as (

    select * from {{ ref('stg_greenery__events') }}

),

events_agg as (

    select

        session_id
        , user_id
        , min(created) as session_start
        , max(created) as session_end
        , max(created) - min(created) as session_length
        {{ count_event_type_logic() }}
 
    from events
    group by 1, 2
),

final as (

    select
        session_id
        , user_id
        , session_start
        , session_end
        , session_length
        {{ count_event_type_column_names() }}

    from events_agg

)

select * from final