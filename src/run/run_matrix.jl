#=
     taperfirst(fn::F, width, ::Matrix)
     taperfinal(fn::F, width, ::Matrix)

     taperfirst(fn::F, width, ::Matrix, weighting)
     taperfinal(fn::F, width, ::Matrix, weighting)
=#


function taperfirst(fn::F, width::Integer, data1::AbstractMatrix{T}; padding=nopadding) where {F<:Function,T}
    ᵛʷdata1 = asview(data1)
    if padding == nopadding
        taperfirst(fn, width, ᵛʷdata1)
    else
        taperfirst(fn, width, ᵛʷdata1, padding)
    end
end

function taperfirst(fn::F, width::Integer, ᵛʷdata::ViewOfMatrix{T}, padding) where {T,F<:Function}
    result = taperfirst(fn, width, ᵛʷdata)
    for c = 1:ncols(result)
        for r = 1:nrows(result)
            if !isnan(result[r,c])
                break
            else
                result[r,c] = padding
            end
        end
    end
    result
end

function taperfirst(fn::F, width::Integer, ᵛʷdata::ViewOfMatrix{T}) where {T,F<:Function}
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

function taperfinal(fn::F, width::Integer, data1::AbstractMatrix{T}; padding=nopadding) where {F<:Function,T}
    ᵛʷdata1 = asview(data1)
    if padding == nopadding
        taperfinal(fn, width, ᵛʷdata1)
    else
        taperfinal(fn, width, ᵛʷdata1, padding)
    end
end

function taperfinal(fn::F, width::Integer, ᵛʷdata::ViewOfMatrix{T}, padding) where {T,F<:Function}
    result = taperfinal(fn, width, ᵛʷdata)
    for c = 1:ncols(result)
        for r = nrows(result):-1:1
            if !isnan(result[r,c])
                break
            else
                result[r,c] = padding
            end
        end
    end
    result
end

function taperfinal(fn::F, width::Integer, ᵛʷdata::ViewOfMatrix{T}) where {T, F<:Function}
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
    data1::AbstractMatrix{T}, weighting::AbstractWeights{T}; 
    padding=nopadding) where {F<:Function,T}
    colcount = ncols(data1)
    check_width(width, length(weighting))
    mweights = vmatrix(weighting, ncols(data1))
    ᵛʷmweights = asview(mweights)

    ᵛʷdata1 = asview(data1)

    if padding == nopadding
        taperfirst(fn, width, ᵛʷdata1, ᵛʷmweights)
    else
        taperfirst(fn, width, ᵛʷdata1, ᵛʷmweights, padding)
    end
end

#= function taperfirst(fn::F, width::Integer,
    data1::AbstractMatrix{T}, weighting::AbstractWeights{T};
    padding=nopadding) where {T,F<:Function}
    ᵛʷdata1 = asview(data1)
    mweights = vmatrix(weighting, ncols(data1))
    ᵛʷmweights = asview(mweights)

    taperfirst(fn, width, ᵛʷdata1, ᵛʷmweights; padding)
end =#

function taperfirst(fn::F, width::Integer, 
    data1::AbstractMatrix{T}, weighting::VectorVectors{T};
    padding=nopadding) where {T,F<:Function}
    ᵛʷdata1 = asview(data1)
    colcount = ncols(data1)
    check_lengths(colcount, length(weighting))
    mweights = vmatrix(weighting)
    ᵛʷmweights = asview(mweights)

    taperfirst(fn, width, ᵛʷdata1, ᵛʷmweights; padding)
end

function taperfirst(fn::F, width::Integer,
    data1::AbstractMatrix{T}, weighting::AbstractMatrix{T};
    padding=nopadding) where {T,F<:Function}

    ᵛʷdata1 = asview(data1)
    colcount = ncols(data1)
    check_lengths(colcount, ncols(weighting))
    check_width(width, nrows(weighting))
    ᵛʷmweights = asview(weighting)

    if padding == nopadding
        taperfirst(fn, width, ᵛʷdata1, ᵛʷmweights)
    else
        taperfirst(fn, width, ᵛʷdata1, ᵛʷmweights, padding)
    end
end

