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
