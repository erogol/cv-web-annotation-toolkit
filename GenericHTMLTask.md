# Overview #

Any HTML task format allows to create fairly arbitrary task definitions and ensure that the task can be efficiently managed. The HTML page gets several pre-defined parameters that define the task, data, pre-existing annotations and desired action. The page is responsible for handling all user interactions and submitting the outcome back to the server.

Work management server provides data storage, user interfaces, grading interfaces, adjudication, statistics, work time tracking, budgeting, etc.

# URL parameters #

  * **mode** - interaction mode: display, input, edit
  * **extid** - unique ID of the data item that we are working on ( e.g. 50a67b7b-5bf5-46a6-947e-8e176267c155-1). It should be submitted back.
  * **instructions** - URL to the instructions page.

  * **parameters\_url** - parameters common to all tasks in the session. (e.g http://vm7.willowgarage.com/tasks/test-any-html.xml)
  * **data\_url** - parameters of this specific work unit (e.g. image ID) (e.g. http://vm7.willowgarage.com/mt/hit_parameters/50a67b7b-5bf5-46a6-947e-8e176267c155-1/ )
  * **annotation\_url** - pre-existing annotations that the interface renders for display. (e.g. http://vm7.willowgarage.com/mt/submission_data_xml/56909/50a67b7b-5bf5-46a6-947e-8e176267c155-1)

# Naming conventions #

The work management server uses naming conventions to determine which fields are relevant to the submission and which should be ignored:
  * `A_.*` - All form fields starting with "`A_*`" designate attributes of interes.
  * (future) `Annn_.*` - designated attributes for multiple objects. **nnn** is a sequence of numbers.
  * **extid** - reference to the work unit
  * **assignmentId** - the ID of the assignment for Amazon Mechanical Turk
  * **workerId** - worker ID
  * **mode** - the mode value
  * (future)**start\_time** - when the page started loading
  * **load\_time**
  * **submit\_time**
  * Submit button must have id "submitButton" for disabling in Mechanical Turk e.g. `<input type=submit id="submitButton">`

# Reference implementation #

Reference implementation is given in [/code/any.html](http://code.google.com/p/cv-web-annotation-toolkit/source/browse/trunk/django/web_annotations_server/mturk/code/any.html). It shows how to have two images and a number of attributes.

**verbosity** variable controls whether the XML of task definitions are displayed on the page or hidden.

# HTML library #

The HTML helper library (any.js and mt.js) provides handling of generic data for display and edit modes. They parse work XML unit and submission XML and fill out form and image elements with the task and submission properties. To support default interaction, the HTML file doesn't need to do anything.

**mt.js** (function mt\_load\_task\_componentes) handles asynchronous requests to the server to download all the data necessary. Once the data is ready, it calls the client callback to parse the data and show it on the page.

**any.js** provides a generic callback (anyall\_loaded\_handler) to parse the data and put attributes and image URLs into the form.

# Generic data format #

This data format is only relevant to **any.js**. The HTML interface is free to use any other format.

The two main files here are "work\_unit" and "submission".

Here's the example work unit for reference implementation [any.html](http://code.google.com/p/cv-web-annotation-toolkit/source/browse/trunk/django/web_annotations_server/mturk/code/any.html).
```
<work_unit id="70207c9a-ebf5-11de-934d-002618ddf133">
  <img id="6379d996-ebf5-11de-bc50-002618ddf133" sqn="1" 
     tgt="img_0001" 
     src="http://vm7.willowgarage.com/frames/modelling-eraser-1-p/464f3d00-e308-49b8-8c66-99a3f6aab88f.jpg" 
     tags="modelling"/>

  <img id="68e6fbb6-ebf5-11de-afee-002618ddf133" 
     sqn="2" 
     tgt="img_0002" 
     src="http://vm7.willowgarage.com/frames/modelling-naked-orange-mango-2-p/a9f39403-605f-4e2a-a9db-1cbf0377a76b.jpg" 
     tags="modelling/"/>
</work_unit>
```

It contains a sequence of <img> elements with 3 important attributes:<br>
<ul><li><b>id</b> is the unique identifier for the image<br>
</li><li><b>tgt</b> determines the ID of the HTML IMG elements to display this image (<code>id="A_&lt;tgt&gt;"</code>)<br>
</li><li><b>src</b> gives the SRC of the image.</li></ul>

The submission XML is a sequence of attributes with (tgt,value) pairs. <b>any.js</b> puts the respective attribute values into the HTML form fields with corresponding names (<code>A_&lt;tgt&gt;</code>):<br>
<br>
<pre><code>&lt;submission ref-hit="50a67b7b-5bf5-46a6-947e-8e176267c155-1" <br>
            ref-session="test-anyhtml" <br>
            ref-submission="56909"&gt;<br>
  &lt;comments text="asdada"/&gt;<br>
  &lt;attribute id="1" tgt="img_0001_description" value="test-asd"/&gt;<br>
  &lt;attribute id="2" tgt="img_0001_object" value="test"/&gt;<br>
  &lt;attribute id="3" tgt="img_0001_person" value="on"/&gt;<br>
  &lt;attribute id="4" tgt="img_0002_person" value="on"/&gt;<br>
&lt;/submission&gt;<br>
</code></pre>




<h1>Client library</h1>

Client interaction is provided by two tools in cv_mech_turk2 package:<br>
<br>
<b>submit_work_units.py</b> gets a list of xml files and creates one work_unit (HIT) for each file.<br>
<br>
<b>get_raw_session_results.py</b> downloads good or all results from the session.