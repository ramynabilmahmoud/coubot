create type payment_method_type as enum ('e_wallet', 'instapay');

alter table public.orders
  add column payment_method payment_method_type,
  add column payment_screenshot_url text;
