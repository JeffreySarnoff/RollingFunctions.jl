𝐹𝑢𝑛𝑐 = sum
𝑆𝑝𝑎𝑛 = 3

𝐷𝑎𝑡𝑎₁ = [1, 2, 3, 4, 5];
𝐷𝑎𝑡𝑎₂ = [5, 4, 3, 2, 1];
𝐷𝑎𝑡𝑎₃ = [1, 2, 3, 2, 1];

𝑀 = hcat(𝐷𝑎𝑡𝑎₁, 𝐷𝑎𝑡𝑎₂, 𝐷𝑎𝑡𝑎₃);

result = rolling(𝐹𝑢𝑛𝑐, 𝑀, 𝑆𝑝𝑎𝑛);

expected = [  6  12  6
              9   9  7
             12   6  6 ];

@test result == expected
@test typeof(result) == typeof(expected)



