getcolumn(x::AbstractVector{T}, colidx::Int) where {T} =
   colidx === 1 ? x : throw(DomainError("colidx ($colidx) > 1"))

getcolumn(x::AbstractArray{T,2}, colidx::Int) where {T} =
   1 <= colidx <= 2 ? x[:,colidx] : throw(DomainError("!(1 <= colidx ($colidx) <= 2)"))

function getcolumn(x::AbstractArray{T,3}, colidx::Tuple{Int,Int}) where {T}
   colidx = minmax(colidx[1], colidx[2])
   if colidx === (1,2)
      x[1,2,:]
   elseif colidx === (1,3)
      x[1,:,3]
   elseif colidx === (2,3)
      x[:,2,3]
   else
      throw(DomainError("bad colidx ($colidx)"))
   end
end

if @isdefined DataFrames
   # get DataFrame column from the string form of the column id
   getcolumn(df::DataFrames.DataFrame, str::String) = getindex(df, Symbol(str))
   getcolumn(df::DataFrames.DataFrame, sym::Symbol) = df[sym]
else
   println("DataFrames not defined")
end

if @isdefined TimeSeries
   # get TimeArray column from the symbol form of the column id
   getcolumn(ta::TimeSeries.TimeArray, sym::Symbol) = getindex(ta, string(sym)).values
   getcolumn(ta::TimeSeries.TimeArray, str::String) = getindex(ta, str).values
else
   println("TimeSeries not defined")
end
