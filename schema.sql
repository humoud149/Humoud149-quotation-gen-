-- ============================================================
-- GIG Quotation Tool: shared, race-safe quotation numbering
-- Run this once in Supabase → SQL Editor
-- ============================================================

-- Table that stores the running sequence per year.
-- Nobody can read/write this table directly (locked down below) —
-- it's only touched through the function underneath, so two people
-- clicking "New" at the same instant can never get the same number.
create table if not exists quote_counters (
  year int primary key,
  seq  int not null default 0
);

-- Atomically returns the next quotation number, e.g. Q-2026-0001
create or replace function next_quotation_number()
returns text
language plpgsql
security definer
set search_path = public
as $$
declare
  current_year int := extract(year from now())::int;
  new_seq int;
begin
  insert into quote_counters (year, seq)
  values (current_year, 1)
  on conflict (year) do update set seq = quote_counters.seq + 1
  returning seq into new_seq;

  return 'Q-' || current_year || '-' || lpad(new_seq::text, 4, '0');
end;
$$;

-- Lock the table down completely — no direct reads/writes via the
-- public API key. The function above (security definer) is the only
-- door in, so it's safe to expose the anon/publishable key in GitHub.
alter table quote_counters enable row level security;

-- Allow anyone using the app (anon key) to CALL the function only.
grant execute on function next_quotation_number() to anon;
