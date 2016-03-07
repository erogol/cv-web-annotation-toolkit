# Introduction #

Parameters allow to control internal features of the interface representation. The parameters have hierarchical structure similar to [ROS parameter server](http://pr.willowgarage.com/wiki/Parameter_Server).

```
<task >
<parameters>
<group ns="polygonal_display">
  <param name="number_control_points" value="true"/>
  <param name="tag_font_size" value="55" />
</group>
</parameters>

....

</task>
```

The parameters can be specified in the task definition XML.
Eventually, URL will be supported as well.

The parameters set in the task definition XML are stored in the namespace `/taskdef/`. In the example above, the full name of the first parameter is `/taskdef/polygonal_display/number_control_points/`

Right now only global parameters are supported. Local parameters may be handy.

# Parameters by component #

## Polygonal annotations ##

Parameter location `/taskdef/polygonal_display/`

  * **number\_control\_points** (true, **false**) - Controls, whether the control points of the polygons get numbered.
  * **tag\_font\_size** ( Number, **55**) - Sets the font size for the labels.
  * **show\_object\_tag** (**true**, false) - Controls, whether the objects are named. If set to false, the object tags will not appear on display. (starting version 0.1.16)

Example:
```
<parameters>
<group ns="polygonal_display">
  <param name="number_control_points" value="true"/>
  <param name="tag_font_size" value="25" />
  <param name="show_object_tag" value="false"/>
</group>
</parameters>
```

Minimum version: 0.1.11

## Tag display for bounding boxes ##

Parameter location `/taskdef/bbox2_marker/`

  * **show\_object\_tag** (**true**, false) - Controls, whether the objects are named. If set to false, the object tags will not appear on display.
  * **line\_alpha**  (**0.7**) - draw bounding boxes with this alpha value.

Example:
```
<parameters>
<group ns="bbox2_marker">
  <param name="show_object_tag" value="true"/>
  <param name="line_alpha" value="0.5"/>
</group>
</parameters>
```

Minimum version: 0.1.14