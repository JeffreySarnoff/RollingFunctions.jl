
#### the kinds of window extent

| quantity | extent given by     | utilizes   |
|:---------|:--------------------|:-----------|
| span     | index separation    | positions  |
| duration | elapsed time        | timestamps |
| count    | tally of occurances | events     |
| session  | content obtained    | activities |
|          |                     |            |

#### the kinds of positional skip

- fixed
- expanding
- dynamic

`https://materialize.com/docs/transform-data/patterns/temporal-filters/`

period [step] --  before a new window begins
- (number of indices / amount of time / count of occurances / activity)


Tumbling windows are what we call windows when their duration equals their period (the amount of time before a new window begins). This creates fixed-size, contiguous, non-overlapping time intervals where each record belongs to exactly one interval.

Hopping windows are windows whose duration is an integer multiple of their period. This creates fixed-size windows that may overlap, with records belonging to multiple windows.

Sliding windows are windows whose period approaches the limit of 0. This creates fixed-size windows that appear to slide continuously forward in time. Records may belong to more than one interval.



count-based, delta-based, time-based, punctuation-based

rolling weighted expanding windows

event-time, processing-time


#### the modes of window advancement

A window that covers <first, last> advances to <last, last+(last-first)>.

A window moves by advancing its start by jump and covering its extent

- Each window has a fixed or dynamic or expanding extent
- Each window has a fixed or dynamic or expanding jump

| name    | increment | overlap     | gap         |
|:--------|:----------|:------------|:------------|
| slide   | fixed     | extent-1    | none        |
| tile    | fixed     | none        | none        |
| tumble  | fixed     | no          | gapless     |
| overlap | fixed     | no          | gapless     |
| hop     | fixed     | extent-jump | jump-extent |
| session | dynamic   | no          | no          |



Every windows has a width (span). The width 
There are two distinct sorts of windows that are taken over data: _rolling_ and _tiled_.  

- Rolling windows advance step-by-step over the data

   - each step advances the indices widthned by 1

- Tiled windows advance in larger strides over the data

   - each stride advances the indices widthned by a fixed multistep

With tiled windows, the tiling (the width that describes the indices covered by each tile) and the multistep increment are the same in most uses. An example of this is summarizing a week of daily data with a tiling of 7 and then moving to the following week with a multistep of 7.

To use a multistep increment that is less than the tiling is permitted. As an example, summarize two weeks of daily data with a tiling of 14 and skip over one week with a multistep of 7 to allow you to analyze two week intervals one week at a time.

To use a multistep increment that exceeds the tiling is permitted. As an example, summarize a week of daily data with a tiling of 7 and skip over two weeks with a multistep of 14 to allow you to analyze odd weeks and use that analysis along with the even weeks to constrain a model.

