#=
- nrows
- ncols

- rts (returned types)
- nrts (length(rts))

- FixTwo
- FixThree

- isview
- asview
- viewall

- commontype

- oneormore

- filling
=#

"""
    nrows(x)
count the rows of x
"""
nrows

"""
    ncols(x)
count the columns of x
"""
ncols

nrows(x::AbstractVector) = length(x)
nrows(x::AbstractArray) = size(x)[1]
nrows(x) = isempty(size(x)) ? 1 : size(x)[1]

ncols(x::AbstractVector) = 1
ncols(x::AbstractArray) = size(x)[2]
ncols(x) = isempty(size(x)) ? 1 : size(x)[2]

# isNothing

isNothing(x) = false
isNothing(::Type{Nothing}) = true

# returned types (rough) and tally(returned types)
# more specific when `typs` are provided

@inline rts(fn) = Base.return_types(fn)[max(1, end - 1)]
@inline rts(fn, typs) = Base.return_types(fn, typs)[max(1, end - 1)]

@inline nrts(fn) = max(1, length(rts(fn).parameters))
@inline nrts(fn, typs) = max(1, length(rts(fn, typs).parameters))

# FixTwo

"""
    FixTwo(f, x, y, z)

A type representing a partially-applied version of the three-argument function
`f`, with the first argument fixed to the value "x" and the second argument
fixed to the value "y". In other words,
`FixTwo(f, x, y)` behaves similarly to `z->f(x, y, z)`.

klamp(lo, hi, x) = clamp(x, lo, hi)
klamp(lo, hi) = FixTwo(klamp, lo, hi)
klamp1to4 = klamp(1.0,4.0)
klamp1to4(0.0)

See also [`Fix1`](@ref Base.Fix1).
"""
struct FixTwo{F,T} <: Function
    f::F
    x::T
    y::T

    FixTwo(f::F, x, y) where {F} = new{F,Base._stable_typeof(x)}(f, x, y)
    FixTwo(f::Type{F}, x, y) where {F} = new{Type{F},Base._stable_typeof(x)}(f, x, y)
end

(f::FixTwo)(z) = f.f(f.x, f.y, z)

"""
    FixThree(f, x, y, z, w)

A type representing a partially-applied version of the three-argument function
`f`, with the first argument fixed to the value "x" and the second argument
fixed to the value "y". In other words,
`FixThree(f, x, y, z)` behaves similarly to `w->f(x, y, z, w)`.
"""
struct FixThree{F,T} <: Function
    f::F
    x::T
    y::T
    z::T

    FixThree(f::F, x, y, z) where {F} = new{F,Base._stable_typeof(x)}(f, x, y, z)
    FixThree(f::Type{F}, x, y, z) where {F} = new{Type{F},Base._stable_typeof(x)}(f, x, y, z)
end

(f::FixThree)(w) = f.f(f.x, f.y, f.z, w)

# views

@inline isview(data) = isa(data, SubArray)
@inline asview(data) = isview(data) ? data : viewall(data)

@inline viewall(data::A) where {T,A<:AbstractArray{T,1}} = view(data, :)
@inline viewall(data::A) where {T,A<:AbstractArray{T,2}} = view(data, :, :)
@inline viewall(data::A) where {T,A<:AbstractArray{T,3}} = view(data, :, :, :)
@inline viewall(data::A) where {T,A<:AbstractArray{T,4}} = view(data, :, :, :, :)

@inline isview(x::Unweighted) = true
@inline asview(x::Unweighted) = x
@inline viewall(x::Unweighted) = x

#=
@inline viewall(data::Tuple{Vararg{T,N}}) where {T,N} = viewall(convert(Vector{T}, data))
Base.convert(::Type{Vector{T}}, tup::Tuple{Vararg{T,N}}) where {T,N} = [ tup... ]
=#

# commontype from within a Union

union_types(x::Union) = (x.a, union_types(x.b)...)
union_types(x::Type) = (x,)
union_common(x::Union) = setdiff(union_types(x), (Missing, Nothing))

