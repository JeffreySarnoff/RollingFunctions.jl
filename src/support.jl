if @isdefined DataFrames
   # get DataFrame column from the string form of the column id
   getcolumn(df::DataFrame, str::String) = getindex(df, Symbol(str))
   getcolumn(df::DataFrame, sym::Symbol) = df[sym]
end

if @isdefined TimeSeries
   # get TimeArray column from the symbol form of the column id
   getcolumn(ta::TimeArray, sym::Symbol) = getindex(ta, string(sym)).values
   getcolumn(ta::TimeArray, str::String) = getindex(ta, str).values
end
