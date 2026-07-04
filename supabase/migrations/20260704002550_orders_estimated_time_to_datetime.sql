-- Convert orders.estimated_time from a numeric minutes-duration into an
-- actual ETA timestamp (created_at + old minutes value), so the app can
-- show live "arriving in X min" tracking against wall-clock time.
alter table public.orders alter column estimated_time drop default;

alter table public.orders
  alter column estimated_time type timestamptz
  using (created_at + (estimated_time || ' minutes')::interval);

alter table public.orders
  alter column estimated_time set default (now() + interval '15 minutes');
