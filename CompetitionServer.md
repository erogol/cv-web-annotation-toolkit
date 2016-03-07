# Introduction #

The server allows to upload submissions, it keeps track of the submitted results and calls custom processing engine to do checking/evaluation.

The evaluation is done in 2 steps:
  1. on upload, the content is verified and an error report is generated if the content is bad.
  1. An independent process visits all valid submissions and runs the evaluation. The result (score or error) is written to the submission.

# Components #

  * Django server. Does user registration, uploads the submissions, keep the status of the submissions and their scores.
  * Submission check function django/web\_annotations\_server/evaluation/eval\_VOCcheck.py
  * Standalone checking function django/web\_annotations\_server/evaluation/standalone\_evaluation.py
  * Matlab wrappers for VOC dev kit to run evaluation on submissions.


# Usage notes #

## eval\_VOCcheck.py ##

eval\_VOCcheck.py unpacks and checks the submission. It has the following parameters:

| Parameter | Meaning |
|:----------|:--------|
| `--submission=<path_to_file>`   | Full filename of the submission |
| `--work_root=<path_to_folder>`  | A place, where to extract the submission |
| `--report=<path_to_file>`       | report filename. |
| `--devkit=<path_to_VOCdevkit>`  | A path to VOC dev kit. We need image sets   |
| `--challenge=<challenge>` | Challenge year (VOC2008/VOC2009). Used to get the right image set |
| `--setname=<eval_set_name>` | The name of the evaluation set. E.g. **val** or **test** |

## standalone\_evaluation.py ##

  * requires PYTHONPATH to include django/web\_annotations\_server folder.
  * requires DJANGO\_SETTINGS\_MODULE=settings

  * Runs in an infinite loop with 5 second sleeps.

## Django server notes ##

  * Evaluation app needs:
    * [django-registration](http://code.google.com/p/django-registration/)
    * `settings.VOC_DEV_KIT='......../VOCdevkit'`
    * `settings.MCR_ROOT='......./MATLAB/MATLAB_Compiler_Runtime/v79'` (it can be any version, not necessarily v79)

# Access control #
  * Regular users
    * Can see only their submissions
    * Don't see scores of the challenged with "Is score visible=False"
  * Staff
    * Can see all submissions
    * Don't see scores of the challenged with "Is score visible=False"
  * Admins
    * Can see all submissions
    * Don't see scores of the challenged with "Is score visible=False" in the common interface
    * Can see all scores in the admin interface (/admin/)


# Installation notes (rough) #
  * Install django
  * Install django-users
  * Checkout the code of web\_annotations\_server
  * Install mysql (or other database server)
    * create database/user (see/edit settings.py for the actual values)
  * Edit settings.py to reflect local paths

  * Run python `manage.py syncdb`
  * Run python `manage.py runserver <host_ip_address>:8080`

  * Visit `http://<host_ip_address>:8080/` . It should be up.

  * Download and install [VOC dev kit](http://pascallin.ecs.soton.ac.uk/challenges/VOC/voc2009/).
  * Get matlab functions `web_annotations_server/evaluation/matlab_code` (e.g. from  [svn](http://code.google.com/p/cv-web-annotation-toolkit/source/browse/trunk/django/web_annotations_server/evaluation/matlab_code/))

  * Move all matlab functions to the VOC dev kit (including VOC/VOCinit.m)
  * Edit compile.m and put the right path to VOCcode
  * Run compile
  * Set environment variables
    * export PYTHONPATH=...../web\_annotations\_server:$PYTHONPATH
    * export DJANGO\_SETTINGS\_MODULE=settings
  * Run web\_annoations\_server/evaluation/standalone\_evaluation.py

  * Hint: use [screen](http://www.gnu.org/software/screen/) to make sure the processes doesn't depend on the ssh connection.

## Sanity checks ##
  * Log into the admin web site.
    * Create a new challenge VOC2009\_val
      * Check "is open" and "is score visible".
      * Put some existing path into the data root.
      * Put this as evaluation engine `/var/django/web_annotations_server/evaluation/eval_VOCcheck.py --challenge=VOC2009 --setname=val --devkit=/home/sorokin2/voc_data/VOCdevkit`

  * Download the [tests file](http://cv-web-annotation-toolkit.googlecode.com/files/voc_submission_tests.tgz), unpack it.
  * Register on the web site and upload all tasks to the web site. Some of them will fail, some of them will go into "evaluation" state.
  * Eventually, all tasks will be in either **evaluation failed** or **evaluation done** states.

## Running inside apache ##
  * Not supported right now. Issues:
    * Admin templates don't work
    * "/" can't be mapped to django, while allowing other sites to exist.