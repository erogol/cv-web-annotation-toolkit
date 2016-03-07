# Introduction #

We need to classify boundaries that happen in natural images(i.e. taken with a camera). Boundaries are produced by objects, materials and shadows. We need to label them all.
In the difficult cases we need a sentence describing the point itself - we will check to see if we can change or extend the boundary types to accommodate those special cases.

# Boundary types #

Mark **ALL** options that apply. When it's an object boundary, it is very likely to be a material boundary. An object boundary can also be depth boundary.

  1. **Texture/material boundary.** When the boundary is produced by the change from one material or texture to another material or texture (e.g.the glass cover and plastic border of a monitor).
  1. **Object boundary.** Where two nearby objects touch in the image. On one side of the boundary is one object, on the other side of the boundary is another object (e.g. boundary between plate and table).
  1. **Shadow boundary.** Shadows produce obvious boundaries.
  1. **Depth boundary.** The two sides of the boundary are close in the image, but they are far apart in the space.
  1. **None**  It would be wrong to classify this particular point as one of the options 1-4.
  1. **Unclear**  Difficult to see what's going on, it's hard to decide if a particular mark (e.g. depth) should be checked. Whenever **unclear** is used, provide a full textual description of the point.

# Text descriptions #

In the difficult cases we need a couple sentences explaining the point. The sentences  should describe what objects the - the sentenceitself and the boundary type.

See more examples at the discussion pages: [discussion-1](http://visual-annotation.wikidot.com/boundary-annotation-1),[discussion-2](http://visual-annotation.wikidot.com/boundary-annotation-2), etc..

# Quality objective #

We need at least **90%** agreement among people. Submissions with lower agreement will be rejected.

# Examples #

Plenty of examples is available on the discussion pages:[discussion-1](http://visual-annotation.wikidot.com/boundary-annotation-1)