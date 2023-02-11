----

#### This package makes it easy to summarize windowed data.

#### A function is applied to successive data subsequences.

----

You give a summarizing function _Func_, the data _Data_, and a window span _Span_.  

The result `ℛ` is of length `ℛᴺ`, ℛᴺ = length(_Data_) - _Span_ + 1`.
- the result omits `ℛᴼ`, `ℛᴼ = _Span_ - 1` indices into _Data_.

- _here is the way to do that_
  - `rolling(_Func_, _Data_, _Span_)`
  - `rolling(function, data, window_span)`

----

#### _ways to get as many results as there are data values_

----

#### Use a single, shared padding value

##### specify a padding value (default position is at the start)

- _here is the way to do that_
  - `rolling(_Func_, _Data_, _Span_; padding = <value>)`
  - `rolling(function, data, window_span; padding = missing)`
- this will fill the initial result values with the padding value
  - pads these values `(result[1], .., result[pad_nindices])`

##### specify padding to be at the end of the result

- _here is the way to do that_
  - `rolling(_Func_, _Data_, _Span_; padding = <value>, padlast = true)`
  - `rolling(function, data, window_span; padding = missing, padlast = true)`
- this will fill the final result values with the padding value
  - pads these values `(result[n-pad_nindices+1], .., result[n])`
