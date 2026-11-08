-- Protein Log's calorie burn estimate: age (for resting burn) and average steps a day on the settings row.
alter table public.protein_profile
  add column age smallint check (age is null or age between 14 and 100),
  add column steps_per_day integer not null default 10000 check (steps_per_day between 0 and 50000);
