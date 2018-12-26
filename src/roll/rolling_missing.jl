# unweighted windowed function application

function rolling(fun::Function, data::AbstractVector{M}, windowspan::Int) where {T, M<:Union{Missing,T}}
    nvals  = nrolled(length(data), windowspan)
    offset = windowspan - 1
    result = zeros(Union{Missing,float(T)}, nvals)

    @inbounds for idx in eachindex(result)
        result[idx] = fun( view(data, idx:idx+offset) )
    end

    return result
end

# weighted windowed function application
function rolling(fun::Function, data::AbstractVector{M}, windowspan::Int, weighting::F) where
                    {T, N<:Number, M<:Union{Missing,T}, F<:Vector{N}}

    length(weighting) != windowspan &&
       throw(WeightsError(length(weighting), windowspan))

    nvals  = nrolled(length(data), windowspan)
    offset = windowspan - 1
    result = zeros(Union{Missing,float(T)}, nvals)
    curwin = zeros(Union{Missing,float(T)}, windowspan)
    v = view(weighting,1:length(weighting))

    @inbounds for idx in eachindex(result)
       for i=1:windowspan
           j = i + idx - 1
           curwin[i] = data[j] * v[i]
       end
       result[idx] = fun( curwin )
    end

    return result
end


rolling(fun::Function, data::AbstractVector{M}, windowspan::Int, weighting::W) where
                {T, N<:Number, M<:Union{Missing,T}, W<:AbstractWeights} =
    rolling(fun, data, windowspan, weighting.values)


# unweighted windowed function tapering

function tapers(fun::Function, data::AbstractVector{M}) where {T, M<:Union{Missing,T}}
    nvals  = length(data)
    result = zeros(Union{Missing,float(T)}, nvals) 

    @inbounds for idx in nvals:-1:1
        result[idx] = fun( view(data, 1:idx) )
    end

    return result
end

function tapers(fun::Function, data::AbstractVector{M}, ntocopy::Int) where {T, M<:Union{Missing,T}}
    nvals  = length(data)
    ntocopy = min(nvals, max(0, ntocopy))

    result = zeros(Union{Missing,float(T)}, nvals)
    if ntocopy > 0
       result[1:ntocopy] = data[1:ntocopy]
    end
    ntocopy += 1

    @inbounds for idx in nvals:-1:ntocopy
        result[idx] = fun( view(data, 1:idx) )
    end

    return result
end

function tapers(fun::Function, data::AbstractVector{M}, 
                trailing_data::AbstractVector{M}) where {T, M<:Union{Missing,T}}
    
    ntrailing = axes(trailing_data)[1].stop
    nvals  = length(data) + ntrailing
    result = zeros(Union{Missing,float(T)}, nvals)

    result[1:ntrailing] = trailing_data[1:ntrailing]
    ntrailing += 1

    @inbounds for idx in nvals:-1:ntrailing
        result[idx] = fun( view(data, 1:idx) )
    end

    return result
end

# weighted windowed function tapering

function tapers(fun::Function, data::AbstractVector{M}, weighting::F) where
                 {T, N<:Number, M<:Union{Missing,T}, F<:Vector{N}}

    nvals  = length(data)
    nweighting = length(weighting)
    
    nweighting == nvals || throw(WeightsError(nweighting, nvals))
    
    result = zeros(Union{Missing,float(T)}, nvals)

    @inbounds for idx in nvals:-1:1
        wts = normalize(view(weighting, (nweighting-idx+1):nweighting))
        result[idx] = fun( view(data, 1:idx) .* wts  )
    end

    return result
end

tapers(fun::Function, data::AbstractVector{M}, weighting::W) where
                {T, M<:Union{Missing,T}, W<:AbstractWeights} =
    tapers(fun, data, weighting.values)
