# Data locations #

  * `/var/datasets/<dsname>/` - images (can have internal folder structure)
  * `/var/datasets/tasks/`  - task definitions. (xml files for the annotation interface)
  * `/var/datasets/segmentations/`  - compressed segmentations storage. The bitmaps are compressed with zlib and encoded into plain text (each byte goes to two chars: 4 bits are encoded with A-P, A=0, P=15).