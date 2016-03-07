# Introduction #

Command line tools for Amazon Mechanical Turk are a great and easy way to work with Turk. They have minor difficulties: they assume a copy of scripts in every folder where the data is stored. These tools are installed once and work with input files in the current directory. These tools provide most common operations: submit, get results, approve. They are very simple and easy to extend.

# Installation #

  1. Install Amazon Mechanical Turk Command line tools (say, to ~/projects/visual\_turk/aws\_tools/aws-mturk-clt-1.2.0/)
  1. Check out the [current version](http://code.google.com/p/cv-web-annotation-toolkit/source/browse/#svn/trunk/command_line_wrappers). Place them into CODE\_ROOT
  1. Edit your .bashrc and add:

```
export MTURK_CMD_HOME=~/projects/visual_turk/aws_tools/aws-mturk-clt-1.2.0/
export JAVA_HOME=/usr
export PATH=$PATH:${CODE_ROOT}
```



# File naming conventions #

## input files ##
./workload.input - the input file for HITs

./workload.properties - the properties file (could be in ../ or ../../)

./workload.question - the properties file (could be in ../ or ../../)

## output files ##
./workload.success
./workload.results

## grading files ##
./workload.approve\_file
./workload.reject\_file
./workload.redo\_extend\_hit -

# Function documentation #
The functions mostly mirror the original SDK commands.

MT\_run.sh

MT\_run2.sh - searches for workload.properties and workload.questions in ../ and in ../../ ; This is very useful when the workload.input changes, but the other files don't.


---


MT\_getResults.sh


---


MT\_approveAndDeleteResults.sh - approves everything!

MT\_only\_approve.sh - approves all assignments listed in workload.approve\_file

MT\_only\_reject.sh - rejects all assignments listed in workload.reject\_file

MT\_delete\_results.sh


---


MT\_extendHits.sh - adds more time/of assignments to each HIT.

MT\_grantBonus.py - generates a script with 1 grant bonus command for every record.

MT\_submit\_redo.sh - adds 1 more assignment to every HIT listed in workload.redo\_extend\_hit

MText\_resequence.py