# Gym Plan

A four-day machine programme on one page, with a weights log that shows whether each lift is
getting stronger.

Live at **https://alirghase.github.io/gym-plan/**.

## The week

| Day | Session |
|---|---|
| Mon | Pull |
| Tue | Rest |
| Wed | Full body |
| Thu | Rest, futsal in the evening |
| Fri | Rest |
| Sat | Legs |
| Sun | Push |

Each session is five machine or Smith machine lifts, about 30 minutes, then 30 minutes on the
stairmaster. No cable stations. Wednesday's full body keeps its legs light because of Thursday's
futsal.

## The log

Tap **Log** under a session, enter the weight and each set's reps, and save. The page then:

- fills in next time's weight. When every set reaches the top of the rep range, it adds the smallest
  step (double progression);
- charts each lift's heaviest set per session;
- labels each lift **Stronger** when its latest session beats every one before it (more weight, or
  more reps at the same weight), and **Stalled** after three sessions without that.

**Rest timer:** typing a set's reps starts the rest, 90 s after a main lift and 60 s after the others, in a
bar at the bottom with **+30 s** and **Skip**. When it's up the phone buzzes (Android) and beeps.

**Signed in** (email and password), the log is saved online in Supabase, one row per session, and
shows up on any device you sign in on. Row-level security means each account can only read and
write its own rows. The key in `index.html` is Supabase's publishable key, which is public by
design. The first sign-in on a browser moves any log saved there into the account.

**Signed out**, the page still works, but the log is saved only in that browser's local storage,
and clearing the browser deletes it.

**Export backup** writes the log to a JSON file; **Import backup** merges one back in.

**Copy for Claude** (under Check-in) copies the last 28 days as plain text: the plan, each session
logged, and every lift's first and latest sets with its Stronger/Stalled label. Paste it into Claude or
another AI for a summary. Sessions start at your first log if that's later, so earlier weeks don't count
as missed. Nothing is sent anywhere; it only goes to the clipboard.

## Development

One `index.html`: plain HTML, CSS and JavaScript, no build step. `supabase-js` and the fonts load
from CDNs.

The database lives in `supabase/`: the table and its row rules in `migrations/`, the auth settings
in `config.toml`. The same project also holds the tables for
[Protein Log](https://github.com/alirghase/protein-log), so one account signs in to both. With the [Supabase CLI](https://supabase.com/docs/guides/cli) linked to the
project, `supabase db push` applies new migrations and `supabase config push` applies the auth
settings.
