# Introduction #

It is often necessary to ensure that the same person can't participate in two sessions. This is useful for several tasks:
  * Prevent conflict of interests (e.g. between annotation and grading)
  * Obtain two disjoint grading results (exclude grading1 and grading2)
  * Run experiments with disjoint participant sets.

We implement exclusion as a bi-directional relation between 2 session with a human-readable comment. The comment is shown to the worker when we detect conflict.

To create exclusion, go to the administration interface:
`/admin/mturk/sessionexclusion/add/`



# Automatic exclusion rules #

  1. Automatic exclusion rules are created for the grading session, when it is created through session dashboard.
  1. Automatic exclusion rules are created between the grading sessions, when they are created through the session dashboard.

# Advisory notes #

At present, we can't prevent people from accepting the HITs from which they are excluded. As such, it's better to not have two grading sessions simultaneously. Having them together, would confuse people, because they'll get "you can't do this" for every other task they accept.


