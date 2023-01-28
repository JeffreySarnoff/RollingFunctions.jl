S = sum; W = 3;
D = [1, 2, 3, 4, 5];
expected = [6, 9, 12];
@test rolling(S, D, W) == expected

D = Float32[1, 2, 3, 4, 5];
expected = Float32[6, 9, 12];
@test rolling(S, D, W) == expected

S = sum; W = 4;
D = [1, 2, 3, 4, 5];
expected = [10, 14];
@test rolling(S, D, W) == expected


D₁ = [1, 2, 3, 4, 5]
D₂ = [5, 4, 3, 2, 1]
F = cor
W = 3
expected = [-1.0, -1.0, -1.0, -1.0]
@test rolling(F, D₁, D₂, W) == expected

D₁ = [1, 2, 3, 4, 5]
D₂ = [5, 4, 3, 2, 1]
M = hcat(D₁, D₂)
F = sum
W = 3
expected = [  6 12
              9  9
             12  6 ]
@test rolling(F, M, W) == expected

