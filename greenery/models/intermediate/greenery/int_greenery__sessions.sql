{% set event_types = dbt_utils.get_column_values(
    table=ref('stg_greenery__events'),
    column='event_type',
    order_by='event_type'
) %}

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
        {% for event_type in event_types %}
        , sum((event_type = '{{ event_type }}')::int) as {{ event_type }}_count
        {% endfor %}

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
        {% for event_type in event_types %}
        , {{ event_type }}_count
        {% endfor %}
    from events_agg

)

select * from final