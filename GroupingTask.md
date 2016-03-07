# Introduction #

The grouping task allows to group images into groups (clusters). The interface presents a collection of images and bins to drag images into.

All images are initially shown in **full** size. Once they are moved into groups, the images are shown in **thumbnail** size.

The task type name is **grouping** (Needs to be configured in Task Types).

# Task parameters #

The task parameters allow to specify the maximum width and maximum height of the image.
The settings are separate for **full** and **thumbnail** modes.
```
<?xml version="1.0"?>
<grouping>
<full_max_height>600</full_max_height>
<full_max_width>600</full_max_width>
<thumbnail_max_height>100</thumbnail_max_height>
<thumbnail_max_width>100</thumbnail_max_width>
</grouping>
```


# Submitting tasks #

See cv\_mech\_turk package in ros-pkg. An example submission script is submit\_boxes\_to\_group.py.


# Results format #

The results are reported as XML documents for each submitted task:
```
<groups>
  <img group="1" id="1"/>
  <img group="-1" id="2"/>
  <img group="-1" id="3"/>
  <img group="-1" id="4"/>
  <img group="1" id="5"/>
  <img group="1" id="6"/>
  <img group="1" id="7"/>
  <img group="-1" id="8"/>
  <img group="-1" id="9"/>
</groups>
```

For each image in the input list, its group is reported. "-1" means the image was not placed in a group.