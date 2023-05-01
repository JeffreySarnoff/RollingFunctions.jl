clean(x) = x
clean(x::Missing) = Missing

F = sum;
W = 3;
D = [1, 2, 3, 4, 5];
expected = [1, 3, 6, 9, 12];
@test running(F, W, D) == expected

D = Float32[1, 2, 3, 4, 5];
expected = Float32[1, 3, 6, 9, 12];
@test running(F, W, D) == expected

F = sum;
W = 4;
D = [1, 2, 3, 4, 5];
expected = [1, 3, 6, 10, 14];
@test running(F, W, D) == expected

D₁ = [1, 2, 3, 4, 5];
D₂ = [5, 4, 3, 2, 1];
F = cor;
W = 3;
expected = [NaN, -1.0, -1.0, -1.0, -1.0];
@test running(F, W, D₁, D₂)[2:end] == expected[2:end]
@test isnan(running(F, W, D₁, D₂, weights)[1])

