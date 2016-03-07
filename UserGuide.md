# Introduction #

> The web framework consists of different django applications and standalone components:
    * Mech Turk server (app **mturk**)
    * Competition server (app **evalution**)
    * Data storage server (app **datastore**)
    * Flash image annotation toolkit (flash tool **label\_generic**)
    * Command line toolkit wrappers for Mechanical Turk (standalone tools)

# Common topics #
  * DjangoServerInstallationGuide tell how to install the server and get it running.

# Mech Turk app #
  * AnnotationTaskDesign defines the XML-based language to configure the flash user interface.
  * GroupingTask is for placing object thumbnails into group bins.
  * GradingTask defines how to send tasks for grading.


# Competition app #
  * CompetitionServer gives an overview of what the evaluation server does.
  * SubmissionLimit describes how to set and change limits on the number of submissions.
  * EvaluationMiscFeatures describes numerous small features of the evaluation server

# Flash image annotation toolkit #
  * AnnotationTaskDesign defines the XML-based language to configure the flash user interface.

# Command line toolkit #
  * [MTurkCommandLineWrappers](http://code.google.com/p/cv-web-annotation-toolkit/wiki/MTurkCommandLineWrappers) explains how to install and use the command line helper functions.