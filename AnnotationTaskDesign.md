# Introduction #

The annotation tool is designed to be a modular component for easy integration into web applications. The annotation tool supports 3 major modes: input, display and edit(where implemented). In the **input** mode, the tool gets the image and the task definition and produces the XML annotation. In **display** mode, the tool gets the task definition, the image and the XML annotation. The tool then renders the annotation. In **edit** mode, the tool loads the task definition, image, XML annotation and allows to change the annotation.

# Tool arguments #

  * **mode**: {input,display,edit}
  * **img\_base**: The URL of the server. Must match the server hosting the Flash interface.
  * **image\_url**: The URL of the image to work on. The URL must include the name of the server.
  * **task\_url**: The URL of the task definition.
  * **task**: The name of the task. It is mapped onto `<server>/tasks/<task>.xml` file. The file is served. **task\_url** is the preferred way to specify the task.
  * **assignmentId**: The ID of the assignment. When set to ASSIGNED\_ID\_NOT\_AVAILABLE, the interface will disable any input. This indicates a "preview" mode in Mechanical Turk.
  * **annotation\_url** : The URL of the existing annotations. The annotations will be loaded in display or edit modes.


# Tool definition XML #
The actual annotation interface is defined by the XML task definition. At a high level, the task definition contains a list of targets and the type of annotation for each target.
For example, if we want outlines of obstacles and the bounding boxes around people, we would write:

```
<?xml version="1.0"?>
<task id="000001" type="image">
<required_version release="0" major="1" minor="9"/>
  <targets>
     <target name="obstacle"> <annotation type="outline" /></target>
     <target name="person"> <annotation type="bbox2" /></target>
  </targets>
</task>
```

This example is sufficient to design simple tasks. There are many useful advanced features. See TaskDefinitionXML for complete specification and more examples.

## Bounding box annotations ##

Bounding box annotations are defined with `<annotation type="bbox2" />` declaration.

When the user clicks on the input token, the interface will request annotations of **multiple** bounding boxes. The user clicks and drags to produce a bounding box. The boxes can be edited and deleted (using undo).

## Polygonal annotations ##

Polygonal annotations are defined with `<annotation type="outline" />` declaration.

When the user clicks on the input token, the interface will request annotation of a **single** outline. The outline is finished when the user clicks on the first control point again.

Polygonal annotation can display the control point numbers. See [DisplayParameters](DisplayParameters.md) section for details.


## Polygonal annotation with a label ##

Use `<annotation type="outline_text"/>` to create one. It will require the user to input a label and explicitly click "done" after the polygon input is finished. It requires one more click compared to plain polygonal annotation, but is more expressive.

## Binary Flags ##

The flags represent simple binary properties of the image. They are defined with `<annotation type="presence"/>` declaration. Each binary flag will be shown as a checkbox.

## Multiple Choice Question ##

Multiple choice question is defined with `<annotation type="select">`.

For example:
```
                <annotation type="select">
                  <option name="Unspecified"/>
                  <option name="Female"/>
                  <option name="Male"/>
                </annotation>
```

## Recursive annotations ##

Recursive annotations are defined with `<annotation type="2level">` declaration. The declaration contains two children: level1 and level2. Level 1 declaration must be
`<level1>  <annotation type="bbox2" /> </level1>`. This represents that the user has to draw bounding boxes of the objects. Level 2 declaration defined the full interface for the annotation.


```
     <target name="person">
        <annotation type="2level">
          <level1>  <annotation type="bbox2" /> </level1>
          <level2>
            <targets>
              <target name="part"> <annotation type="presence"/></target>

              <target name="gender">
                <annotation type="select">
                  <option name="Unspecified"/>
                  <option name="Female"/>
                  <option name="Male"/>
                </annotation>
              </target>

              <target name="head"> <annotation type="outline"  /></target>
              <target name="hand"> <annotation type="outline" /></target>

            </targets>
         </level2>
        </annotation>
      </target>
```


## Fixed topology graph annotations ##

It is often useful to annotate with a fixed layout. An example could be landmarks on human face or joint locations of a person. The graph is specified by:
  * a list of nodes with names (internal representation), labels for display, tags for display in the image and colors (random by default)
  * a list of undirected edges specified as pairs of nodes plus a color (black by default).

