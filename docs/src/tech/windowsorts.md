There are two distinct sorts of windows that are taken over data: _rolling_ and _tiled_.  

- Rolling windows advance step-by-step over the data

   - each step advances the indices spanned by 1

- Tiled windows advance in larger strides over the data

   - each stride advances the indices spanned by a fixed multistep

With tiled windows, the tiling (the span that describes the indices covered by each tile) and the multistep increment are the same in most uses. An example of this is summarizing a week of daily data with a tiling of 7 and then moving to the following week with a multistep of 7.

To use a multistep increment that is less than the tiling is permitted. As an example, summarize two weeks of daily data with a tiling of 14 and skip over one week with a multistep of 7 to allow you to analyze two week intervals one week at a time.

To use a multistep increment that exceeds the tiling is permitted. As an example, summarize a week of daily data with a tiling of 7 and skip over two weeks with a multistep of 14 to allow you to analyze odd weeks and use that analysis along with the even weeks to constrain a model.

