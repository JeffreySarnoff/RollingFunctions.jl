## Overview

This package gives you the ability to apply a summarizing function to successive equilength subsequences of some larger data sequence.
Simply put, you decide on a summarizing function ℱ, specify a window 𝒲, and provide the data 𝒟.  The package does what you have asked.

Windows are specified by length 𝓁, kind 𝓀, behavior 𝒷, displacement 𝒹 and weighting 𝓌.

- The length is the number of sequential data elements spanned by the window.
- The kind is either 'whole' (complete windows only) or 'part' (the first or last window[s] may be partial, with <  𝓁 data elements).
- The behavior is 'pad_first', 'pad_last', 'pad_none', and applies only when the kind is 'part'. Padding is done with `missing`.
- The displacement is an offset from the actual start or end of the data. This is a signed integer, (+) offsets from the start, (-) from the end.
- The weighting is optional, a sequence of floating point values of length 𝓁 that sum to 1.0.






