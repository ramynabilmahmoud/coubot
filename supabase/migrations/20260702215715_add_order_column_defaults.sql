create sequence if not exists orders_order_num_seq owned by public.orders.order_num;
select setval('orders_order_num_seq', (select coalesce(max(order_num), 0) from public.orders));
alter table public.orders alter column order_num set default nextval('orders_order_num_seq');
alter table public.orders alter column delivery_method set default 'coubot_dlivery';
alter table public.orders alter column estimated_time set default 15;
