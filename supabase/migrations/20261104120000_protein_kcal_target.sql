-- Protein Log's daily calorie target, chosen in the app's settings (the app uses 2,200 when it's empty).
alter table public.protein_profile
  add column kcal_target integer check (kcal_target is null or kcal_target between 1000 and 5000);
