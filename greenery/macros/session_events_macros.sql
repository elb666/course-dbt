{% macro count_event_type_logic() %}

{% set event_types = dbt_utils.get_column_values(
    table=ref('stg_greenery__events'),
    column='event_type',
    order_by='event_type'
) %}

        {% for event_type in event_types %}
        , sum((event_type = '{{ event_type }}')::int) as {{ event_type }}_count
        {% endfor %}

{% endmacro %}

{% macro count_event_type_column_names() %}

{% set event_types = dbt_utils.get_column_values(
    table=ref('stg_greenery__events'),
    column='event_type',
    order_by='event_type'
) %}

        {% for event_type in event_types %}
        , {{ event_type }}_count
        {% endfor %}

{% endmacro %}

