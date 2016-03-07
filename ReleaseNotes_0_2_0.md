# Database upgrade #

  * add is\_gold (tinyint(1)) to mturk\_session
  * drop mturk\_goldstandardqualification
  * drop mturk\_goldstandardgraderecord


# Config changes #
  * each task is now a separate application and must be added to settings.py


# Other issues #
  * fixed rospy.init\_node call to work within the thread