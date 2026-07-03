update storage.buckets set public = true where id = 'payment-screenshots';

update public.orders
set payment_screenshot_url = 'https://fplsrounvbbxgnrcajag.supabase.co/storage/v1/object/public/payment-screenshots/' || payment_screenshot_url
where payment_screenshot_url is not null
  and payment_screenshot_url not like 'http%';
