# Accounts #

| Username | Password | Description |
|:---------|:---------|:------------|
|demo\_admin | admin13579 | Super user account can access the admin interface (/admin/) and do anything with the data|
|demo\_guest | guest24680 | Limited access account can only view the data, but "add" operations are not permitted. |


To logout from the current user go to:
http://128.174.241.84:8080/logout/

# Server parts #

## Admin interface ##

Admin URL: http://128.174.241.84:8080/admin/

Built-in admin interface allows to add users, groups and permissions. The admin interface allows to see and edit any data item as it is stored in the database. **Datasets** and **Annotation types** can be edited using admin interface.

## Basic display and editing ##

  * Browsing images: http://128.174.241.84:8080/datastore/data/VOC2008/
  * Browsing a single image annotations: http://128.174.241.84:8080/datastore/dataitem/3/
  * Single annotation display: http://128.174.241.84:8080/datastore/show/annotation/3/

In the image browsing mode, the images are displayed 20 per page. Each image has a link to see the annotations associated with it. The annotations for the image are grouped by type. Each annotation is displayed separately.  A link ("more") goes to the detailed view of the annotation. "(+)" marks annotations with extra annotations attached to them (e.g. with quality judgments or comments).

Add annotations link goes to the page to add a new annotation.

Any annotation allows to add a quality mark and a comment. These are implemented to allow quality judgments associated with any annotation in the system.

Annotations can be added, but not erased. Unnecessary annotations will eventually be de-activated to remove them from display, but keep in the database.

## Flagging ##

We use flags to mark objects that require additional attention. To mark an annotation with a flag, one can simply click on the flag icon next to the annotation.

To browse the flagged annotations, one can go to

`http://vision-app1.cs.uiuc.edu:8080/datastore/show/flagged_annotations/<dataset>/<annotation_type>/<flag>/p1/`

(e.g.
http://vision-app1.cs.uiuc.edu:8080/datastore/show/flagged_annotations/VOC2008/voc2008_boxes/red/p1/ and http://vision-app1.cs.uiuc.edu:8080/datastore/show/flagged_annotations/VOC2008/voc2008_boxes/blue/p1/)

There are currently 3 [flags](FlagsAnnotation.md): red (something is really wrong with the annotation), blue(some improvements are possible) and white(the annotation/image shouldn't be considered at all).

## Advanced display ##

### Index/stats page ###

http://vision-app1.cs.uiuc.edu:8080/datastore/index.html

The index page displays the statistics of existing datasets. The numbers have links to all examples (and flags).


### All active annotations ###

`http://128.174.241.84:8080/datastore/show/annotated_images/<dataset>/<annotation_type>/p<page_number>/`

(e.g. http://128.174.241.84:8080/datastore/show/annotated_images/VOC2008/voc2008_boxes/p1/)

This display shows all annotations of a particular type.

### All examples of an object ###

The examples are found among voc\_bbox annotations. The examples are filtered using SQL `like '%<query>%'`. The examples are currently retrieved from all datasets.

`http://vision-app1.cs.uiuc.edu:8080/datastore/show/bbox_objects/<query>/p<page_number>/`

(e.g. http://vision-app1.cs.uiuc.edu:8080/datastore/show/bbox_objects/person/p585/ )



# Datasets #

  1. **VOC2008** is the training and validation subset of the VOC2008 dataset.
  1. **LabelMe** is a snapshot the [LabelMe dataset](http://labelme.csail.mit.edu/).


# Annotation types #

(see also http://128.174.241.84:8080/admin/datastore/annotationtype/)

|Category | Type | Explanation |
|:--------|:-----|:------------|
| bbox    | voc\_bbox | Axis-parallel bounding box with object type and confidence |
| flags   | flags | red or blue or white - flag mark |
| grade10 | quality | 1-10 quality score for the annotation |
| text    | comment | plain text comment |
| gxml    | voc2008\_boxes | Bounding boxes corresponding to VOC2008 annotations |
| gxml    | LabelMe\_boxes | Bounding boxes for LabelMe objects |
| text    | sentences  | plain text annotation |