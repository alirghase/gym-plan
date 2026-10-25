-- Protein Log's body section: tape measurements (and weight) by date, plus a waist target on the settings row.
-- One row per measured day. Each account can only see and change its own rows.
create table public.body_measurements (
  user_id uuid not null default auth.uid() references auth.users (id) on delete cascade,
  date date not null,
  measures jsonb not null check (jsonb_typeof(measures) = 'object' and pg_column_size(measures) < 2000),
  saved_at bigint not null,
  primary key (user_id, date)
);

alter table public.protein_profile
  add column waist_target_cm numeric check (waist_target_cm is null or waist_target_cm between 40 and 200);

alter table public.body_measurements enable row level security;
revoke all on public.body_measurements from anon;
grant select, insert, update, delete on public.body_measurements to authenticated;

create policy "read own measurements" on public.body_measurements
  for select to authenticated using ((select auth.uid()) = user_id);
create policy "add own measurements" on public.body_measurements
  for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "change own measurements" on public.body_measurements
  for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "delete own measurements" on public.body_measurements
  for delete to authenticated using ((select auth.uid()) = user_id);
