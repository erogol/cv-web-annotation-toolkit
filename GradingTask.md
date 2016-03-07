# Introduction #

Grading tasks are designed to judge whether the work is performed according to required instructions. Grading is usually done by putting several submissions together on one page and asking to make a quality judgment.

# Naming conventions #

The default grading task is called "<task name>-grading". If the default grading task is present, the server can create automatically grading sessions for the work sessions. After the default grading is created, use session dashboard to submit tasks for grading.

# Grading task parameters #

There are several parameters that control how grading is done.
  * We can show **N** submissions per page. This is controlled by the variable **num\_per\_task** in `<layout>` element.
  * We can choose between **full** and **thumbnail** view of the tasks. **thumbnail** mode shows only the annotation, w/o any user interface.
  * We must specify the width and the height of the frame that will show the annotation. Unfortunately, it can't be set dynamically. Use **frame\_w** and **frame\_h** to set this.
  * [DEPRECATED](DEPRECATED.md). Please set **overlap** to 0.0.

  * To obtain multiple grades, create two separate grading sessions and establish the exclution links between them. Grading sessions created from dashboard will have exclusion links set automatically.

Here's a complete example of grading task definition. This grading task will show 10 submissions per page in 800(w)x700(h) IFRAMEs.

```
<?xml version="1.0"?>
<grading>
<sampling overlap="0.0"/>
<layout mode="full" num_per_task="10" frame_h="700" frame_w="800"/>
</grading>
```