# Introduction #

The annotation tool makes it easy to annotate image over Web. This is useful for Mechanical Turk and other uses. The tool takes an XML description of the user interface and produces required buttons for user interaction. When the input is finished, the tool generates the XML with the annotation.

# Examples by task #
  * [Putting a box around person](http://vm7.willowgarage.com/code/task.html?swf=label_generic&extid=eb50ffb3-2ba7-4a84-8bee-bcdf4087fe0f-2285&session=person-dataset-session-4&task=PersonBoxOnly&video=person-dataset-session-4&frame=f1f924e9-2328-4181-aae8-837078bd2096&img_base=http://vm7.willowgarage.com/&mode=demo&swf_w=700&swf_h=700&instructions=http%3A//pr.willowgarage.com/wiki/ROS/mturk/instructions/personBox)
  * [Person skeleton](http://vm7.willowgarage.com/code/task.html?swf=label_generic&extid=8a587c6b-d533-48f0-8919-9a7f402dd73c-1&session=person-14-s&task=human-stick-figure&video=person-14-s&frame=eb1992ae-7792-4e79-bfb3-b6c787a4ba0d&img_base=http://vm7.willowgarage.com/&mode=MT2&swf_w=700&swf_h=700&instructions=http%3A//pr.willowgarage.com/wiki/mturk/instructions/PersonSkeleton&ExtID=8a587c6b-d533-48f0-8919-9a7f402dd73c-1&ExtID=8a587c6b-d533-48f0-8919-9a7f402dd73c-1)





# Example - input #

The [first example](http://vision-app1.cs.uiuc.edu/code/generic2.html?swf=label_generic&swf_w=700&swf_h=700&img_base=http://vision-app1.cs.uiuc.edu/&video=VOC2008&frame=2007_003143&task=car&mode=demo) shows a basic interface of the tool with its core features. The interface allows to segment the sky and the road; mark people people and cars.

The cars are interesting. After marking several cars, the interface zooms in to each one and we can mark additional parts of the car. Notice how we can mark car attributes and use different tools to mark the mirrors and the doors.

After all input is finished, hit the submit button. The tool will generate an XML file with all the data provided. This XML could be submitted to any server or used in javascript to do something else.

There is little magic in the XML files used by the tool. The interface in the example is defined by [this file](http://vision-app1.cs.uiuc.edu:8080/tasks/car.xml). It is absolutely functional - we simply list what we are looking for and what type of interface fits best: checkbox, bounding box, segmentation or a polygon.

# Example - display #

The ability to input data is nice, but we sometimes want to take a look at the result. Conveniently, the tool can show the annotations on the image. In the
[second example](http://vision-app1.cs.uiuc.edu/code/generic2.html?swf=label_generic&swf_w=700&swf_h=700&img_base=http://vision-app1.cs.uiuc.edu/&video=VOC2008&frame=2007_003143&task=car&mode=display&annotationID=demo_annotation3) we took our annotations and saved them in the file ([demo\_annotation3.xml](http://vision-app1.cs.uiuc.edu/annotations/demo_annotation3.xml)). The tool will load the image, task definition and the result from the server.

The XML format is simple as well. An interesting part is the segmentation format. The segmentation masks are stored separately and only references are kept inside the XML.

<a href='Hidden comment: 
= Example - edit =

To edit the annotations, we simply set the *mode* variable to "edit". This tells the interface to load the data (image, task specification,the annotations) and switch into edit mode.  In the
[http://vision-app1.cs.uiuc.edu:8080/code/generic2.html?swf=label_generic&swf_w=700&swf_h=700&img_base=http://vision-app1.cs.uiuc.edu:8080/&video=VOC2008&frame=2007_003143&task=car&mode=edit&annotationID=demo_annotation3 third example] we can modify the annotations by clicking on the annotated boxes and moving the resize markers. To edit hierarchical annotations, it is necessary to select the top level box (car) first and then select a child box.
'></a>


---

Questions? Send me an e-mail.