# Gym Plan

A three-day machine programme on one page, with a weights log that shows whether each lift is
getting stronger.

Live at **https://alirghase.github.io/gym-plan/**.

## The week

| Day | Session |
|---|---|
| Mon | Pull |
| Tue | Rest |
| Wed | Full body (optional) |
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

The log is saved in the browser's local storage on the device you use. Nothing is sent anywhere.
**Export backup** writes it to a JSON file; **Import backup** merges one back in.

## Development

One `index.html`: plain HTML, CSS and JavaScript, no build step and no dependencies. Fonts load
from Google Fonts.
