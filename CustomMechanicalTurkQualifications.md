# Introduction #

Qualification is a test that the worker must take before they can work on the task.
The qualification contains three parts: question form, answer key and properties. The format of those are defined in the [Amazon developer guide](http://docs.amazonwebservices.com/AWSMturkAPI/2008-08-02/) (specifically on [this page](http://docs.amazonwebservices.com/AWSMturkAPI/2008-08-02/ApiReference_QuestionFormDataStructureArticle.html)). Qualifications are created via admin interface at `/admin/mturk/mturkqualificationdefinition/`. Once the worker takes the qualification test, they will obtain the qualification value.

Once qualification is defined, we need to create qualification requirement, which includes the reference to the qualification, the required score (use comparator=EqualTo,value=score for the exact score) and whether the requirement should be created in sandbox or in production. Qualification ID is different for sandbox and production. Therefore, the qualification requirements must be different for sandbox and for production.

# Manual steps #
  1. Create qualification definition
  1. Create qualification requirement. The "sandbox" flag must match the one on the session.
  1. Add qualification to the session
  1. Submit HITs to the session.


# Other operations #
  1. To **manually** force creation of the qualification use "create" action: `/mt/qualification/create/<session_code>/<qualification_requirement_name>/`. This action is useful only if you want to see the qualification before creating any HITs. The qualification is created automatically.
  1. To **manually** update the qualification use "update" action: `/mt/qualification/update/<session_code>/<qualification_requirement_name>/`.
  1. To see the question and answer xml, use `/mt/qualification/show/ <qual definition name> /question/` and `/mt/qualification/show/ <qual definition name> /answer/`. These require login for security and are useful to check for XML errors.

# Qualification properties #
The qualification properties are passed through to the Amazon API. By default, the **Name** of the qualification is specified in the qualification definition name field. However, the **Name** property will override it if specified in properties page.

# Implementation notes #

The implementation is contained in mturk.qualifications module.