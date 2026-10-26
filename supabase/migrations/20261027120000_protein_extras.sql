-- Protein Log: per-day flags (for now {"futsal": true}) that feed the calorie burn estimate.
alter table public.protein_days
  add column extras jsonb not null default '{}'
  check (jsonb_typeof(extras) = 'object' and pg_column_size(extras) < 2000);
