This page contains the exact text of qualifications used in evaluation.

# Question XML #

```
<?xml version="1.0" ?>
<QuestionForm xmlns="http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2005-10-01/QuestionForm.xsd">
   <Overview>
      <Title>VOC bounding box labeling qualification</Title>
   </Overview>


<Question>
<QuestionIdentifier>image1_1</QuestionIdentifier>
<IsRequired>false</IsRequired>

<QuestionContent>
<Binary><MimeType><Type>image</Type><SubType>jpg</SubType></MimeType>
<DataURL>http://vch.cs.uiuc.edu/wiki/images/9/98/Bus_loose.png</DataURL>
<AltText>WARNING The image is REQUIRED</AltText>
</Binary>

<FormattedContent><![CDATA[Please read the detailed <a target="_blank" href="http://vch.cs.uiuc.edu/wiki/index.php/BoundingBoxAnnotations">instructions</a> to learn how to perform the task.]]></FormattedContent>

<Text>
Please confirm that you understand the instructions by answering the following questions:

Is this annotation complete?</Text>
</QuestionContent>

<AnswerSpecification>
<SelectionAnswer>
<StyleSuggestion>checkbox</StyleSuggestion>
<Selections>
<Selection>
        <SelectionIdentifier>complete_no</SelectionIdentifier>
        <Text>no (wrong, all the objects present are marked on the image).</Text>
</Selection>
<Selection>
        <SelectionIdentifier>complete_yes</SelectionIdentifier>
        <Text> yes (correct, there is only one object in the list that is present in the image).</Text>
</Selection>
</Selections>
</SelectionAnswer>
</AnswerSpecification>
</Question>




<Question>
<QuestionIdentifier>image1_2</QuestionIdentifier>
<IsRequired>false</IsRequired>

<QuestionContent>
<Text>

</Text>
<FormattedContent><![CDATA[<br></br>]]></FormattedContent>
<Text>
Is this annotation accurate?
</Text>


</QuestionContent>

<AnswerSpecification>
<SelectionAnswer>
<StyleSuggestion>checkbox</StyleSuggestion>
<Selections>
<Selection>
        <SelectionIdentifier>accurate_no</SelectionIdentifier>
        <Text> no (correct, the bounding box is too loose. It's quality is 0.88, while a correct outline would be at 0.95).
</Text>
</Selection>
<Selection>
        <SelectionIdentifier>accurate_yes</SelectionIdentifier>
        <Text>yes (wrong, the bounding box is too loose and it's missing the top of the bus).</Text>
</Selection>
</Selections>
</SelectionAnswer>
</AnswerSpecification>
</Question>




<Question>
<QuestionIdentifier>image1_3</QuestionIdentifier>
<IsRequired>false</IsRequired>

<QuestionContent>
<Text>

</Text>
<FormattedContent><![CDATA[<br></br>]]></FormattedContent>
<Text>
What is the quality of the annotation?
</Text>


</QuestionContent>

<AnswerSpecification>
<SelectionAnswer>
<StyleSuggestion>checkbox</StyleSuggestion>
<Selections>
<Selection>
        <SelectionIdentifier>quality_bad</SelectionIdentifier>
        <Text> bad (rejected) - The quality is bad, because all the work needs to be re-done.</Text>
</Selection>
<Selection>
        <SelectionIdentifier>quality_good_w_err</SelectionIdentifier>
        <Text>good, with errors (approved, but needs to be re-done)
</Text>
</Selection>
<Selection>
        <SelectionIdentifier>quality_good</SelectionIdentifier>
        <Text>good (approved and no further work is necessary)
</Text>
</Selection>
</Selections>
</SelectionAnswer>
</AnswerSpecification>
</Question>






<Question>
<QuestionIdentifier>image2_1</QuestionIdentifier>
<IsRequired>false</IsRequired>

<QuestionContent>
<Binary><MimeType><Type>image</Type><SubType>png</SubType></MimeType>
<DataURL>http://vch.cs.uiuc.edu/wiki/images/7/71/Missing_monitor.png</DataURL>
<AltText>WARNING The image is REQUIRED</AltText>
</Binary>

<Text>Is this annotation complete?</Text>
</QuestionContent>





<AnswerSpecification>
<SelectionAnswer>
<StyleSuggestion>checkbox</StyleSuggestion>
<Selections>
<Selection>
        <SelectionIdentifier>complete_no</SelectionIdentifier>
        <Text>no (correct, the monitor isn't marked).</Text>
</Selection>
<Selection>
        <SelectionIdentifier>complete_yes</SelectionIdentifier>
        <Text>yes (wrong, objects are missing).
</Text>
</Selection>

</Selections>
</SelectionAnswer>
</AnswerSpecification>
</Question>


<Question>
<QuestionIdentifier>image2_2</QuestionIdentifier>
<IsRequired>false</IsRequired>

<QuestionContent>
<Text>
Is this annotation accurate?
</Text>

</QuestionContent>

<AnswerSpecification>
<SelectionAnswer>
<StyleSuggestion>checkbox</StyleSuggestion>
<Selections>
<Selection>
        <SelectionIdentifier>accurate_no</SelectionIdentifier>
        <Text>no (wrong, the bounding box present is very accurate).</Text>
</Selection>
<Selection>
        <SelectionIdentifier>accurate_yes</SelectionIdentifier>
        <Text>yes</Text>
</Selection>
</Selections>
</SelectionAnswer>
</AnswerSpecification>
</Question>




<Question>
<QuestionIdentifier>image2_3</QuestionIdentifier>
<IsRequired>false</IsRequired>

<QuestionContent>
<Text>
What is the quality of the annotation:
</Text>

</QuestionContent>

<AnswerSpecification>
<SelectionAnswer>
<StyleSuggestion>checkbox</StyleSuggestion>
<Selections>
<Selection>
        <SelectionIdentifier>quality_bad</SelectionIdentifier>
        <Text> bad (rejected) - The quality is bad, because this particular image is very easy.</Text>
</Selection>
<Selection>
        <SelectionIdentifier>quality_good_w_err</SelectionIdentifier>
        <Text>good, with errors (approved, but needs to be re-done)
</Text>
</Selection>
<Selection>
        <SelectionIdentifier>quality_good</SelectionIdentifier>
        <Text>good (approved and no further work is necessary)
</Text>
</Selection>
</Selections>
</SelectionAnswer>
</AnswerSpecification>
</Question>





<Question>
<QuestionIdentifier>image3_1</QuestionIdentifier>
<IsRequired>false</IsRequired>


<QuestionContent>
<Binary><MimeType><Type>image</Type><SubType>png</SubType></MimeType>
<DataURL>http://vch.cs.uiuc.edu/wiki/images/d/d8/Dining_room.png</DataURL>
<AltText>WARNING The image is REQUIRED</AltText>
</Binary>

<Text>Is this annotation complete?</Text>
</QuestionContent>




<AnswerSpecification>
<SelectionAnswer>
<StyleSuggestion>checkbox</StyleSuggestion>
<Selections>
<Selection>
        <SelectionIdentifier>complete_no</SelectionIdentifier>
        <Text>no (wrong).</Text>
</Selection>
<Selection>
        <SelectionIdentifier>complete_yes</SelectionIdentifier>
        <Text>yes (correct, all objects are marked).
</Text>
</Selection>

</Selections>
</SelectionAnswer>
</AnswerSpecification>
</Question>


<Question>
<QuestionIdentifier>image3_2</QuestionIdentifier>
<IsRequired>false</IsRequired>

<QuestionContent>
<Text>
Is this annotation accurate?
</Text>

</QuestionContent>

<AnswerSpecification>
<SelectionAnswer>
<StyleSuggestion>checkbox</StyleSuggestion>
<Selections>
<Selection>
        <SelectionIdentifier>accurate_no</SelectionIdentifier>
        <Text>no.</Text>
</Selection>
<Selection>
        <SelectionIdentifier>accurate_yes</SelectionIdentifier>
        <Text>yes. (correct, all bounding boxes are tight)</Text>
</Selection>
</Selections>
</SelectionAnswer>
</AnswerSpecification>
</Question>



<Question>
<QuestionIdentifier>image3_3</QuestionIdentifier>
<IsRequired>false</IsRequired>

<QuestionContent>
<Text>
Why is the "hard image" checkbox marked?
</Text>

</QuestionContent>

<AnswerSpecification>
<SelectionAnswer>
<StyleSuggestion>checkbox</StyleSuggestion>
<Selections>
<Selection>
        <SelectionIdentifier>hard_to_see</SelectionIdentifier>
        <Text>because the objects are hard to see. </Text>
</Selection>
<Selection>
        <SelectionIdentifier>bottle_on_the_left</SelectionIdentifier>
        <Text>because there is a bottle on the left, which is very hard to spot.
</Text>
</Selection>
<Selection>
        <SelectionIdentifier>is_indoors</SelectionIdentifier>
        <Text>because the image is indoors. (false)</Text>
</Selection>
</Selections>
</SelectionAnswer>
</AnswerSpecification>
</Question>


<Question>
<QuestionIdentifier>image3_4</QuestionIdentifier>
<IsRequired>false</IsRequired>

<QuestionContent>
<Text>
What is the quality of the annotation?
</Text>

</QuestionContent>

<AnswerSpecification>
<SelectionAnswer>
<StyleSuggestion>checkbox</StyleSuggestion>
<Selections>
<Selection>
        <SelectionIdentifier>quality_bad</SelectionIdentifier>
        <Text> bad (rejected)</Text>
</Selection>
<Selection>
        <SelectionIdentifier>quality_good_w_err</SelectionIdentifier>
        <Text>good, with errors (approved, but needs to be re-done)
</Text>
</Selection>
<Selection>
        <SelectionIdentifier>quality_good</SelectionIdentifier>
        <Text>good (approved and no further work is necessary)
- This is correct and complete annotation of a difficult image. The quality should be assigned as "good".</Text>
</Selection>
</Selections>
</SelectionAnswer>
</AnswerSpecification>
</Question>


</QuestionForm>
```


