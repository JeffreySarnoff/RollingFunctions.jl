weight isa AbstractWeights
weights isa AbstractVector{<:AbstractVector}

weight2matrix(weight,ncolumns) = Base.stack(repeat([weight], ncolumns))
