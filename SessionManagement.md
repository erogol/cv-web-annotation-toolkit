# Introduction #

Session is a collection of tasks that we want to complete. The usual work flow is similar to this:
  1. Create a session
  1. Submit images (or other data) to the session
  1. Wait for the work to complete
  1. Perform grading
    * Manually
    * Via Turk
    * Automatically
  1. Adjudicate grades
  1. Approve/Reject submissions
  1. Request more work (for tasks with unsatisfactory results)
    * Resubmit HITs that don't have a good result
    * Repeat steps above
  1. Download session results:
    * Through cv\_mech\_turk package in ROS
    * Through "download" section on the session dashboard.


# Details #

## Creating a new session ##

In the admin interface, specify the following:
  * Session code (no underscores, please).
  * Task definition
  * Funding source (Who pays)
  * Hit Limit (How many hits are allowed maximum)
  * Task execution engine:
    * Standalone (no connection to MTurk)
    * Mturk sandbox (check "sandbox", **default**)
    * Mturk production (uncheck "sandbox")




## Creating new session in a program ##

You can create a new session as a copy of the existing session. Go to the following URL:

`/mt/copy_session/<from>/<to>/`

For example:

`http://vm7.willowgarage.com/mt/copy_session/gt-chowder-can-s/gt-chowder-can-copy-s/`

The response is either `"+ <session number>"` or `"- <session number> Already exists"`.

To get this done automatically, you can use:
  * Shell: `wget <url>` in shell
  * Matlab: `urlread(<url>) `
  * Python:
```
  import urllib2
  try:
        print url
        fp = urllib2.urlopen(url)
        response = fp.read()              

  except urllib2.URLError, reason:
        print reason
        return None
```