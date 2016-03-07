`http://128.174.241.84:8080/datastore/register_images/<dsname>/`

(e.g. http://128.174.241.84:8080/datastore/register_images/LabelMe/)

We assume that the images are already in the /var/datasets/LabelMe/. We traverse the folder recursively and add every file as DataItem object.


---


`http://128.174.241.84:8080/datastore/register_voc_boxes/<dsname>/`

(e.g. http://128.174.241.84:8080/datastore/register_voc_boxes/VOC2008/)

Register the bounding boxes from VOC2008 annotations.
We assume that the annotations are in `/var/datasets/<dsname>_annotations/`; one xml file per data item. We will simply add a bounding box for every object in the annotations.


---


http://128.174.241.84:8080/datastore/register_labelme_boxes/LabelMe/

Register the polygonal annotations from LabelMe as bounding boxes.
We assume that the annotations are in `/var/datasets/<dsname>_annotations/`; one xml file per data item. We will simply add a bounding box for every polygonal annotation.