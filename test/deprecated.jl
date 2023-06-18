fn = sum
width = 3
data = collect(1.0:7.0)

current = rolling(sum, width, data)
old = rolling(sum, data, width)

@test current == old

