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

sessions as (

    select * from {{ ref('int_greenery__sessions') }}

),

final as (

    select

          session_id
        , user_id
        , session_start
        , session_end
        , session_length
        {{ count_event_type_column_names() }}

    from sessions

)

select * from final