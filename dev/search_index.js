var documenterSearchIndex = {"docs":
[{"location":"intro/running/","page":"-","title":"-","text":"You have a data sequence 𝒟, for our initial purposes it is a Vector [1, 2, 3, 4, 5]. The span of each subsequence is 3. The function to be applied over subsequences of 𝒟 is sum.","category":"page"},{"location":"intro/running/","page":"-","title":"-","text":"using RollingFunctions\n\n𝒟 = [1, 2, 3, 4, 5]\nℱ = sum\n𝒲 = 3\n\nresult = running(ℱ, 𝒟, 𝒲)\njulia> result\n3-element Vector{Int64}:\n  6\n  9\n 12\n\n#=\nThe first  windowed value is the ℱ (`sum`) of the first  𝒲 (`3`) values in 𝒟.\nThe second windowed value is the ℱ (`sum`) of the second 𝒲 (`3`) values in 𝒟.\nThe third  windowed value is the ℱ (`sum`) of the third  𝒲 (`3`) values in 𝒟.\n\nThere can be no fourth value as the third value used the fins entries in 𝒟.\n=#\n\njulia> sum(𝒟[1:3]), sum(𝒟[2:4]), sum(𝒟[3:5])\n(6, 9, 12)\nIf the span of each subsequence increases to 4..\n\n𝒲 = 4\nresult = running(ℱ, 𝒟, 𝒲);\n\nresult\n2-element Vector{Int64}:\n 10\n 14","category":"page"},{"location":"intro/running/","page":"-","title":"-","text":"Generally, with data that has r rows using a window_span of w results in r - w + 1 rows of values.","category":"page"},{"location":"references/","page":"References","title":"References","text":"references","category":"page"},{"location":"references/","page":"References","title":"References","text":"abcd","category":"page"},{"location":"tech/windowsorts/","page":"window sorts","title":"window sorts","text":"There are two distinct sorts of windows that are taken over data: rolling and tiled.  Rolling windows advance step-by-step over the data, each step advances the indices spanned by 1 (usually).  Tiled windows advance in larger steps (a multistep) over the data, each multistep advances the indices spanned by a preset amount, the length of the multistep.  ","category":"page"},{"location":"tech/windowsorts/","page":"window sorts","title":"window sorts","text":"With tiled windows, the tiling (the span that describes the indices covered by each tile) and the multistep increment are usually the the same. An example is summarizing a week of daily data and then moving to the following week.  To use a multistep increment that is shorter than the tiling is permitted, as is the use of an increment that is longer than the the tiling – although that is rarely needed.  An example might be summarizing a week of daily data and the skipping over the next week, moving to the second week following for some analytic purpose.","category":"page"},{"location":"api/run/#*run*","page":"run","title":"run","text":"","category":"section"},{"location":"api/run/","page":"run","title":"run","text":"abcd","category":"page"},{"location":"intro/rolling/","page":"Rolling over Data (basics)","title":"Rolling over Data (basics)","text":"You have a data sequence 𝒟, it is a Vector [1, 2, 3, 4, 5].\nThe span of each subsequence is 3.\nThe function to be applied over subsequences of 𝒟 is `sum`.","category":"page"},{"location":"intro/rolling/","page":"Rolling over Data (basics)","title":"Rolling over Data (basics)","text":"using RollingFunctions\n\n𝒟 = [1, 2, 3, 4, 5]\nℱ = sum\n𝒲 = 3\n\nresult = rolling(ℱ, 𝒟, 𝒲)\njulia> result\n3-element Vector{Int64}:\n  6\n  9\n 12\n\n#=\nThe first  windowed value is the ℱ (`sum`) of the first  𝒲 (`3`) values in 𝒟.\nThe second windowed value is the ℱ (`sum`) of the second 𝒲 (`3`) values in 𝒟.\nThe third  windowed value is the ℱ (`sum`) of the third  𝒲 (`3`) values in 𝒟.\n\nThere can be no fourth value as the third value used the fins entries in 𝒟.\n=#\n\njulia> sum(𝒟[1:3]), sum(𝒟[2:4]), sum(𝒟[3:5])\n(6, 9, 12)\nIf the span of each subsequence increases to 4..\n\n𝒲 = 4\nresult = rolling(ℱ, 𝒟, 𝒲);\n\nresult\n2-element Vector{Int64}:\n 10\n 14","category":"page"},{"location":"intro/rolling/","page":"Rolling over Data (basics)","title":"Rolling over Data (basics)","text":"Data with r rows using a window_span of w results in r - w + 1 values.","category":"page"},{"location":"intro/rolling/","page":"Rolling over Data (basics)","title":"Rolling over Data (basics)","text":"to obtain r values, use padding or tapering","category":"page"},{"location":"tech/arity/","page":"function arity","title":"function arity","text":"Function Arities","category":"page"},{"location":"tech/arity/","page":"function arity","title":"function arity","text":"abcd","category":"page"},{"location":"intro/matrix_rolling/","page":"Rolling over Data Matricies (basics)","title":"Rolling over Data Matricies (basics)","text":"You have n data vectors of equal length (rowcount 𝓇)\n`𝒟₁ .. 𝒟ᵢ ..  𝒟ₙ`  collected as an 𝓇 x 𝓃 matrix ℳ\nyou want to apply the same function (sum) \nto subsequences of each column using a window_span of 3","category":"page"},{"location":"intro/matrix_rolling/","page":"Rolling over Data Matricies (basics)","title":"Rolling over Data Matricies (basics)","text":"using RollingFunctions\n\n𝒟₁ = [1, 2, 3, 4, 5]\n𝒟₂ = [5, 4, 3, 2, 1]\n𝒟₃ = [1, 2, 3, 2, 1]\n\nℳ = hcat(𝒟₁, 𝒟₂, 𝒟₃)\n#=\n5×3 Matrix{Int64}:\n 1  5  1\n 2  4  2\n 3  3  3\n 4  2  2\n 5  1  1\n=#\n\nℱ = sum\n𝒲 = 3\n\nresult = rolling(ℱ, ℳ, 𝒲)\n#=\n3×3 Matrix{Int64}:\n  6  12  6\n  9   9  7\n 12   6  6\n=#\n","category":"page"},{"location":"intro/multicolumn_padding/","page":"Rolling over multicolumn data (padding)","title":"Rolling over multicolumn data (padding)","text":"You may pad the result with the padding value of your choice","category":"page"},{"location":"intro/multicolumn_padding/","page":"Rolling over multicolumn data (padding)","title":"Rolling over multicolumn data (padding)","text":"padding is a keyword argument","category":"page"},{"location":"intro/multicolumn_padding/","page":"Rolling over multicolumn data (padding)","title":"Rolling over multicolumn data (padding)","text":"if you assign e.g. padding = missing, the result will be padded\nyou may pad using any defined value and all types except Nothing\nexample pads (missing, 0, nothing, NaN, '∅', AbstractString)","category":"page"},{"location":"intro/multicolumn_padding/","page":"Rolling over multicolumn data (padding)","title":"Rolling over multicolumn data (padding)","text":"using RollingFunctions\n\n𝒟₁ = [1, 2, 3, 4, 5]\n𝒟₂ = [5, 4, 3, 2, 1]\n\nℱ = cov\n𝒲 = 3\n\nresult = rolling(ℱ, 𝒟₁, 𝒟₂, 𝒲; padding = zero(eltype(ℳ)))\n#=\n5 element Vector {Float64}:\n  0.0\n  0.0\n -1.0\n -1.0\n -1.0\n=#","category":"page"},{"location":"intro/multicolumn_padding/#Give-me-the-real-values-first,-pad-to-the-end.","page":"Rolling over multicolumn data (padding)","title":"Give me the real values first, pad to the end.","text":"","category":"section"},{"location":"intro/multicolumn_padding/","page":"Rolling over multicolumn data (padding)","title":"Rolling over multicolumn data (padding)","text":"result = rolling(ℱ, 𝒟₁, 𝒟₂, 𝒲; padding = missing, padlast=true)\n#=\n5 element Vector {Float64}:\n -1.0\n -1.0\n -1.0\n  missing\n  missing\n=#","category":"page"},{"location":"intro/multicolumn_padding/","page":"Rolling over multicolumn data (padding)","title":"Rolling over multicolumn data (padding)","text":"technical aside: this is not the same as reverse(rolling(ℱ, 𝒟₁, 𝒟₂, 𝒲; padding = missing).","category":"page"},{"location":"thanks/","page":"Thanks","title":"Thanks","text":"There have been many who contributed.  These few have done more than most, some without trying. I am grateful.","category":"page"},{"location":"thanks/","page":"Thanks","title":"Thanks","text":"name at\nEliot Saba @staticfloat\nBogumił Kamiński @bkamins\nKevin Patel @kevindirect","category":"page"},{"location":"tech/windowmath/","page":"windowing math","title":"windowing math","text":"𝒟 𝒟ₗₑₙ 𝒲 𝒲ₗₑₙ  𝒯 𝒯ₗₑₙ  𝒫 𝒫ₗₑₙ  𝒪 𝒪⁺ 𝒪⁻","category":"page"},{"location":"tech/windowmath/","page":"windowing math","title":"windowing math","text":"𝒟 𝒟ₙ 𝒲 𝒲ₙ  𝒯 𝒯ₙ  𝒫 𝒫ₙ  𝒪 𝒪⁺ 𝒪⁻ ⁺𝒪ₙ ⁻𝒪ₙ","category":"page"},{"location":"tech/windowmath/","page":"windowing math","title":"windowing math","text":"We accept a data sequence 𝒟𝒮 of type Vector{T} and of length 𝒟𝒮ₙ (𝒟𝒮[begin:end], length(𝒟𝒮) == 𝒟𝒮ₙ). We are given a window specification that includes its length, the span of any tiling, and more.","category":"page"},{"location":"tech/windowmath/","page":"windowing math","title":"windowing math","text":"Given a data seqeunce of N elements and a window that spans W elements (W <= N),     ccompletewindows, rremainingindices = fldmod(N, W)     if iszero(remainingelements) the data sequence is covered exactly with ccompletewindows     otherwise, the data sequence is nearly fully covered with ccompletewindows, leaving rremaining_indices","category":"page"},{"location":"tech/windowmath/","page":"windowing math","title":"windowing math","text":"N = c_complete_windows * W + r_remaining_indices\n0 = c_complete_windows * W + r_remaining_indices - N\nc_complete_windows * W = N - r_remaining_indices\nc_complete_windows = div((N - r_remaining_indices), W)\nW = div((N - r_remaining_indices), c_complete_windows)\nr_remaining_indices = N - c_complete_windows * W","category":"page"},{"location":"tech/windowmath/","page":"windowing math","title":"windowing math","text":"The preceeding assumes that the window always advances by 1 index. Use A as the whole number of indices (1 <= A <= N-1-W) that window always advances. With A = N-1-W, there is exactly one advance, from index 1 to index 1+N-1-W = N-W    the repositioned window now starts at index N-W and spans W indices, N-W+W == N    and the window has nowhere more to traverse.","category":"page"},{"location":"tech/windowmath/","page":"windowing math","title":"windowing math","text":"What value of A allows exactly 2 advances?     A1 = N-1-W, if iseven(A1) A2 = div(A1,2)     or, if isodd(N-W), A2 = div(N-W-1, 2)","category":"page"},{"location":"intro/matrix_padding/","page":"Rolling over Data Matrices (padding)","title":"Rolling over Data Matrices (padding)","text":"You may pad the result with the padding value of your choice","category":"page"},{"location":"intro/matrix_padding/","page":"Rolling over Data Matrices (padding)","title":"Rolling over Data Matrices (padding)","text":"padding is a keyword argument","category":"page"},{"location":"intro/matrix_padding/","page":"Rolling over Data Matrices (padding)","title":"Rolling over Data Matrices (padding)","text":"if you assign e.g. padding = missing, the result will be padded\nyou may pad using any defined value and all types except Nothing\nexample pads (missing, 0, nothing, NaN, '∅', AbstractString)","category":"page"},{"location":"intro/matrix_padding/","page":"Rolling over Data Matrices (padding)","title":"Rolling over Data Matrices (padding)","text":"using RollingFunctions\n\n𝒟₁ = [1, 2, 3, 4, 5]\n𝒟₂ = [5, 4, 3, 2, 1]\n𝒟₃ = [1, 2, 3, 2, 1]\n\nℳ = hcat(𝒟₁, 𝒟₂, 𝒟₃)\n#=\n5×3 Matrix{Int64}:\n 1  5  1\n 2  4  2\n 3  3  3\n 4  2  2\n 5  1  1\n=#\n\nℱ = sum\n𝒲 = 3\n\nresult = rolling(ℱ, ℳ, 𝒲; padding=missing)\n#=\n5×3 Matrix{Union{Missing,Int64}}:\nmissing missing missing\nmissing missing missing\n  6  12  6\n  9   9  7\n 12   6  6\n=#","category":"page"},{"location":"intro/matrix_padding/#Give-me-the-real-values-first,-pad-to-the-end.","page":"Rolling over Data Matrices (padding)","title":"Give me the real values first, pad to the end.","text":"","category":"section"},{"location":"intro/matrix_padding/","page":"Rolling over Data Matrices (padding)","title":"Rolling over Data Matrices (padding)","text":"result = rolling(ℱ, ℳ, 𝒲; padding = missing, padlast=true)\n#=\n5×3 Matrix{Union{Missing,Int64}}:\n  6  12  6\n  9   9  7\n 12   6  6\n   missing    missing   missing\n   missing    missing   missing\n=#","category":"page"},{"location":"intro/matrix_padding/","page":"Rolling over Data Matrices (padding)","title":"Rolling over Data Matrices (padding)","text":"technical aside: this is not the same as reverse(rolling(𝒮, 𝒟, 𝒲; padding = missing).","category":"page"},{"location":"intro/multicolumn_rolling/","page":"Rolling over multicolumn data (basics)","title":"Rolling over multicolumn data (basics)","text":"You have n data vectors of equal length (rowcount 𝓇)\n`𝒟₁ .. 𝒟ᵢ ..  𝒟ₙ`\nyou want to apply a function of n arguments\nhere, n = 2 and the function is `StatsBase.cor`\nto subsequences over the vectors using a window_span of 3","category":"page"},{"location":"intro/multicolumn_rolling/","page":"Rolling over multicolumn data (basics)","title":"Rolling over multicolumn data (basics)","text":"using RollingFunctions\n\n𝒟₁ = [1, 2, 3, 4, 5]\n𝒟₂ = [5, 4, 3, 2, 1]\n\nℱ = cor\n𝒲 = 3\n\nresult = rolling(ℱ, 𝒟₁, 𝒟₂, 𝒲)\n#=\n3-element Vector{Float64}:\n  -1.0\n  -1.0\n  -1.0\n=#","category":"page"},{"location":"tech/windows/#Window-Representations","page":"window structs","title":"Window Representations","text":"","category":"section"},{"location":"tech/windows/","page":"window structs","title":"window structs","text":"Multiple structs are used internally to model the constructive details and applicative rules for a Window over client data. All inherit from AbstractWindowing","category":"page"},{"location":"tech/windows/","page":"window structs","title":"window structs","text":"abstract type AbstractWindow end\n\n@kwdef mutable struct BasicWindow <: AbstractWindow\n    const length::Int              # span of contiguous elements\n    \n    direct::Bool=true              # process from low indices to high\n\n    const onlywhole::Bool=true     # prohibit partial window\n    const drop_first::Bool=true    # omit results at start¹, if needed²\n    const drop_final::Bool=false   # omit results at finish¹, if needed²\nend","category":"page"},{"location":"tech/windows/","page":"window structs","title":"window structs","text":"@kwdef mutable struct Window{T} <: AbstractWindow\n    const length::Int              # span of contiguous elements\n    \n    offset_first::Int=0            # start  at index offset_first + 1\n    offset_final::Int=0            # finish at index length - offset_final + 1\n\n    pad_first::Int=0               # pad with this many paddings at start\n    pad_final::Int=0               # pad with this many padding at end\n    const padding::T=nothing       # use this as the value with which to pad\n\n    const direct::Bool=true        # process from low indices to high\n\n    const onlywhole::Bool=true     # prohibit partial windows\n    const drop_first::Bool=true    # omit results at start¹, if needed²\n    const drop_final::Bool=false   # omit results at finish¹, if needed²\n\n    const trim_first::Bool=false   # use partial windowing over first elements, if needed\n    const trim_final::Bool=false   # use partial windowing over final elements, if needed\n    \n    const fill_first::Bool=true    # a simpler, often faster alternative to trim\n    const fill_final::Bool=false   # a simpler, often faster alternative to trim\nend\n\n# is indexing to be offset\nnotoffset(w::Window) = iszero(w.offset_first) && iszero(w.offset_final)\nisoffset(w::Window) = !notoffset(w)\n# >> specifying both a leading offset and a trailing offset is supported\n\n# is there to be padding\nnotpadded(w::Window) = iszero(w.pad_first) && iszero(w.pad_final)\nispadded(w::Window) = !notpadded(w)\n# >> it is an error to specify both a leading padding and a trailing padding\n\n# is the information processed in direct (lower index to higher index) order\nisdirect(w::Window) = w.direct\n\n# are only complete window spans to be allowed\nonlywhole(w::Window) = w.onlywhole\nallowpartial(w::Window) = !onlywhole(w)\n\n# is dropping incomplete results expected\nisdropping(w::Window) = (w.drop_first ⊻ w.drop_final)\nnotdropping(w::Window) = !isdropping(w)\n# >> it is an error to select both `drop_first` and `drop_final`\n  \n# is trimmed windowing to be allowed\nmaytrim(w::Window) = allowspartials(w) && (w.trim_first ⊻ w.trim_last)\n# >> it is an error to select both `trim_first` and `trim_final`\n# >> it is an error to select either `trim` and select any `fill`\n\n# is filled windowing to be allowed\nmayfill(w::Window) = allowspartials(w) && (w.fill_first ⊻ w.fill_last)\n# >> it is an error to select both `fill_first` and `fill_final`\n# >> it is an error to select either `fill` and select any `trim`","category":"page"},{"location":"tech/windows/","page":"window structs","title":"window structs","text":"@kwdef mutable struct WeightedWindow{Pad,F,T} <: AbstractWindow\n    window::Window{Pad}          # struct annotated above\n    weightfun::F=nothing         # a function that yields the weights\n    weighting::Vector{T}         # the weights collected\nend\n\n# the weight function is optional\n# if you specify a weight function, the `weighting` will be autogenerated\n# >> weightings are checked to ensure they sum to 1\n\n----\n","category":"page"},{"location":"tech/windows/","page":"window structs","title":"window structs","text":"¹ \"at start\"  is from the lowest  indices where `direct == true`\n              is from the highest indices where `direct == false`\n\n  \"at finish\" is from the highest indices where `direct == true`\n              is from the lowest  indices where `direct == false`\n\n² \"if needed\" is true if and only if `onlywhole == true` and\n              `!iszero(rem(data_length, window_length))`","category":"page"},{"location":"tech/windows/","page":"window structs","title":"window structs","text":"```","category":"page"},{"location":"intro/stepping/","page":"-","title":"-","text":"(Stepping through Windowed Data)","category":"page"},{"location":"overview/","page":"Overview","title":"Overview","text":"You have a data sequence 𝒟, for now it is a Vector [1, 2, 3, 4, 5].\nThe window span 𝒲 of each subsequence is 3.\nThe function ℱ to be applied over subsequences of 𝒟 is sum.","category":"page"},{"location":"overview/","page":"Overview","title":"Overview","text":"using RollingFunctions\n\n𝒟 = [1, 2, 3, 4, 5]\nℱ = sum\n𝒲 = 3\n\nrolled = rolling(ℱ, 𝒟, 𝒲)","category":"page"},{"location":"overview/","page":"Overview","title":"Overview","text":"julia> rolled\n3-element Vector{Int64}:\n  6\n  9\n 12\n\n#=\nThe first  windowed value is the ℱ (`sum`) of the first  𝒲 (`3`) values in 𝒟.\nThe second windowed value is the ℱ (`sum`) of the second 𝒲 (`3`) values in 𝒟.\nThe third  windowed value is the ℱ (`sum`) of the third  𝒲 (`3`) values in 𝒟.\n\nThere can be no fourth value as the third value used the fins entries in 𝒟.\n=#\n\njulia> sum(𝒟[1:3]), sum(𝒟[2:4]), sum(𝒟[3:5])\n(6, 9, 12)","category":"page"},{"location":"overview/","page":"Overview","title":"Overview","text":"If the span of each subsequence increases to 4..","category":"page"},{"location":"overview/","page":"Overview","title":"Overview","text":"𝒲 = 4\nrolled = rolling(𝒟, 𝒲, 𝒮);\n\nrolled\n2-element Vector{Int64}:\n 10\n 14","category":"page"},{"location":"overview/","page":"Overview","title":"Overview","text":"Generally, with data that has r rows using a window_span of w results in r - w + 1 rows of values.","category":"page"},{"location":"overview/#To-get-back-a-result-with-the-same-number-of-rows-as-your-data","page":"Overview","title":"To get back a result with the same number of rows as your data","text":"","category":"section"},{"location":"overview/#Welcome-to-the-wonderful-world-of-padding","page":"Overview","title":"Welcome to the wonderful world of padding","text":"","category":"section"},{"location":"overview/","page":"Overview","title":"Overview","text":"You may pad the result with the padding value of your choice","category":"page"},{"location":"overview/","page":"Overview","title":"Overview","text":"padding is a keyword argument\nif you assign e.g. padding = missing, the result will be padded","category":"page"},{"location":"overview/","page":"Overview","title":"Overview","text":"missing, 0.0 are commonly used, however all values save Nothing are permitted    – using nothing as the padding is allowed; using the type Nothing is not","category":"page"},{"location":"overview/","page":"Overview","title":"Overview","text":"using RollingFunctions\n\n𝒟 = [1, 2, 3, 4, 5]\nℱ = sum\n𝒲 = 3\n\nrolled = rolling(ℱ, 𝒟, 𝒲; padding = missing);\n\njulia> rolled\n5-element Vector{Union{Missing, Int64}}:\n   missing\n   missing\n   missing\n 10\n 14\n \nrolled = rolling(𝒟, 𝒲, 𝒮; padding = zero(eltype(𝒟));\njulia> rolled\n5-element Vector{Int64}:\n  0\n  0\n  0\n 10\n 14\n ```\n\n### Give me the real values first, pad to the end.\n","category":"page"},{"location":"overview/","page":"Overview","title":"Overview","text":"rolled = rolling(ℱ, 𝒟, 𝒲; padding = zero(eltype(𝒟), padlast=true); julia> rolled 5-element Vector{Int64}:  10  14   0   0   0 ```","category":"page"},{"location":"overview/","page":"Overview","title":"Overview","text":"technical note: this is not the same as reverse(rolling(𝒟, 𝒲, 𝒮; padding = zero(eltype(𝒟)).","category":"page"},{"location":"intro/padding/","page":"Rolling over Data (padding)","title":"Rolling over Data (padding)","text":"You may pad the result with the padding value of your choice","category":"page"},{"location":"intro/padding/","page":"Rolling over Data (padding)","title":"Rolling over Data (padding)","text":"padding is a keyword argument","category":"page"},{"location":"intro/padding/","page":"Rolling over Data (padding)","title":"Rolling over Data (padding)","text":"if you assign e.g. padding = missing, the result will be padded\nyou may pad using any defined value and all types except Nothing\nexample pads (missing, 0, nothing, NaN, '∅', AbstractString)","category":"page"},{"location":"intro/padding/","page":"Rolling over Data (padding)","title":"Rolling over Data (padding)","text":"using RollingFunctions\n\n𝒟 = [1, 2, 3, 4, 5]\nℱ = sum\n𝒲 = 3\n\nresult = rolling(ℱ, 𝒟, 𝒲; padding = missing);\n#=\n5-element Vector{Union{Missing, Int64}}:\n   missing\n   missing\n  6\n  9\n 12\n=#\n \nresult = rolling(ℱ, 𝒟, 𝒲; padding = zero(eltype(𝒟));\n#=\n5-element Vector{Int64}:\n  0\n  0\n  6\n  9\n 12\n=#","category":"page"},{"location":"intro/padding/#Give-me-the-real-values-first,-pad-to-the-end.","page":"Rolling over Data (padding)","title":"Give me the real values first, pad to the end.","text":"","category":"section"},{"location":"intro/padding/","page":"Rolling over Data (padding)","title":"Rolling over Data (padding)","text":"result = rolling(ℱ, 𝒟, 𝒲; padding = missing, padlast=true);\n#=\n5-element Vector{Union{Missing,Int64}}:\n  6\n  9\n 12\n  missing\n  missing\n=#","category":"page"},{"location":"intro/padding/","page":"Rolling over Data (padding)","title":"Rolling over Data (padding)","text":"technical aside: this is not the same as reverse(rolling(ℱ, 𝒟, 𝒲; padding = zero(eltype(𝒟)).","category":"page"},{"location":"api/roll/#*roll*","page":"roll","title":"roll","text":"","category":"section"},{"location":"api/roll/","page":"roll","title":"roll","text":"abcd","category":"page"},{"location":"#RollingFunctions.jl","page":"Home","title":"RollingFunctions.jl","text":"","category":"section"},{"location":"#This-package-makes-it-easy-to-summarize-windowed-data.","page":"Home","title":"This package makes it easy to summarize windowed data.","text":"","category":"section"},{"location":"#Your-function-is-applied-to-data-subsequences,-in-order.","page":"Home","title":"Your function is applied to data subsequences, in order.","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"~~~~","category":"page"},{"location":"","page":"Home","title":"Home","text":"You give a summarizing function ℱ, the data 𝒟, and a window span 𝒲.  ","category":"page"},{"location":"","page":"Home","title":"Home","text":"The result ℛ is of length ℛᴺ, ℛᴺ = length(𝒟) - 𝒲 + 1`.","category":"page"},{"location":"","page":"Home","title":"Home","text":"the result omits ℛᴼ, ℛᴼ = 𝒲 - 1 indices into 𝒟.","category":"page"},{"location":"","page":"Home","title":"Home","text":"Here are ways to get as many result values as there are data values:","category":"page"},{"location":"#Use-a-single,-shared-padding-value","page":"Home","title":"Use a single, shared padding value","text":"","category":"section"},{"location":"#specify-a-padding-value-(default-position-is-at-the-start)","page":"Home","title":"specify a padding value (default position is at the start)","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"rolling(function, data, window_span; padding = missing)\nthis will fill the initial result values with the padding value\npads these values (result[1], .., result[pad_nindices])","category":"page"},{"location":"#specify-padding-to-be-at-the-end-of-the-result","page":"Home","title":"specify padding to be at the end of the result","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"rolling(function, data, window_span; padding = missing, padlast = true)\nthis will fill the final result values with the padding value\npads these values (result[n-pad_nindices+1], .., result[n])","category":"page"},{"location":"#Use-a-vector-of-padding-values-with-length-ℛᴼ","page":"Home","title":"Use a vector of padding values with length ℛᴼ","text":"","category":"section"},{"location":"#specify-a-padding-vector-(default-is-at-the-start)","page":"Home","title":"specify a padding vector (default is at the start)","text":"","category":"section"},{"location":"#specify-the-padding-vector-to-be-at-the-end","page":"Home","title":"specify the padding vector to be at the end","text":"","category":"section"},{"location":"#Use-an-empty-vector-(this-way:-...;-padding-eltype(𝒟)[])","page":"Home","title":"Use an empty vector (this way: ...; padding = eltype(𝒟)[])","text":"","category":"section"},{"location":"#this-fills-the-ℛᴼ-indices-by-trimming","page":"Home","title":"this fills the ℛᴼ indices by trimming","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"trimming evaluates the window function over available data\ntrimmed window spans are less than the specified window_span","category":"page"},{"location":"#Use-a-vector-of-𝓃-padding-values-where-1-𝓃-ℛᴼ","page":"Home","title":"Use a vector of 𝓃 padding values where 1 <= 𝓃 < ℛᴼ","text":"","category":"section"},{"location":"#this-both-pads-and-trims-to-assign-the-initial-indices","page":"Home","title":"this both pads and trims to assign the initial indices","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"the first 𝓃 indices of the result will match this vector\nthe next ℛᴼ - 𝓃 indices of the result will be trimmed\nthe remaining indices get the rolled results.","category":"page"},{"location":"intro/windoweddata/","page":"-","title":"-","text":"(Windowed Data)","category":"page"}]
}
