### Apply functions over windows that advance through data.

|                                                       |
|:-----------------------------------------------------:|
| RollingFunctions.jl © 2017-2023 by Jeffrey Sarnoff    |
|                                                       |



##### in three different ways
- [__rolling__](approach/rolling.md)
- [__tiling__](approach/tiling.md)
- [__running__](approach/running.md)

##### optionally specifying
- [__weights__](approach/weighted.md)
- [__padding__](approach/padding.md)
- [__pad placement__](approach/atend.md)

##### with these data sequences
- [__datastreams__](approach/datastreams.md)



----

----

## Capabilities


### ≺ apply ≻&nbsp; ∈&nbsp; {&nbsp;rolling, tiling, running&nbsp;}

#### keywords (optional)
 - __padding__ = nopadding (omit padding) [_or use this value_]
 - __atend__ = false (_pad the start_) [_true, pad the end_]


### data sequences
- _as provided_
    - ≺ apply ≻(win_fn, win_width, seq)
- _with weights_
   - ≺ apply ≻(win_fn, win_width, seq, weights)

### data matrix
- _as provided_
    - ≺ apply ≻(win_fn, win_width, data_matrix)
- _with shared weights_
   - ≺ apply ≻(win_fn, win_width, data_matrix, weights)
- _with unique weights_
   - ≺ apply ≻(win_fn, win_width, data_matrix, weight_matrix)

#### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_(Each data matrix column is independent; all functions are unary.)_

### multisequences (2..Nseq seqs of equal length; use binary..multiary functions)

|                   | |                                      |
|:------------------|-|:-------------------|
| multisequence     | | ≺ apply ≻(fn, width, _`rest`_...) |
|                   |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  |                                      |
| _as provided_     |  | _rest_                  |
|                   | |(seq1, seq2)       |
|                   | |(seq1, ..,  seqNseq) |
|                   | |                                      |
| _shared weights_  | | _rest_                       |
|                   | |(seq1, seq2, weights)       |
|                   | |(seq1, .., seqNseq, weights) |
|                   | |                                      |
|                   | |                                      |
| _unique weights_  | | _rest_                        |
|                   | |(seq1, seq2, [weights1, weights2])       |
|                   | |(seq1, .., seqNseq, [weights1, .., weightsNseq]) |
|                   | |                                      |

#### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_(Nseq, the maximum number of coordinated sequences, is >= 3.)_

----
