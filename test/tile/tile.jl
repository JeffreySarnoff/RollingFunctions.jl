clean(x) = x
clean(x::Missing) = Missing

intvec = collect(1:10);
floatvec = collect(1.0:10.0);
intmat = hcat(intvec, reverse(intvec));
floatmat = hcat(floatvec, reverse(floatvec));

span = 7
func = sum

result = tiling(func, span, intvec)
expected = [28, 35, 42, 49]
@test result == expected
@test typeof(result) == typeof(expected)

result = tiling(func, span, floatvec)
expected = [28.0, 35.0, 42.0, 49.0]
@test result == expected
@test typeof(result) == typeof(expected)

result = tiling(func, span, intmat)
expected = [28 49; 35 42; 42 35; 49 28]
@test result == expected
@test typeof(result) == typeof(expected)

result = tiling(func, span, floatmat)
expected = [28.0 49.0; 35.0 42.0; 42.0 35.0; 49.0 28.0]
@test result == expected
@test typeof(result) == typeof(expected)

# pad first

result = tiling(func, span, intvec; padding = missing)
expected = [missing, missing, missing, missing, missing, missing, 28, 35, 42, 49]
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)

result = tiling(func, span, floatvec; padding = missing)
expected = [missing, missing, missing, missing, missing, missing, 28.0, 35.0, 42.0, 49.0]
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)

result = tiling(func, span, intmat; padding = missing)
expected = [missing missing; missing missing; missing missing; missing missing; missing missing; missing missing; 28 49; 35 42; 42 35; 49 28]
  
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)

result = tiling(func, span, floatmat; padding = missing)
expected = [missing missing; missing missing; missing missing; missing missing; missing missing; missing missing; 28.0 49.0; 35.0 42.0; 42.0 35.0; 49.0 28.0]
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)


# pad last

result = tiling(func, span, intvec; padding = 0, padlast=true)
expected = [28, 35, 42, 49, 0, 0, 0, 0, 0, 0]
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)

result = tiling(func, span, floatvec; padding = 0.0, padlast=true)
expected = [28.0, 35.0, 42.0, 49.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)

result = tiling(func, span, intmat; padding = 0, padlast=true)
expected = [28 49; 35 42; 42 35; 49 28; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0]
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)

result = tiling(func, span, floatmat; padding = 0.0, padlast=true)
expected = [28.0 49.0; 35.0 42.0; 42.0 35.0; 49.0 28.0; 0.0 0.0; 0.0 0.0; 0.0 0.0; 0.0 0.0; 0.0 0.0; 0.0 0.0]
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)


