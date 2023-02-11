You have a data sequence 𝐃𝐚𝐭𝐚, for our initial purposes it is a Vector [1, 2, 3, 4, 5].
The span of each subsequence is 3.
The function to be applied over subsequences of 𝐃𝐚𝐭𝐚 is sum.
```
using RollingFunctions

𝐃𝐚𝐭𝐚 = [1, 2, 3, 4, 5]
𝐅𝐮𝐧𝐜 = sum
𝐒𝐩𝐚𝐧 = 3

result = running(𝐅𝐮𝐧𝐜, 𝐃𝐚𝐭𝐚, 𝐒𝐩𝐚𝐧)
julia> result
3-element Vector{Int64}:
  6
  9
 12

#=
The first  windowed value is the 𝐅𝐮𝐧𝐜 (`sum`) of the first  𝐒𝐩𝐚𝐧 (`3`) values in 𝐃𝐚𝐭𝐚.
The second windowed value is the 𝐅𝐮𝐧𝐜 (`sum`) of the second 𝐒𝐩𝐚𝐧 (`3`) values in 𝐃𝐚𝐭𝐚.
The third  windowed value is the 𝐅𝐮𝐧𝐜 (`sum`) of the third  𝐒𝐩𝐚𝐧 (`3`) values in 𝐃𝐚𝐭𝐚.

There can be no fourth value as the third value used the fins entries in 𝐃𝐚𝐭𝐚.
=#

julia> sum(𝐃𝐚𝐭𝐚[1:3]), sum(𝐃𝐚𝐭𝐚[2:4]), sum(𝐃𝐚𝐭𝐚[3:5])
(6, 9, 12)
If the span of each subsequence increases to 4..

𝐒𝐩𝐚𝐧 = 4
result = running(𝐅𝐮𝐧𝐜, 𝐃𝐚𝐭𝐚, 𝐒𝐩𝐚𝐧);

result
2-element Vector{Int64}:
 10
 14
```
Generally, with data that has r rows using a window_span of w results in r - w + 1 rows of values.


