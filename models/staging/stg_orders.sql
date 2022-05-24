select
    orders.id as order_id,
    user_id as customer_id,
    order_date,
    orders.status,
    count(payment.id) as payment_count,
    sum(coalesce(payment.amount, 0)) as payment_amount

from {{source('jaffle_shop', 'orders')}} orders
left join {{source('stripe', 'payment')}} payment on orders.id = payment.orderid
group by 1, 2, 3, 4