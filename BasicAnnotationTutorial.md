# Introduction #

We do annotation through [mturk.com Amazon Mechanical Turk]. To simplify the process of annotation we store images and task definitions on an **annotation server**. The annotation tasks are grouped in sessions. For each task in the session, we want exactly one annotation.

In this tutorial we will annotate 5 images with bounding boxes of people. We will go through the following steps:
  * Define an annotation task
  * Create a sandbox session (no real workers)
  * Submit one image to sandbox and try it out.
  * Create an annotation session
  * Upload our images to the annotation server
  * (wait for the work to complete)
  * Manually grade the submissions
  * Approve and Reject work
  * Request the bad submissions to be re-done
  * ... Repeat ...
  * Download all results.


# Step by step #

## Annotation task ##

To skip this step use **person-box-predefined** as your task instead of "my-person-box".

To create annotation task, go to /admin/mturk/task and click add.

Choose a name for your task e.g. "my-person-box", set task type to be **gxml**.

![http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/tutorials/basic_annotation/ex_add_task_1.png](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/tutorials/basic_annotation/ex_add_task_1.png)

To declare that we want only bounding box of a person, use the following interface XML:
```
<?xml version="1.0"?>
<task id="000001" type="image">
  <targets>
     <target name="person"> <annotation type="bbox2" /></target>
  </targets>
</task>
```

There's a large number of features available. Check out AnnotationTaskDesign for documentation on other annotation elements.

Put instructions URL there. This URL will appear on every task page. I usually use a wiki page for instructions.

Fill out title, description and keywords. These will appear on Amazon's web site. Make sure they are clearly represent the tasks and are appealing enough. Phrases like "very easy" are OK, if they are truthful.

**Reward** is the amount in US dollars that we guarantee for each correctly completed task. Note that Amazon will take 10% of this, but at least 0.005. So if the task is super-easy and you pay $0.01, it will lead to 50% overhead.

You can leave all others with default values. They correspond directly to Amazon Mechanical Turk HIT properties.

Your task now looks something like:
![http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/tutorials/basic_annotation/ex_add_task_2.png](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/tutorials/basic_annotation/ex_add_task_2.png)
![http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/tutorials/basic_annotation/ex_add_task_3.png](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/tutorials/basic_annotation/ex_add_task_3.png)


## Creating a sandbox session ##

To create a session, go to the admin interface (/admin/mturk/session/). Hit add session.

![http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/tutorials/basic_annotation/ex_add_session.png](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/tutorials/basic_annotation/ex_add_session.png)

Choose a unique code for the session (something like my-person-box-session-s). We recommend to add "-s" for sandbox sessions and "-p" for production sessions.

Choose your task definition from the drop-down list.

Choose a [funding account](FundingAccount.md). See how to create a [funding account](FundingAccount.md).

Make sure the sandbox flag is ON. This flag determines whether this session works with real production system.

Set the HIT limit appropriately. This is a safety check. The session will not accept new images after it gets to the HIT limit. In this case, 100 is fine. If you plan to have fewer and more expensive HITs, set it lower. If you need 1000s, you must make this number higher.

Put yourself as an owner. When you go to the main page of mechanical turk module (/mt/), you will see this new session in the list of your sessions.

We don't need to touch advanced options now, so just save the session.

You can now go to the session list at /mt/ and see the session you just created.


## Submitting a single image to the session ##

Most of the work with the session starts from session dashboard. The get there, go to /mt/ and click on the session you've just created. Different sections of the dashboard are marked with headers. There's lots of options, but we'll use only a couple right now.

Scroll down to **Upload** section and click "Single image".

![http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/tutorials/basic_annotation/ex_upload_section.png](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/tutorials/basic_annotation/ex_upload_section.png)

This will bring you to the upload image page. Choose an image to upload and hit submit. You should get a message  "done. Activated 1" saying that the submission is successful.

Now go back to the session dashboard(the back button in the browser is very helpful here). If you refresh it, you will see that there is now 1 task out of 100 and no submissions. In this case, we will do the work ourselves.

Go to "Tasks" section and click "On MechTurk" link. The link says "(sandbox)" to indicate where it'll take you. You will see your task there. Now click "Accept HIT" at the top of the page. This will reload the page and remove funny text over the picture.

Now you can click on the "person" button, draw the box, click done and adjust the rectangle if necessary. Actually, you could've read the instructions as well.

Now that you are done with annotations, click "submit". At this moment, the web page sends the results to the annotations server and the server returns confirmation for Mechanical Turk. The confirmation is automatically submitted to Amazon.

We can now go back to the session dashboard and observe our submission. The sandbox and production session are essentially the same (except the production one involves real money and real workers). If you want to get the sandbox annotations out of our sandbox session, you can follow the same procedure that we will go through for the production session.

