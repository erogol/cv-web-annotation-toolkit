## Summary ##

We compared 400 HITs done without qualification v.s. 400 HITs done with qualification requirement. The qualification requirement improved the overlap on average by **0.22** per bounding box of the gold standard. The plot shows overall improvement:

<img src='http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/comparison_percentage_bb.jpg' height='600' />

## Status ##

Finished. Successfully demonstrated quality improvement with qualification requirement.

## Setup ##

We run annotation of 100 images with bounding boxes of 20 Pascal VOC object categories. All 20 categories were split into 4 groups of 5 objects and each group was annotated independently. As a result, there were 400 annotation tasks in each run.

Run 1. The annotation were provided with $0.02 reward. No qualification requirement has been imposed. Minimum approval rating of 90% was required.

Run 2. Simple qualification test requirement was added. Minimum approval rating requirement was kept at 90%.



### Qualification test used ###

The XML definitions for this qualification are [given on a separate page](MturkQualificationEvaluationQualificationText.md).

![http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/img1_i.png](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/img1_i.png)
![http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/img1_q.png](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/img1_q.png)

---

![http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/img2_i.png](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/img2_i.png)
![http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/img2_q.png](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/img2_q.png)

---

![http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/img3_i.png](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/img3_i.png)
![http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/img3_q.png](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/img3_q.png)

---


## Results ##

The improvements in quality are very significant. The number of bad submissions went significantly down at the expense of the time it took to obtain annotations.

The overall improvement is **0.22** overlap score per bounding box. The number of quality submissions is significantly improved:

<img src='http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/comparison_percentage_bb.jpg' height='600' />

The same distribution can be seen in a histogram form:

<img src='http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/copmarison_overlap_hist.jpg' height='600' />

The improvement for seems to happen at all levels of the bounding box size. However, the overlap score for small boxes is smaller than for larger boxes.

<img src='http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/copmarison_overlap_vs_size.jpg' height='600' />

By class:
[aeroplane](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/comparison_percentage_bb_by_class_aeroplane.jpg)
[bicycle](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/comparison_percentage_bb_by_class_bicycle.jpg)
[bird](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/comparison_percentage_bb_by_class_bird.jpg)
[boat](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/comparison_percentage_bb_by_class_boat.jpg)
[bottle](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/comparison_percentage_bb_by_class_bottle.jpg)
[bus](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/comparison_percentage_bb_by_class_bus.jpg)
[car](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/comparison_percentage_bb_by_class_car.jpg)
[cat](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/comparison_percentage_bb_by_class_cat.jpg)
[chair](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/comparison_percentage_bb_by_class_chair.jpg)
[cow](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/comparison_percentage_bb_by_class_cow.jpg)
[diningtable](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/comparison_percentage_bb_by_class_diningtable.jpg)
[dog](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/comparison_percentage_bb_by_class_dog.jpg)
[horse](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/comparison_percentage_bb_by_class_horse.jpg)
[motorbike](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/comparison_percentage_bb_by_class_motorbike.jpg)
[person](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/comparison_percentage_bb_by_class_person.jpg)
[potted plant](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/comparison_percentage_bb_by_class_pottedplant.jpg)
[sheep](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/comparison_percentage_bb_by_class_sheep.jpg)
[sofa](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/comparison_percentage_bb_by_class_sofa.jpg)
[train](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/comparison_percentage_bb_by_class_train.jpg)
[tvmonitor](http://cv-web-annotation-toolkit.googlecode.com/svn/wiki/experiments/eval_mturk_qualification/comparison_percentage_bb_by_class_tvmonitor.jpg)


## Code ##
The code for running the experiment is in SVN.
The code for plotting and analysis is available upon request. (Hopefully it'll be checked in soon as well).

## Data ##
Available upon request.