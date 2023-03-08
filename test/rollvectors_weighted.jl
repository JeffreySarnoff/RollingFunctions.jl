clean(x) = x
clean(x::Missing) = Missing

F = sum; W = 3; weights = [0.2, 0.3, 0.5]
D = [1, 2, 3, 4, 5];
expected = [2.3, 3.3, 4.3];
@test rolling(F, W, D, weights) == expected

expected = [missing, missing, 2.3, 3.3, 4.3];
@test map(clean, rolling(F, W, D, weights; padding=missing)) == map(clean, expected)
@test typeof(rolling(F, W, D, weights; padding=missing)) == typeof(expected)

expected = [2.3, 3.3, 4.3, missing, missing];
@test map(clean, rolling(F, W, D, weights; padding=missing, padlast=true)) == map(clean, expected)
@test typeof(rolling(F, W, D, weights; padding=missing, padlast=true)) == typeof(expected)


D₁ = [1, 2, 3, 4, 5]
D₂ = [5, 4, 3, 2, 1]
F = cor
W = 3
expected = [0.9946433500242822, 0.9773555548504419, -0.9511012772444227]
@test rolling(F, D₁, D₂, W, weights) == expected

D₁ = [1, 2, 3, 4, 5]
D₂ = [5, 4, 3, 2, 1]
M = hcat(D₁, D₂)
F = sum
W = 3
expected = [  2.3 3.7
              3.3 2.7
              4.3 1.7 ]
@test isapprox(rolling(F, M, W, weights), expected)
