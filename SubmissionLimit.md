# Submission limits #

Evaluation server limits the user to N submissions to a particular challenge in any T days. Each challenge has separate limits.

To set the limits, edit the challenge from the challenge administration interface `/admin/evaluation/challenge/`. Set "Limit in N days" and "Limit to N submissions". These limits will apply to all users regardless of the superuser status.

Exemptions are assigned explicitly to a single user for a specific challenge, period of time and for a specific number of allowed submissions. The default exemption grants **2 submissions in a 1 week period**. To grant a default exemption, visit "all submissions page" page `/eval/all_submissions/`. The column on the right provides a link to grant the default exemption. The link may be used multiple times to grant 2\*K additional submissions.

To remove or create non-default exemptions, use admin interface directly. Visit `/admin/evaluation/submissionexceptions/` and choose the exception to edit or use "add new" to remove the existing exception.