# Answer XML #

```
<?xml version="1.0"?>
<AnswerKey xmlns="http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2005-10-01/AnswerKey.xsd">
 <Question>
  <QuestionIdentifier>image1_1</QuestionIdentifier>
  <AnswerOption>
        <SelectionIdentifier>complete_yes</SelectionIdentifier>
          <AnswerScore>10</AnswerScore>
  </AnswerOption>
 </Question>

 <Question>
  <QuestionIdentifier>image1_2</QuestionIdentifier>
  <AnswerOption>
        <SelectionIdentifier>accurate_no</SelectionIdentifier>
  <AnswerScore>10</AnswerScore>
  </AnswerOption>
 </Question>

 <Question>
  <QuestionIdentifier>image1_3</QuestionIdentifier>
  <AnswerOption>
        <SelectionIdentifier>quality_bad</SelectionIdentifier>
  <AnswerScore>10</AnswerScore>
  </AnswerOption>
 </Question>

 <Question>
  <QuestionIdentifier>image2_1</QuestionIdentifier>
  <AnswerOption>
        <SelectionIdentifier>complete_no</SelectionIdentifier>
        <AnswerScore>10</AnswerScore>
  </AnswerOption>
 </Question>

 <Question>
  <QuestionIdentifier>image2_2</QuestionIdentifier>
  <AnswerOption>
        <SelectionIdentifier>accurate_yes</SelectionIdentifier>
  <AnswerScore>10</AnswerScore>
  </AnswerOption>
 </Question>
 <Question>
  <QuestionIdentifier>image2_3</QuestionIdentifier>
  <AnswerOption>
        <SelectionIdentifier>quality_bad</SelectionIdentifier>
  <AnswerScore>10</AnswerScore>
  </AnswerOption>
 </Question>



 <Question>
  <QuestionIdentifier>image3_1</QuestionIdentifier>
  <AnswerOption>
        <SelectionIdentifier>complete_yes</SelectionIdentifier>
  <AnswerScore>10</AnswerScore>
  </AnswerOption>
 </Question>

 <Question>
  <QuestionIdentifier>image3_2</QuestionIdentifier>
  <AnswerOption>
        <SelectionIdentifier>accurate_yes</SelectionIdentifier>
  <AnswerScore>10</AnswerScore>
  </AnswerOption>
 </Question>


 <Question>
  <QuestionIdentifier>image3_3</QuestionIdentifier>
  <AnswerOption>
        <SelectionIdentifier>hard_to_see</SelectionIdentifier>
        <SelectionIdentifier>bottle_on_the_left</SelectionIdentifier>
  <AnswerScore>10</AnswerScore>
  </AnswerOption>
 </Question>


 <Question>
  <QuestionIdentifier>image3_4</QuestionIdentifier>
  <AnswerOption>
        <SelectionIdentifier>quality_good</SelectionIdentifier>
  <AnswerScore>10</AnswerScore>
  </AnswerOption>
 </Question>


<QualificationValueMapping>
 <PercentageMapping>
    <MaximumSummedScore>100</MaximumSummedScore>
  </PercentageMapping>

</QualificationValueMapping>
</AnswerKey>

```

## Properties ##

```
Name=VOC bounding box labeling qualification(v 0.1.4)
Description=Tests the understanding of instructions for bounding box annotation.
RetryDelayInSeconds=30
TestDurationInSeconds=3600
QualificationTypeStatus=Active
AutoGranted=False
Keywords=image,VOC,bounding,box
```