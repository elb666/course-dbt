{{
    config(
        materialized='table'
    )
}}

with

users as (

    select * from {{ ref('stg_greenery__users' ) }}

),

orders as (

    select * from {{ ref('stg_greenery__orders' ) }}

),

order_items as (

    select * from {{ ref('stg_greenery__order_items' ) }}

),

orders

final as (

    select
        
    from users

)

select * from final