commontype(x::Union) = union_common(x)[1]
commontype(::Type{T}) where {T} = T

#=
# none, onlyone, oneormore, onlytwo, twoormore, ..., twelveormore


#=
   none(...)
   only{one,two,three,..,twelve}(...)
   {one,two,three,..,twelve}ormore(...)
=#

none() = true
none(x::Nothing) = true
none(x) = false

namedints = ((:one, 1), (:two, 2), (:three, 3), (:four, 4),
             (:five, 5), (:six, 6), (:seven, 7), (:eight, 8),
             (:nine, 9), (:ten, 10), (:eleven, 11), (:twelve, 12))

for (Nm, N) in namedints
    fnstr = "only" * string(Nm)
    fnsym = Symbol(fnstr)
    fn = fnsym
    @eval begin
        ($fn)(x::Vararg{Any,K}) where {K} = false
        ($fn)(x::Vararg{T,$N}) where {T} = true
        ($fn)(x::Vararg{<:Union{<:AbstractVector, <:NTuple},$N}) = true
    end
end

const maxtrueint = length(namedints)

for (Nm, N) in namedints
    lowfalses = collect(0:(N-1))
    hightrues = collect(N:maxtrueint)

    fnstr = string(Nm) * "ormore"
    fnsym = Symbol(fnstr)
    fn = fnsym

    for K in lowfalses
        @eval ($fn)(x::Vararg{Any,$K}) = false
    end
    for K in hightrues
        @eval ($fn)(x::Vararg{Any,$K}) = true
        @eval ($fn)(x::Vararg{<:Union{<:AbstractVector,<:NTuple},$K}) = true
    end
end
=#

# filling

function fills(filler::T, data::AbstractVector{T}) where {T}
    nvals = axes(data)[1].stop
    return fill(filler, nvals)
end

function fills(filler::T1, data::AbstractVector{T2}) where {T1,T2}
    elemtype = Union{T1,T2}
    nvals = axes(data)[1].stop
    result = Array{elemtype,1}(undef, nvals)
    result[:] = filler
    return result
end

# number of values to be obtained

"""
    nrolled(nseq, span)

length obtained from seq with span as the window size
"""
nrolled(nseq, span) = nseq - span + 1

"""
    nimputed_rolling(nseq, span)

count of values to be imputed from seq with span as the window size
"""
nimputed_rolling(nseq, span) = span - 1

"""
    ntiled(nseq, span, tile)

length obtained from seq with span as the window size
and tile as the tiling step
"""
ntiled(nseq, span) = div(nseq, span)

ntiled(nseq, span, tile) =
        if span <= tile
            div(nseq, tile)
        else # span > tile
            # span <= nseq - k*tile < 2span
            div(nseq, tile)
            div(nseq - span - 1, tile)
        end

"""
    nimputed_tiling(nseq, span, tile)

count of values to be imputed from seq with
span as the window size and tile as the tiling step
"""
function nimputed_tiling(nseq, span) = 1

function nimputed_tiling(nseq, span, tile)
    if span == tile
        rem(nseq, span)
    else # span > tile
        nseq_atmost = nimputed_rolling(nseq, tile) * tile
        nimputed_rolling(nseq_atmost, span)
    end
end

#=

ntiled(nseq, span, tile=span) =
    function swi(s, w, i)
        ls = length(s)
        lo = 1 + i * w
        hi = (1 + i) * w
        iq = div(ls, w)
        ir = rem(ls, w)
        if ls < hi
            return (ls - ir + 1, ls)
        end
        return sw(s, w, i)
    end


# number of values to be imputed

"""
    nimputed(nseq, span)

count of values to be imputed from seq with span as the window size
"""
nimputed(nseq, span) = span - 1

"""
    nimputed(nseq, span, tile)

count of values to be imputed from seq with span as the window size
and tile as the tiling step
"""
nimputed(nseq, span, tile) = rem(nrolled(nseq, span), tile)

function nfilled(windowspan::T) where {T<:Signed}
    windowspan < 1 && throw(SpanError(seqlength, windowspan))

    return windowspan - 1
end

=#

