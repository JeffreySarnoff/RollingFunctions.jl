intvec = collect(1:10);
floatvec = collect(1.0:10.0);
intmat = hcat(intvec, reverse(intvec));
floatmat = hcat(floatvec, reverse(floatvec));

window_span = 7
window_fn = sum

result = rolling(intvec, window_span, window_fn)
expected = [28, 35, 42, 49]
@test result == expected
@test typeof(result) == typeof(expected)

result = rolling(floatvec, window_span, window_fn)
expected = [28.0, 35.0, 42.0, 49.0]
@test result == expected
@test typeof(result) == typeof(expected)

result = rolling(intmat, window_span, window_fn)
expected = [28 49; 35 42; 42 35; 49 28]
@test result == expected
@test typeof(result) == typeof(expected)

result = rolling(floatmat, window_span, window_fn)
expected = [28.0 49.0; 35.0 42.0; 42.0 35.0; 49.0 28.0]
@test result == expected
@test typeof(result) == typeof(expected)


