| **STATE** | **DESCRIPTION** |
|:----------|:----------------|
| New       | The work unit is just created |
| **Open**  | The work unit is not finished and is not being worked on. |
| **Active** | The work unit was submitted to the Mechanical Turk |
| **Finalized** | All required submissions were approved  |
| Submitted | All required submissions are available in the system |
| Graded    | All submissions have been graded |

The _submitted_ and _graded_ states are reserved, but not used.

# Common state cycle #

The most common state path is **New**->**Active**->`[`**Open** -> **Active** `]`->**Finalized** . This corresponds to the work unit being added to the system and activated, then work is submitted, then the submission is graded. If the submission is rejected, the work unit becomes **open**. If the submission is approved, the work unit becomes **finalized**.