squares = (x^2 for x in 1:8);
data = [6x for x in squares]; # length(data) == 8
print(data)
# [6, 24, 54, 96, 150, 216, 294, 384]

N = length(data)
# 8
windowlength = 4;

last_from_1 = length(data) - windowlength + 1;

tuple4s_from1 = map(i->Tuple(data[i:i+windowlength-1]), 1:last_from_1)
5-element Vector{NTuple{4, Int64}}:
 (6, 24, 54, 96)
 (24, 54, 96, 150)
 (54, 96, 150, 216)
 (96, 150, 216, 294)
 (150, 216, 294, 384)

last_from_N = windowlength - 1

tuple4s_fromN = map(i->Tuple(data[i:i+windowlength-1]), 

 tuple4s_fromN = map(i->Tuple(data[i-last_from_N:i]), last_from_N+1:N)
5-element Vector{NTuple{4, Int64}}:
 (6, 24, 54, 96)
 (24, 54, 96, 150)
 (54, 96, 150, 216)
 (96, 150, 216, 294)
 (150, 216, 294, 384)
