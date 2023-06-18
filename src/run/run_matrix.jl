#=
     taperfirst(fn::F, width, ::Matrix)
     taperfinal(fn::F, width, ::Matrix)

     taperfirst(fn::F, width, ::Matrix, weights)
     taperfinal(fn::F, width, ::Matrix, weights)
=#

function taperfirst(fn::F, width::Integer, data::AbstractMatrix{T}) where {T,F<:Function}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    rettype = rts(fn, (T,))

    # only completed width coverings are fully resolvable
    # the first (width - 1) values are to be tapered
    taper_idxs = 1:width-1

    results = Matrix{rettype}(undef, size(ᵛʷdata))

    ilow = 1
    @inbounds for idx in taper_idxs
       @views results[idx, :] .= map(fn, eachcol(ᵛʷdata[ilow:idx, :]))
    end

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views results[idx, :] .= map(fn, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function taperfinal(fn::F, width::Integer, data::AbstractMatrix{T}) where {T, F<:Function}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    rettype = rts(fn, (T,))

    # only completed width coverings are fully resolvable
    # the last (width - 1) values are to be tapered
    taper_idxs = n-width+2:n

    results = Matrix{rettype}(undef, size(ᵛʷdata))

    @inbounds for idx in taper_idxs
        @views results[idx, :] .= map(fn, eachcol(ᵛʷdata[idx:n, :]))
    end

    ilow, ihigh = 1, width
    @inbounds for idx in 1:n-width+1
        @views results[idx, :] .= map(fn, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# weighted

function taperfirst(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::AbstractWeights{T}) where {T,F<:Function}
    colcount = ncols(data)
    mweights = vmatrix(weighting, colcount)

    taperfirst(fn, width, data, mweights)
end

function taperfirst(fn::F, width::Integer,
    data::AbstractMatrix{T}, weights::VectorOfVectors{T}) where {T,F<:Function}
    mweights = vmatrix(weights)

    taperfirst(fn, width, data, mweights)
end

@inline function taperfirst(fn::F, width::Integer,
    data::AbstractMatrix{T}, weights::AbstractMatrix{T}) where {T,F<:Function}
    ᵛʷdata = asview(data)
    ᵛʷweights = asview(weights)

    taperfirst(fn, width, ᵛʷdata, ᵛʷweights)
end

function taperfirst(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::AbstractWeights{W}) where {T,W,F<:Function}
    if T <: Integer
        return taperfirst(fn, width, Matrix{W}(data), weighting)
    end

    colcount = ncols(data)
    mweights = vmatrix(Vector{T}(weighting), colcount)
    taperfirst(fn, width, data, mweights)
end

function taperfirst(fn::F, width::Integer,
    data::AbstractMatrix{T}, weights::VectorOfVectors{W}) where {T,W,F<:Function}
    if T <: Integer
        return taperfirst(fn, width, Matrix{W}(data), weighting)
    end

    mweights = Matrix{T}(vmatrix(weights))
    taperfirst(fn, width, data, mweights)
end

@inline function taperfirst(fn::F, width::Integer,
    data::AbstractMatrix{T}, weights::AbstractMatrix{W}) where {T,W,F<:Function}
    if T <: Integer
        return taperfirst(fn, width, Matrix{W}(data), weighting)
    end

    mweights = Matrix{T}(weights)
    taperfirst(fn, width, data, weights)
end

function taperfirst(fn::F, width::Integer, 
                    ᵛʷdata::ViewOfMatrix{T}, vwweights::ViewOfMatrix{T}) where {T,F<:Function}
    rettype = rts(fn, (T,))
    results = Matrix{rettype}(undef, size(ᵛʷdata))

    # only completed width coverings are fully resolvable
    # the first (width - 1) values are to be tapered
    taper_idxs = 1:width-1

    ilow = 1
    @inbounds for idx in taper_idxs
        @views results[idx, :] = mapslices1(fn, ᵛʷdata[ilow:idx, :] .* mapnormalize1(vwweights[1:idx,:]))
    end

    ilow, ihigh = 1, width
    @inbounds for idx in width:nrows(ᵛʷdata)
        @views results[idx, :] = mapslices1(fn, ᵛʷdata[ilow:ihigh, :] .* vwweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

#
# taper the last (most recent) values
#

function taperfinal(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::AbstractWeights{T}) where {T,F<:Function}
    colcount = ncols(data)
    mweights = vmatrix(weighting, colcount)

    taperfinal(fn, width, data, mweights)
end

function taperfinal(fn::F, width::Integer,
    data::AbstractMatrix{T}, weights::VectorOfVectors{T}) where {T,F<:Function}
    mweights = vmatrix(weights)

    taperfinal(fn, width, data, mweights)
end

@inline function taperfinal(fn::F, width::Integer,
    data::AbstractMatrix{T}, weights::AbstractMatrix{T}) where {T,F<:Function}
    ᵛʷdata = asview(data)
    ᵛʷweights = asview(weights)

    taperfinal(fn, width, ᵛʷdata, ᵛʷweights)
end

function taperfinal(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::AbstractWeights{W}) where {T,W,F<:Function}
    if T <: Integer
        return taperfinal(fn, width, Matrix{W}(data), weighting)
    end

    colcount = ncols(data)
    mweights = vmatrix(Vector{T}(weighting), colcount)
    taperfinal(fn, width, data, mweights)
end

function taperfinal(fn::F, width::Integer,
    data::AbstractMatrix{T}, weights::VectorOfVectors{W}) where {T,W,F<:Function}
    if T <: Integer
        return taperfinal(fn, width, Matrix{W}(data), weighting)
    end

    mweights = Matrix{T}(vmatrix(weights))
    taperfinal(fn, width, data, mweights)
end

@inline function taperfinal(fn::F, width::Integer,
    data::AbstractMatrix{T}, weights::AbstractMatrix{W}) where {T,W,F<:Function}
    if T <: Integer
        return taperfinal(fn, width, Matrix{W}(data), weighting)
    end

    mweights = Matrix{T}(weights)
    taperfinal(fn, width, data, weights)
end

function taperfinal(fn::F, width::Integer, ᵛʷdata::ViewOfMatrix{T}, ᵛʷweights::ViewOfMatrix{T}) where {T,F<:Function}
    nr = nrows(ᵛʷdata)
    rettype = rts(fn, (T,))
    results = Matrix{rettype}(undef, size(ᵛʷdata))

    # only completed width coverings are fully resolvable
    # the last (width - 1) values are to be tapered
    taper_idxs = nr-width+2:nr

    @inbounds for idx in taper_idxs
        @views results[idx, :] = mapslices1(fn, ᵛʷdata[idx:nr, :] .* mapnormalize1(ᵛʷweights[nr:-1:idx]))
    end

    ilow, ihigh = 1, width
    @inbounds for idx in 1:nr-width+1
        @views results[idx, :] = mapslices1(fn, ᵛʷdata[ilow:ihigh, :] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end
