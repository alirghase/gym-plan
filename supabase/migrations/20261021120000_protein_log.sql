-- Protein Log (alirghase/protein-log) shares this project, so one account signs in to both apps.
-- One row per logged day, plus one settings row per account. Each account can only see and change its own rows.
create table public.protein_days (
  user_id uuid not null default auth.uid() references auth.users (id) on delete cascade,
  date date not null,
  entries jsonb not null check (jsonb_typeof(entries) = 'array' and pg_column_size(entries) < 20000),
  saved_at bigint not null,
  primary key (user_id, date)
);

create table public.protein_profile (
  user_id uuid primary key default auth.uid() references auth.users (id) on delete cascade,
  weight_kg numeric check (weight_kg is null or weight_kg between 30 and 300),
  height_cm numeric check (height_cm is null or height_cm between 100 and 250),
  target_kg numeric check (target_kg is null or target_kg between 30 and 300),
  g_per_kg numeric not null default 1.8 check (g_per_kg between 1 and 3),
  custom_foods jsonb not null default '[]' check (jsonb_typeof(custom_foods) = 'array' and pg_column_size(custom_foods) < 20000),
  saved_at bigint not null
);

alter table public.protein_days enable row level security;
alter table public.protein_profile enable row level security;

revoke all on public.protein_days from anon;
revoke all on public.protein_profile from anon;
grant select, insert, update, delete on public.protein_days to authenticated;
grant select, insert, update, delete on public.protein_profile to authenticated;

create policy "read own days" on public.protein_days
  for select to authenticated using ((select auth.uid()) = user_id);
create policy "add own days" on public.protein_days
  for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "change own days" on public.protein_days
  for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "delete own days" on public.protein_days
  for delete to authenticated using ((select auth.uid()) = user_id);

create policy "read own profile" on public.protein_profile
  for select to authenticated using ((select auth.uid()) = user_id);
create policy "add own profile" on public.protein_profile
  for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "change own profile" on public.protein_profile
  for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "delete own profile" on public.protein_profile
  for delete to authenticated using ((select auth.uid()) = user_id);
