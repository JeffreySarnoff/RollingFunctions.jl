6 ambiguities found

Possible fix, define
  ==(::Union{StatsBase.PValue, StatsBase.TestStat}, ::AbstractIrrational)
Ambiguity #2
==(y::Real, x::Union{StatsBase.PValue, StatsBase.TestStat}) @ StatsBase C:\Users\MrJSa\.julia\packages\StatsBase\XgjIN\src\statmodels.jl:91
==(x::AbstractIrrational, y::Real) @ Base irrationals.jl:89

Possible fix, define
  ==(::AbstractIrrational, ::Union{StatsBase.PValue, StatsBase.TestStat})
Ambiguity #3
StatsBase.TestStat(v) @ StatsBase C:\Users\MrJSa\.julia\packages\StatsBase\XgjIN\src\statmodels.jl:80
(::Type{T})(x::AbstractChar) where T<:Union{AbstractChar, Number} @ Base char.jl:50

Possible fix, define
  StatsBase.TestStat(::AbstractChar)

Ambiguity #4
StatsBase.TestStat(v) @ StatsBase C:\Users\MrJSa\.julia\packages\StatsBase\XgjIN\src\statmodels.jl:80
(::Type{T})(x::Base.TwicePrecision) where T<:Number @ Base twiceprecision.jl:267

Possible fix, define
  StatsBase.TestStat(::Base.TwicePrecision)

Ambiguity #5
StatsBase.TestStat(v) @ StatsBase C:\Users\MrJSa\.julia\packages\StatsBase\XgjIN\src\statmodels.jl:80
(::Type{T})(z::Complex) where T<:Real @ Base complex.jl:44

Possible fix, define
  StatsBase.TestStat(::Complex)

Ambiguity #6
sort!(vs::AbstractVector{T}, lo::Int64, hi::Int64, ::SortingAlgorithms.RadixSortAlg, o::Base.Order.Ordering, ts::Union{Nothing, AbstractVector{T}}) where T @ SortingAlgorithms C:\Users\MrJSa\.julia\packages\SortingAlgorithms\n1AWW\src\SortingAlgorithms.jl:527
sort!(v::AbstractVector, lo::Integer, hi::Integer, a::Base.Sort.Algorithm, o::Base.Order.Ordering, scratch::Vector) @ Base.Sort sort.jl:2128

Possible fix, define
  sort!(::AbstractVector{T}, ::Int64, ::Int64, ::SortingAlgorithms.RadixSortAlg, ::Base.Order.Ordering, ::Vector{T}) where T

Method ambiguity: Test Failed at C:\Users\MrJSa\.julia\packages\Aqua\utObL\src\ambiguities.jl:117
  Expression: success(pipeline(cmd; stdout = stdout, stderr = stderr))

Stacktrace:
 [1] macro expansion
   @ Aqua C:\Users\MrJSa\AppData\Local\Programs\Julia-1.10\share\julia\stdlib\v1.10\Test\src\Test.jl:478 [inlined]
 [2] _test_ambiguities(packages::Vector{Base.PkgId}; color::Nothing, exclude::Vector{Any}, detect_ambiguities_options::Base.Pairs{Symbol, Union{}, Tuple{}, @NamedTuple{}})
   @ Aqua C:\Users\MrJSa\.julia\packages\Aqua\utObL\src\ambiguities.jl:117
Test Summary:    | Fail  Total  Time
Method ambiguity |    1      1  4.6s
ERROR: Some tests did not pass: 0 passed, 1 failed, 0 errored, 0 broken.
