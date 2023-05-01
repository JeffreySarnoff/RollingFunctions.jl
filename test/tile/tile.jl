clean(x) = x
clean(x::Missing) = Missing

data1 = collect(1.0f0:16.0f0)
data2 = reverse(data1)

func = sum
width = 8
tile = 8
padding = nopadding
padlast = false




intvec = collect(1:10);
floatvec = collect(1.0:10.0);
intmat = hcat(intvec, reverse(intvec));
floatmat = hcat(floatvec, reverse(floatvec));

width = 7
func = sum

result = tiling(func, width, intvec)
expected = [28, 35, 42, 49]
@test result == expected
@test typeof(result) == typeof(expected)

result = tiling(func, width, floatvec)
expected = [28.0, 35.0, 42.0, 49.0]
@test result == expected
@test typeof(result) == typeof(expected)

result = tiling(func, width, intmat)
expected = [28 49; 35 42; 42 35; 49 28]
@test result == expected
@test typeof(result) == typeof(expected)

result = tiling(func, width, floatmat)
expected = [28.0 49.0; 35.0 42.0; 42.0 35.0; 49.0 28.0]
@test result == expected
@test typeof(result) == typeof(expected)

# pad first

result = tiling(func, width, intvec; padding = missing)
expected = [missing, missing, missing, missing, missing, missing, 28, 35, 42, 49]
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)

result = tiling(func, width, floatvec; padding = missing)
expected = [missing, missing, missing, missing, missing, missing, 28.0, 35.0, 42.0, 49.0]
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)

result = tiling(func, width, intmat; padding = missing)
expected = [missing missing; missing missing; missing missing; missing missing; missing missing; missing missing; 28 49; 35 42; 42 35; 49 28]
  
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)

result = tiling(func, width, floatmat; padding = missing)
expected = [missing missing; missing missing; missing missing; missing missing; missing missing; missing missing; 28.0 49.0; 35.0 42.0; 42.0 35.0; 49.0 28.0]
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)


# pad last

result = tiling(func, width, intvec; padding = 0, padlast=true)
expected = [28, 35, 42, 49, 0, 0, 0, 0, 0, 0]
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)

result = tiling(func, width, floatvec; padding = 0.0, padlast=true)
expected = [28.0, 35.0, 42.0, 49.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)

result = tiling(func, width, intmat; padding = 0, padlast=true)
expected = [28 49; 35 42; 42 35; 49 28; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0]
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)

result = tiling(func, width, floatmat; padding = 0.0, padlast=true)
expected = [28.0 49.0; 35.0 42.0; 42.0 35.0; 49.0 28.0; 0.0 0.0; 0.0 0.0; 0.0 0.0; 0.0 0.0; 0.0 0.0; 0.0 0.0]
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)


