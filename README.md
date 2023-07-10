# RollingFunctions.jl

### Roll functions and  run statistics along windowed data.

----

[![Dev Documentation](https://img.shields.io/badge/docs-dev-blue.svg)](https://JeffreySarnoff.github.io/RollingFunctions.jl/dev)&nbsp;&nbsp;&nbsp;
[![Aqua QA](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)&nbsp;&nbsp;&nbsp;
[![License: MIT](https://img.shields.io/badge/License-MIT-navy.svg)](https://opensource.org/licenses/MIT)&nbsp;&nbsp;&nbsp;
[![Package Downloads](https://shields.io/endpoint?url=https://pkgs.genieframework.com/api/v1/badge/RollingFunctions)](https://github.com/JeffreySarnoff/RollingFunctions.jl/tree/v1)&nbsp;

|&nbsp;&nbsp;&nbsp;  [<a>&nbsp;Copyright © 2015-2023 by Jeffrey Sarnoff \<on github: JeffreySarnoff\></a>](https://github.com/JeffreySarnoff/RollingFunctions.jl/tree/v1) &nbsp;&nbsp;&nbsp;|
|----------:|



# Philosophy and Purpose

## rolling, tiling, and running functional windows over data

### _At its best, this software is collaborative._
> #### Apply your acumen and intent.


### Data

Data is conveyed either as a vector, a matrix of column vectors,
or as some coordinated vectors.

With the covariance function,
two vectors are processed within the current window
like this
- `map(cov, window_over_seq1, window_over_seq2)`&nbsp;&nbsp;_(the windows are identical)_

Data may be obtained from other `Tables.jl` compatible data structures
(e.g. dataframes, timeseries) and from similarly read compatible files
(e.g using CSV.read, either with a .csv file or, for example, 
 using CSV.jl and SQLite.jl together).

### Windows

Windows move over the data.  One may use unweighted windows or 
windows where a specific weight is associated with each position
(index offset into the window).  The weights are applied 
the same way with every window advance. Weights are 
multiplied 1-to-1 to scale the newly visible data _now seen through the moving window_.

### Participation


We welcome contributors and _celebrates_ PRs.</br>
Our _issue_ threads are available for wider use.</br>
And we are on _discourse_</br> 


| you are invited .. |
|--------------------|
| Ask. Share insights. Write words that smile. |

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

----
