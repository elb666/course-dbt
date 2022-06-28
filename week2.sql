/* What is our user repeat rate?
 * Repeat Rate = Users who purchased 2 or more times / users who purchased
 *
 */

with sq_0 as (
    select
        sum(case when dim_users.order_count >= 1 then 1 else 0 end) as users_with_1_or_more_orders,
        sum(case when dim_users.order_count >= 2 then 1 else 0 end) as users_with_2_or_more_orders,
        count(*) as total_users
    from dbt_eric_b_core.dim_users
)
select
    users_with_1_or_more_orders::float / total_users  as percent_of_users_who_have_ordered,
    users_with_2_or_more_orders::float / total_users  as percent_of_users_who_have_ordered_more_than_once,
    users_with_2_or_more_orders::float / users_with_1_or_more_orders  as repeat_rate
from sq_0;


select * from dbt_eric_b_marketing.fact_user_order_facts;


 



