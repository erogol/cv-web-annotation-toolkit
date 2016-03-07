# Procedure #

Procedure:
  1. Create sandbox session. Use task type GXML. Make 4 HITs to be the max limit.
  1. Upload [images.tgz](http://cv-web-annotation-toolkit.googlecode.com/files/images.tgz) - it should create 4 tasks in the sandbox. It should report that it exceeded the HIT limit on 2 tasks.
  1. Relax the HIT limit to 10.
  1. Upload images.tgz again - it should report that all images have been ignored, because they are already there.
  1. Go to session dashboard and follow the link to tasks on MTurk. Check that you see the images submitted.
  1. Go back to the session dashboard. Click **Expire all outstanding hits from this session.**. Check that the HITs have disappeared from Mturk.

Outcomes:
  1. Pass all
  1. Fail on step N

Test results:
http://spreadsheets.google.com/pub?key=t8s3_kG5mNl8GH_duroMogA&output=html