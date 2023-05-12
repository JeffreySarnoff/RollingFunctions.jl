#=
- nrows
- ncols

- rts  (r[eturned] t[ype]s)
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

@inline asviewtype(::Type{T}, dta) where {T} =
        eltype(dta) === T ? asview(dta) : asview([T(x) for x in dta])


# commontype from within a Union

union_types(x::Union) = (x.a, union_types(x.b)...)
union_types(x::Type) = (x,)
union_common(x::Union) = setdiff(union_types(x), (Missing, Nothing))

commontype(x::Union) = union_common(x)[1]
commontype(::Type{T}) where {T} = T

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
    nrolling(nseq, width)

length obtained from seq with width as the window size
"""
nrolling(nseq, width) = nseq - width + 1

"""
    nimputed_rolling(nseq, width)

count of values to be imputed from seq with width as the window size
"""
nimputed_rolling(nseq, width) = width - 1

"""
    nrunning(nseq, width)

length obtained from seq with width as the window size
"""
nrunning(nseq, width) = nrolling(nseq, width)

"""
    nimputed_running(nseq, width)

count of values to be tapered from seq with width as the window size
"""
nimputed_running(nseq, width) = nseq - nrunning(nseq, width)

"""
    ntiling(nseq, width, tile)

length obtained from seq with width as the window size
and tile as the tiling step
"""
ntiling(nseq, width) = div(nseq, width)

ntiling(nseq, width, tile) =
        if width <= tile
            div(nseq, tile)
        else # width > tile
            # width <= nseq - k*tile < 2width
            div(nseq, tile)
            div(nseq - width - 1, tile)
        end

"""
    nimputed_tiling(nseq, width, tile)

count of values to be imputed from seq with
width as the window size and tile as the tiling step
"""
nimputed_tiling(nseq, width) = !iszero(rem(nseq, width)) ? 1 : 0

function nimputed_tiling(nseq, width, tile)
    if width == tile
        rem(nseq, width)
    else # width > tile
        nseq_atmost = nimputed_rolling(nseq, tile) * tile
        nimputed_rolling(nseq_atmost, width)
    end
end

function wholesparts(n, width, slide)
    if slide < width
        nwindows = fld(n - slide, slide)
        m = n - nwindows * slide
        nwindows += m >= width
        m -= slide
        if m == width
            nwindows += 1
            nextraindices = 0
        else
            nextraindices = m
        end
        return (; nwindows, nextraindices)
    elseif slide >= width
        nwindows, nextraindices = fldmod(n, slide)
        return (; nwindows, nextraindices)
    else
        nwindows = 0
        nextraindices = n
        return (; nwindows, nextraindices)
    end
end