## Creating a production session ##

To create a production session, we follow exactly the same steps as for the sandbox session, except we name the session with "-p" and uncheck the "sandbox" checkbox. Go to /admin/mturk/session/add/, choose a unique code e.g. my-person-box-session-p, choose the task type, uncheck "sandbox", hit save.

## Uploading images to the session ##

We will now upload a folder with images to the production session. You can get an example  ([five\_images\_with\_people.tgz](http://cv-web-annotation-toolkit.googlecode.com/files/five_images_with_people.tgz)) from the downloads section.

Go to the session dashboard and scroll down to upload section and choose "single folder with images". Choose the file and hit upload. Now the tasks are on real Mechanical Turk.

From the dashboard you can go to the Mechanical Turk interface and see your tasks there.

## Wait for the work to complete ##

This is the unfortunate part of Mechanical Turk. We must sit and wait. We have little control over when people will actually do our tasks. Here's a few things that can help:
  * Pay well. The more you pay, the more people will be interested.
  * Make the tasks short and easy. You aren't hiring people hourly.
  * Post lots of HITs

Now, as we've posted only 5 HITs, it may actually take quite a while to complete. You will see very different response times at 2000 HITs.

## Manual grading ##

![http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/tutorials/basic_annotation/ex_grading.png](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/tutorials/basic_annotation/ex_grading.png)

Now that we got all the submissions, we need to grade them. Grading assigns one of 3 quality value to each submission:
  * bad - the submission is rejected. It doesn't follow instructions, clearly malicious, no effort put into the assignment, etc.
  * good with errors - the submission is approved, but the results aren't good enough for us to use. It needs to be re-done (or corrected). We may choose to pay to a worker who put significant effort, but missed something (e.g. someone marked 9 out of 10 objects in the image)
  * good - the submission is approved and the results are ready to use.

There are multiple ways to do manual grading. In this example we will simply grade all submissions. Go to the **Grading** section and click on "Grading paged".


You will see all submissions 10 per page. Each submission will have the annotation interface with both task controls and the submitted annotation; worker ID and the comments they might have provided. There is a link to the XML representation of the submission, should you need to inspect something.

The grades are set to "good" by default. If all work is good, grading is absolutely effortless. You can choose the different grade and type in the comment. The workers will receive the comment as message for approval or rejection of their work.

Normally, you don't need to submit each individual grade and simply click "submit" on the bottom of the page. You will see "submitting.." messages turn into "+" signs after the submission is done. Wait for all of them to get submitted.

Manual grading may appear to be tedious, but it really is much easier than doing all the work yourself. Mechanical Turk isn't a magic wand. It's really a power tool.

## Approving and Rejecting the submissions ##

When the grading is complete, the system can make a decision which submissions must be approved and which rejected. To run the approval, scroll down to the "Approval" section in the session dashboard. There, click "Approve good results" and "Reject bad results" to respectively approve and reject the results.

When you refresh the session dashboard, you will see the counters on top of the page change. "Open" submissions will turn into approved and rejected. In general, **open** submissions are something that require your action. That's why the count of open submission is shown in the main session list.

## Redo ##

Now that we rejected some submissions, the HITs will go into inactive state, but we still don't have a good result for them. We need to request the redo pass explicitly. In the same **Approval** section, click "Resubmit the HITs that don't have a good result yet". This will cause all HITs that don't have a good result to be submitted.

Could we reject and resubmit at the same time? Probably. The separation of these two gives some exta freedom. For example, we don't have to reject submissions before we obtain a second set of annotations. We might want to obtain the best annotation and if the others deviate from it too much, we shall reject those.

## ... Repeat ... ##

We shall repeat the wait/grade/resubmit cycle until we get enough annotations. We mostly thing in terms of getting 100% of work done. This means that towards the end we will be invariably left with small sets of tasks (e.g. 10-50) and the throughput will go down quite significantly. If your application is fine with 90%-95% of all the work, you will be much better off.

## Download the results ##

The results are generally downloaded through `session_results*` programs in [cv\_mech\_turk2](http://www.ros.org/wiki/cv_mech_turk2) package of [ros.org ROS]. The results can be in custom XML format or as object masks. A format similar to a [VOC](http://pascallin.ecs.soton.ac.uk/challenges/VOC/voc2009/) dataset will be available in the future (see cv\_mech\_turk\_experimental package).

The server can generate and store the results for you. Simply go to the **Download** section and click one of the "create ...." link. The server will create a tar file and it should start the download right away. After you refresh the dashboard, you will also see the URL to the generated file.

What happens if you generate the results before any grading? They will be empty. The results generated here include only **good** results. I.e. the results with only **good** grades. Before we do grading, none of the submissions will qualify.

