## States ##

  1. 'New' - It's in the system, but hasn't been submitted for processing (activated).
  1. 'Submitted' - The work unit has been completed, but not graded.
  1. 'Graded' - The work unit has a tentative grade.
  1. 'Finalized' - The work unit has been declared absolutely completed. No further work is expected unless discrepancies are detected.
  1. 'Open' - It isn't active, but have been through processing stages.
  1. 'Active' - It's available for processing and has been submitted to the crowdsourcing engine.
  1. 'Rejected' - The work unit shall not be completed. The system will not perform any work on it. This could be due to


## State transitions ##

Normal life span is this:
` New -> Active -> Submitted -> Graded -> Finalized.`

Deviations could be:
`Submitted -> Graded -(work rejected)> Open -> Active -> Submitted .....`

After work defects are discovered, the **finalized** work units can be reopened and transitioned into **open**:
`Finalized -(defect found)> Open `


## Tests ##