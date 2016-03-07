# Introduction #

Attributes task displays a number of data items (e.g. 10 images) in a table. For each data item it requests a number of attributes to be specified by the worker. In this task, attribute is a simple HTML Form field with a particular name.

# Task interface XML #

The attribute task specification is an XML document containing 3 major parts: attributes list, table header and table row content.

```
<?xml version="1.0"?>
<task id="000001" type="attributes">
<attributes>
 .................
</attributes>


<header_html>
 ................
</header_html>


<display_html>
 ...................
</display_html>

</task>
```

Each attribute should appear in all 3 parts. In the attributes part, we simply list each attribute:
```
<attributes>
 <attribute id="sex"/>
 <attribute id="occluded"/>
 <attribute id="pose"/>
</attributes>
```

In the future, attribute properties such as "required" may be added here.

In the table header part, we simply specify human-readable content.
```
<header_html>
<th>Male</th> 
<th>Female</th> 
<th>Occluded</th> 
<th>Pose</th>
</header_html>
```

Notice how we added two columns for the sex attribute. This is to match our later representation of the sex as two radio buttons. Here we have complete freedom over the choice of the HTML elements.

Finally, the actual table row should contain the definition of the actual controls:
```
<display_html>

<td><input type="radio" name="ATTR_sex" value="male"  /> </td>
<td><input type="radio" name="ATTR_sex" value="female"/></td>

<td><input type="checkbox" name="ATTR_occluded" /></td> 

<td><select name="ATTR_pose">
<option value="0" selected="1">(please select:)</option>
<option value="1">one</option>
<option value="2">two</option>
<option value="3">three</option>
</select>
</td>
</display_html>
```

This HTML is a template. When we instantiate it, we will replace "ATTR" with the object ID for which this attribute is specified. This way, we'll have multiple form elements for different objects and attributes.


# Work unit XML #

Each work unit contains a sequence of items whos attributes we want:

```
<?xml version='1.0'?>
<items>
  <item id="VIDEO_1_ID" type="video" src="/frames/session-test/video1.flv"/> 
  <item id="VIDEO_2_ID_STRING" type="video" src="/frames/session-test/video1.flv"/> 
  <item id="m59_sfm_c01_options.txt.masked3" type="image" src="/frames/session-test.jpg"/> 
</items>
```

The items could be either videos or images. Both contain "src" attribute to specify the image/video URL. Note that video URLs must be local(from the same server). Image URLs can point anywhere.