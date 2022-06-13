/*********************************************************/
/*     This readme has answers to project questions      */
/*********************************************************/


/*********************************************************/
-- How many users do we have?
select count(*) from dbt_eric_b.stg_greenery__users;
-- 130 users
/*********************************************************/

/*********************************************************/
-- On average, how many orders do we receive per hour?
with orders_by_hour as (
    select 

        date_trunc('hour', created) as hour_bin,
        count(*) as order_count

    from dbt_eric_b.stg_greenery__orders

    group by 1
)
select avg(order_count) from orders_by_hour;
-- 7.52
/*********************************************************/


/*********************************************************/
-- On average, how long does an order take from being placed to being delivered?
select

        avg(delivered - created) as average_time_to_deliver

from dbt_eric_b.stg_greenery__orders
where delivered is not null;
-- 3 days, 21 hours, 24 minutes
/*********************************************************/

/*********************************************************/
-- How many users have only made one purchase? Two purchases? Three+ purchases?
with user_order_counts as (
    select
        count(*) as order_count, 
        user_id
    from dbt_eric_b.stg_greenery__orders
    group by user_id
),
order_count_counts as (
    select
        case
          when order_count >= 3 then '3+'
          else cast(order_count as varchar)
          end as order_count,
        count(*) as user_count
    from user_order_counts
    group by 1
    order by 1
)
select * from order_count_counts;
-- How many users have only made one purchase? 25
-- Two purchases? 28
-- Three+ purchases? 71
/*********************************************************/


/*********************************************************/
-- On average, how many unique sessions do we have per hour?
with sessions_by_hour as (
    select 

        date_trunc('hour', created) as hour_bin,
        count(distinct session_id) as session_count

    from dbt_eric_b.stg_greenery__events

    group by 1
)
select avg(session_count) from sessions_by_hour;
-- 16.33
/*********************************************************/