function taperfirst(fn::F, width::Integer, 
                    ᵛʷdata1::ViewOfMatrix{T}, ᵛʷweights::ViewOfMatrix{T}) where {T,F<:Function}
    rettype = rts(fn, (T,))
    results = Matrix{rettype}(undef, size(ᵛʷdata1))

    # only completed width coverings are fully resolvable
    # the first (width - 1) values are to be tapered
    taper_idxs = 1:width-1

    ilow = 1
    @inbounds for idx in taper_idxs
        @views results[idx, :] = mapslices1(fn, ᵛʷdata1[ilow:idx, :] .* mapnormalize1(ᵛʷweights[1:idx, :]))
    end

    ilow, ihigh = 1, width
    @inbounds for idx in width:nrows(ᵛʷdata1)
        @views results[idx, :] = mapslices1(fn, ᵛʷdata1[ilow:ihigh, :] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function taperfirst(fn::F, width::Integer, 
                    ᵛʷdata1::ViewOfMatrix{T}, ᵛʷweights::ViewOfMatrix{T}, padding) where {T,F<:Function}
    result = basic_taperfirst(fn, width, ᵛʷdata1, ᵛʷweights)
    for c = 1:ncols(result)
        for r = 1:nrows(result)
            if !isnan(result[r,c])
                break
            else
                result[r,c] = padding
            end
        end
    end
    result
end


function taperfirst(fn::F, width::Integer,
    data1::AbstractMatrix{T}, weighting::AbstractWeights{W};
    padding=nopadding) where {T,W,F<:Function}
    if T <: Integer
        T2 = innertype(weighting)
        return taperfirst(fn, width, Matrix{T2}(data1), weighting)
    end

    colcount = ncols(data1)
    mweights = vmatrix(Vector{T}(weighting), colcount)
    taperfirst(fn, width, data1, mweights)
end

function taperfirst(fn::F, width::Integer,
    data1::AbstractMatrix{T}, weighting::VectorOfWeights{W}) where {T,W,F<:Function}
    if T <: Integer
        T2 = innertype(weighting)
        return taperfirst(fn, width, Matrix{T2}(data1), weighting)
    end

    mweights = Matrix{T}(vmatrix(weighting))
    taperfirst(fn, width, data1, mweights)
end

@inline function taperfirst(fn::F, width::Integer,
    data1::AbstractMatrix{T}, weighting::AbstractMatrix{W};
    padding=nopadding) where {T,W,F<:Function}
    if T <: Integer
        T2 = innertype(weighting)
        return taperfirst(fn, width, Matrix{T2}(data1), weighting)
    end

    mweights = Matrix{T}(weighting)
    taperfirst(fn, width, data1, weighting)
end

#
# taper the last (most recent) values
#

function taperfinal(fn::F, width::Integer,
    data1::AbstractMatrix{T}, weighting::AbstractWeights{T};
    padding=nopadding) where {T,F<:Function}
    ᵛʷdata1 = asview(data1)
    colcount = ncols(data1)
    mweights = vmatrix(weighting, colcount)
    ᵛʷmweights = asview(mweights)

    taperfinal(fn, width, ᵛʷdata1, ᵛʷmweights; padding)
end

function taperfinal(fn::F, width::Integer,
    data1::AbstractMatrix{T}, weighting::VectorOfWeights{W};
    padding=nopadding) where {T,W,F<:Function}
    if T <: Integer
        T2 = innertype(weighting)
        return taperfinal(fn, width, Matrix{T2}(data1), weighting)
    end

    mweights = Matrix{T}(vmatrix(weighting))
    taperfinal(fn, width, data1, mweights)
end

function taperfinal(fn::F, width::Integer,
    data1::AbstractMatrix{T}, weighting::AbstractMatrix{T};
    padding=nopadding) where {T,F<:Function}
    ᵛʷdata1 = asview(data1)
    colcount = ncols(data1)
    check_lengths(colcount, ncols(weighting))
    check_width(width, nrows(weighting))
    ᵛʷmweights = asview(weighting)

    if padding == nopadding
        taperfinal(fn, width, ᵛʷdata1, ᵛʷmweights)
    else
        taperfinal(fn, width, ᵛʷdata1, ᵛʷmweights, padding)
    end
end

#= =#

function taperfinal(fn::F, width::Integer, 
                    ᵛʷdata1::ViewOfMatrix{T}, ᵛʷweights::ViewOfMatrix{T}) where {T,F<:Function}
    rettype = rts(fn, (T,))
    results = Matrix{rettype}(undef, size(ᵛʷdata1))

    # only completed width coverings are fully resolvable
    # the first (width - 1) values are to be tapered
    nr = nrows(ᵛʷdata1)
    taper_idxs = nr-width+2:nr

    ilow = 1
    @inbounds for idx in taper_idxs
        @views results[idx, :] = mapslices1(fn, ᵛʷdata1[ilow:idx, :] .* mapnormalize1(ᵛʷweights[1:idx, :]))
    end

    ilow, ihigh = 1, width
    @inbounds for idx in width:nrows(ᵛʷdata1)
        @views results[idx, :] = mapslices1(fn, ᵛʷdata1[ilow:ihigh, :] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function taperfinal(fn::F, width::Integer, 
                    ᵛʷdata1::ViewOfMatrix{T}, ᵛʷweights::ViewOfMatrix{T}, padding) where {T,F<:Function}
    result = taperfinal(fn, width, ᵛʷdata1, ᵛʷweights)
    for c = 1:ncols(result)
        for r = nrows(result):-1:1
            if !isnan(result[r,c])
                break
            else
                result[r,c] = padding
            end
        end
    end
    result
end


#=
function taperfinal(fn::F, width::Integer,
    data1::AbstractMatrix{T}, weighting::AbstractWeights{T}) where {T,F<:Function}
    colcount = ncols(data1)
    mweights = vmatrix(weighting, colcount)

    taperfinal(fn, width, data1, mweights)
end

function taperfinal(fn::F, width::Integer,
    data1::AbstractMatrix{T}, weighting::VectorOfVectors{T}) where {T,F<:Function}
    mweights = vmatrix(weighting)

    taperfinal(fn, width, data1, mweights)
end

@inline function taperfinal(fn::F, width::Integer,
    data1::AbstractMatrix{T}, weighting::AbstractMatrix{T}) where {T,F<:Function}
    ᵛʷdata1 = asview(data1)
    ᵛʷweights = asview(weighting)

    taperfinal(fn, width, ᵛʷdata1, ᵛʷweights)
end

function taperfinal(fn::F, width::Integer,
    data1::AbstractMatrix{T}, weighting::AbstractWeights{W}) where {T,W,F<:Function}
    if T <: Integer
        T2 = innertype(weighting)
        return taperfinal(fn, width, Matrix{T2}(data1), weighting)
    end

    colcount = ncols(data1)
    mweights = vmatrix(Vector{T}(weighting), colcount)
    taperfinal(fn, width, data1, mweights)
end

function taperfinal(fn::F, width::Integer,
    data1::AbstractMatrix{T}, weighting::VectorOfVectors{W}) where {T,W,F<:Function}
    if T <: Integer
        T2 = innertype(weighting)
        return taperfinal(fn, width, Matrix{T2}(data1), weighting)
    end

    mweights = Matrix{T}(vmatrix(weighting))
    taperfinal(fn, width, data1, mweights)
end

@inline function taperfinal(fn::F, width::Integer,
    data1::AbstractMatrix{T}, weighting::AbstractMatrix{W}) where {T,W,F<:Function}
    if T <: Integer
        T2 = innertype(weighting)
        return taperfinal(fn, width, Matrix{T2}(data1), weighting)
    end

    mweights = Matrix{T}(weighting)
    taperfinal(fn, width, data1, weighting)
end

function taperfinal(fn::F, width::Integer, ᵛʷdata1::ViewOfMatrix{T}, ᵛʷweights::ViewOfMatrix{T}) where {T,F<:Function}
    nr = nrows(ᵛʷdata1)
    rettype = rts(fn, (T,))
    results = Matrix{rettype}(undef, size(ᵛʷdata1))

    # only completed width coverings are fully resolvable
    # the last (width - 1) values are to be tapered
    taper_idxs = nr-width+2:nr

    @inbounds for idx in taper_idxs
        @views results[idx, :] = mapslices1(fn, ᵛʷdata1[idx:nr, :] .* mapnormalize1(ᵛʷweights[nr:-1:idx]))
    end

    ilow, ihigh = 1, width
    @inbounds for idx in 1:nr-width+1
        @views results[idx, :] = mapslices1(fn, ᵛʷdata1[ilow:ihigh, :] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end
=#