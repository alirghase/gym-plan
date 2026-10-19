-- One row per logged session. Each account can only see and change its own rows.
create table public.workouts (
  user_id uuid not null default auth.uid() references auth.users (id) on delete cascade,
  id text not null,
  date date not null,
  session text not null check (session ~ '^[a-z-]{1,20}$'),
  entries jsonb not null check (jsonb_typeof(entries) = 'object' and pg_column_size(entries) < 20000),
  saved_at bigint not null,
  primary key (user_id, id),
  check (id = date::text || '_' || session)
);

alter table public.workouts enable row level security;

revoke all on public.workouts from anon;
grant select, insert, update, delete on public.workouts to authenticated;

create policy "read own sessions" on public.workouts
  for select to authenticated using ((select auth.uid()) = user_id);
create policy "add own sessions" on public.workouts
  for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "change own sessions" on public.workouts
  for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "delete own sessions" on public.workouts
  for delete to authenticated using ((select auth.uid()) = user_id);