An example setup for annotating people is here:
```
     <target name="stickman">
       <annotation type="graph">
         <nodes>
           <node name="left-wrist" label="left wrist" tag="lW" />
           <node name="left-elbow" label="left elbow" tag="lE" />
           <node name="left-shoulder" label="left shoulder" tag="lS" />
           <node name="right-shoulder" label="right shoulder" tag="rS" />
           <node name="right-elbow" label="right elbow" tag="rE" />
           <node name="right-wrist" label="right wrist" tag="rW" />

           <node name="left-ankle" label="left ankle" tag="lA" />
           <node name="left-knee" label="left knee" tag="lKn" />
           <node name="left-hip" label="left hip" tag="lH" />
           <node name="right-hip" label="right hip" tag="rH" />
           <node name="right-knee" label="right knee" tag="rKn" />
           <node name="right-ankle" label="right ankle" tag="rA" />

           <node name="neck" label="neck" tag="N"  color="0xFFFF00"/>
           <node name="top-of-the-head" label="top of the head" tag="HD" color="0xFFFF00"/>
         </nodes>

         <links>
           <link from="left-wrist" to="left-elbow" color="0x0000FF"/>
           <link from="left-elbow" to="left-shoulder" color="0x0000FF"/>

           <link from="right-shoulder" to="right-elbow" color="0x00AF00"/>
           <link from="right-elbow" to="right-wrist" color="0x00AF00"/>

           <link from="left-shoulder" to="neck" color="0xFFFF00"/>
           <link from="right-shoulder" to="neck" color="0xFFFF00"/>
           <link from="neck" to="top-of-the-head" color="0xFFFF00"/>

           <link from="left-ankle" to="left-knee" color="0x0000FF"/>
           <link from="left-knee" to="left-hip" color="0x0000FF"/>
           <link from="right-ankle" to="right-knee" color="0x00AF00"/>
           <link from="right-knee" to="right-hip" color="0x00AF00"/>

           <link from="left-shoulder" to="right-shoulder" color="0xFF0000"/>
           <link from="left-shoulder" to="left-hip" color="0xFF0000"/>
           <link from="left-hip" to="right-hip" color="0xFF0000"/>
           <link from="right-shoulder" to="right-hip" color="0xFF0000"/>

         </links>
       </annotation>
     </target>
```

min required version: 0.1.13

## Inline instructions ##

Sometimes it's handy to stick some short text between the buttons or checkboxes. We implemented a special "instructions" annotation type that will create a simple textbox with the text. You need to specify **heigh** for it. It doesn't work terribly well (due to limitations of the Flash rendering of this HTML), but allows you to stick in a small piece of text. E.g.:

```
<target name="person-fully-visible-instructions" > 
   <annotation type="instructions" height="60">
      <html>(check if there is *no* part of the person
      that is blocked by a table/chair/wall/etc)</html>  
   </annotation>
</target>
```

**Note** that your HTML must be formatted as true XML, because it's a part of an XML document.


## Ordering of the targets ##

The annotation interface will create the targets in the order in which they appear in the XML definition. The first 12 targets will have keyboard shortcuts associated with them. The keys are `qwerasdfzxcv` in this order.







# Tool output #

The annotation interface tool outputs an XML document representing the annotations. The annotations are represented in the coordinate frame of 500x500 box. The image is scaled and centered in that box.


An example annotation (1 person and 1 obstacle) is shown below:
```
<results>
<image url='http://127.0.0.1:8080/frames/VOC2008/2007_004538.jpg' />
<annotation>
<size><width>480</width><height>367</height></size>
<polygon name="obstacle" sqn="1" >	
  <pt x="88" y="230" ct="1247310030932"/>
	<pt x="151" y="234" ct="1247310031382"/>
	<pt x="239" y="259" ct="1247310031821"/>
	<pt x="236" y="347" ct="1247310032247"/>
	<pt x="200" y="421" ct="1247310032864"/>
	<pt x="21" y="361" ct="1247310033688"/>
	<pt x="55" y="238" ct="1247310034960"/>
</polygon>

<bbox name="person" sqn="1" left="232.1" top="137" width="164" height="249">
	<pt x="232.1" y="137" ct="1247310039553"/>
	<pt x="396.1" y="386" ct="1247310040849"/>
</bbox>
</annotation>

<meta load_time="1247310026339" submit_time="1247310044429"/></results>
```

# Interface versions #

New versions of the flash tool come with added functionality and fixed bugs. For some reason, the flash GUI doesn't always updates quickly. To force the update, one needs to manually reload the flash file. This can be done by going to

```
/code/label_generic.swf
```

and clicking reload. The exact path depends on the location of the file and should be placed in the instructions.

To inform the users that they need to update the interface, the task definition XML supports **required\_version** tag.
```
<required_version release="0" major="1" minor="9"/>
```

would require the version 0.1.9 or later of the annotation tool. 0.1.9 is the version at which the annotation tool supports this feature. Earlier versions will ignore the tag.