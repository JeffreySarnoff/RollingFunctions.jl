S = sum; W = 3;
D = [1, 2, 3, 4, 5, 6];
expected = [6, 9, 12, 15];
@test rolling(S, D, W) == expected

D = Float32[1, 2, 3, 4, 5, 6];
expected = Float32[6, 9, 12, 15];
@test rolling(S, D, W) == expected

