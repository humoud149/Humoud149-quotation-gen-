# GIG Quotation Tool

A shareable motor insurance quotation form for GIG. Fillable, auto-calculating,
prints cleanly to PDF, and pulls a shared, never-repeating quotation number
from Supabase so every team member is on the same sequence.

## Setup (one-time)
1. Open your Supabase project → SQL Editor.
2. Paste and run the contents of `schema.sql`.
3. Confirm `index.html` has your Project URL and Publishable (anon) key
   filled in near the top of the `<script>` block (search for `SUPABASE_URL`).

## Deploy
Push this repo to GitHub, then enable **GitHub Pages** in
Settings → Pages → Deploy from branch → `main` / root.
Your team can then open the live link from any computer or phone.

## Roadmap
- [x] Shared, race-safe quotation numbering (Supabase)
- [ ] Team member accounts / login
- [ ] Save & search past quotations
- [ ] Manager dashboard / reporting
