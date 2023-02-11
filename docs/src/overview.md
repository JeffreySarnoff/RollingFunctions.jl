
- You have a data sequence 𝐷𝑎𝑡𝑎, for now it is a Vector[1, 2, 3, 4, 5].
- The window span 𝑆𝑝𝑎𝑛 of each subsequence is3.
- The function 𝐹𝑢𝑛𝑐 to be applied over subsequences of 𝐷𝑎𝑡𝑎 issum.


using RollingFunctions

 𝐷𝑎𝑡𝑎 = [1, 2, 3, 4, 5]
𝐹𝑢𝑛𝑐 = sum
𝑆𝑝𝑎𝑛 = 3

rolled = rolling(𝐹𝑢𝑛𝑐, 𝐷𝑎𝑡𝑎, 𝑆𝑝𝑎𝑛)


julia> rolled
3-element Vector{Int64}:
  6
  9
 12

#=
The first  windowed value is the 𝐹𝑢𝑛𝑐 (sum) of the first  𝑆𝑝𝑎𝑛 (3) values in 𝐷𝑎𝑡𝑎.
The second windowed value is the 𝐹𝑢𝑛𝑐 (sum) of the second 𝑆𝑝𝑎𝑛 (3) values in 𝐷𝑎𝑡𝑎.
The third  windowed value is the 𝐹𝑢𝑛𝑐 (sum) of the third  𝑆𝑝𝑎𝑛 (3) values in 𝐷𝑎𝑡𝑎.

There can be no fourth value as the third value used the fins entries in 𝐷𝑎𝑡𝑎.
=#

julia> sum( 𝐷𝑎𝑡𝑎[1:3]), sum( 𝐷𝑎𝑡𝑎[2:4]), sum( 𝐷𝑎𝑡𝑎[3:5])
(6, 9, 12)


If the span of each subsequence increases to 4..

𝑆𝑝𝑎𝑛 = 4
rolled = rolling( 𝐷𝑎𝑡𝑎, 𝑆𝑝𝑎𝑛, 𝒮);

rolled
2-element Vector{Int64}:
 10
 14

Generally, with data that has r rows using a window_span of w results in r - w + 1 rows of values.


### To get back a result with the same number of rows as your data

#### Welcome to the wonderful world of padding

You may pad the result with the padding value of your choice
-padding is a keyword argument
- if you assign e.g.padding = missing, the result will be padded

missing, 0.0 are commonly used, however all values saveNothing are permitted
   -- usingnothing as the padding is allowed; using the typeNothing is not


using RollingFunctions

 𝐷𝑎𝑡𝑎 = [1, 2, 3, 4, 5]
𝐹𝑢𝑛𝑐 = sum
𝑆𝑝𝑎𝑛 = 3

rolled = rolling(𝐹𝑢𝑛𝑐, 𝐷𝑎𝑡𝑎, 𝑆𝑝𝑎𝑛; padding = missing);

julia> rolled
5-element Vector{Union{Missing, Int64}}:
   missing
   missing
   missing
 10
 14
 
rolled = rolling( 𝐷𝑎𝑡𝑎, 𝑆𝑝𝑎𝑛, 𝒮; padding = zero(eltype( 𝐷𝑎𝑡𝑎));
julia> rolled
5-element Vector{Int64}:
  0
  0
  0
 10
 14


### Give me the real values first, pad to the end.


rolled = rolling(𝐹𝑢𝑛𝑐, 𝐷𝑎𝑡𝑎, 𝑆𝑝𝑎𝑛; padding = zero(eltype( 𝐷𝑎𝑡𝑎), padlast=true);
julia> rolled
5-element Vector{Int64}:
 10
 14
  0
  0
  0


**technical note:** this is not the same asreverse(rolling( 𝐷𝑎𝑡𝑎, 𝑆𝑝𝑎𝑛, 𝒮; padding = zero(eltype( 𝐷𝑎𝑡𝑎)).

