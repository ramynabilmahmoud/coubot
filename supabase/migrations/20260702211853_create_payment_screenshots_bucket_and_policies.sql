insert into storage.buckets (id, name, public)
values ('payment-screenshots', 'payment-screenshots', false)
on conflict (id) do nothing;

create policy "Users can upload own payment screenshots"
on storage.objects for insert
to authenticated
with check (
  bucket_id = 'payment-screenshots'
  and (storage.foldername(name))[1] = auth.uid()::text
);

create policy "Users can read own payment screenshots"
on storage.objects for select
to authenticated
using (
  bucket_id = 'payment-screenshots'
  and (storage.foldername(name))[1] = auth.uid()::text
);
