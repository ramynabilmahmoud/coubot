create policy "insert own order_products" on public.order_products
for insert to authenticated
with check (
  exists (
    select 1 from public.orders o
    where o.id = order_products.order_id
    and o.customer_id = auth.uid()
  )
);
