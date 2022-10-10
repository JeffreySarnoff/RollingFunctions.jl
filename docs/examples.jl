squares = (x^2 for x in 1:8);
data = [6x for x in squares]; # length(data) == 8
print(data)
# [6, 24, 54, 96, 150, 216, 294, 384]

N = length(data)                                 #  8
# 8
windowlength = 4                                 #  4

last_from_1 = length(data) - windowlength + 1    #  5  == 8 - 3
last_from_N = windowlength - 1                   #  3 ==  8 - 5

rolled_sum_direct_wlen4 =
    Tuple(map(Int, 
          rolling(sum, data, windowlength)))
# (180, 324, 516, 756, 1044)
n_rolled_direct = length(rolled_sum_direct_wlen4) #  5

runned_sum_direct_wlen4 =
    Tuple(map(Int, 
          running(sum, data, windowlength)))
# (6, 30, 84, 180, 324, 516, 756, 1044)
n_runned_direct = length(runned_sum_direct_wlen4) #  8


# i <- (1, 2, 3, 4, 5)
tuple4s_from1 = map(i->Tuple(data[i:i+windowlength-1]), 1:last_from_1)
5-element Vector{NTuple{4, Int64}}:
 (6, 24, 54, 96)
 (24, 54, 96, 150)
 (54, 96, 150, 216)
 (96, 150, 216, 294)
 (150, 216, 294, 384)

# i <- (4, 5, 6, 7, 8)
tuple4s_fromN = map(i->Tuple(data[i-last_from_N:i]), last_from_N+1:N)
5-element Vector{NTuple{4, Int64}}:
 (6, 24, 54, 96)
 (24, 54, 96, 150)
 (54, 96, 150, 216)
 (96, 150, 216, 294)
 (150, 216, 294, 384)

sum4tuples = Tuple( map(sum, tuples4_fromN) )
# (180, 324, 516, 756, 1044)

avg4tuples = map(x -> convert(Int, x // 4), sum4tuples)
# (45, 81, 129, 189, 261)


# again with 7 data entries


squares = (x^2 for x in 1:7);
data = [6x for x in squares]; # length(data) == 7
print(data)
# [6, 24, 54, 96, 150, 216, 294, 384]

N = length(data)                                 #  7

windowlength = 4                                 #  4

last_from_1 = length(data) - windowlength + 1    #  4  == 7 - 3
last_from_N = windowlength - 1                   #  3 ==  7 - 4

rolled_sum_direct_wlen4 =
    Tuple(map(Int, 
          rolling(sum, data, windowlength)))
# (180, 324, 516, 756)
n_rolled_direct = length(rolled_sum_direct_wlen4) #  4

runned_sum_direct_wlen4 =
    Tuple(map(Int, 
          running(sum, data, windowlength)))
# (6, 30, 84, 180, 324, 516, 756)
n_runned_direct = length(runned_sum_direct_wlen4) #  7


# i <- (1, 2, 3, 4)
tuple4s_from1 = map(i->Tuple(data[i:i+windowlength-1]), 1:last_from_1)
4-element Vector{NTuple{4, Int64}}:
 (6, 24, 54, 96)
 (24, 54, 96, 150)
 (54, 96, 150, 216)
 (96, 150, 216, 294)

# i <- (4, 5, 6, 7, 8)
tuple4s_fromN = map(i->Tuple(data[i-last_from_N:i]), last_from_N+1:N)
5-element Vector{NTuple{4, Int64}}:
 (6, 24, 54, 96)
 (24, 54, 96, 150)
 (54, 96, 150, 216)
 (96, 150, 216, 294)

sum4tuples = Tuple( map(sum, tuple4s_fromN) )
# (180, 324, 516, 756)

avg4tuples = map(x -> convert(Int, x // 4), sum4tuples)
# (45, 81, 129, 189)


# -------------------------------------------------------------------

into_int(x::Number) = isinteger(x) ? convert(Int, x) : ArgumentError("$(x) is not integral")
into_int(xs::Vararg{<:Number}) = map(into_int, xs)

function tuplize(data. fn=runmean, windowlen=4)
    ntuple(i -> into_int( fn(data, windowlen)), length(data) )
 end

runmean_wlen7 = ntuple(i->convert(Int, runmean(data,windowlength)[i]), 7)
# (6, 15, 28, 45, 81, 129, 189)
