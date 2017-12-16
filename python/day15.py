a = 699
b = 124
factors = {'a': 16807, 'b': 48271}
divisor = 2147483647


def generator(value, factor, multi=1):
    while True:
        value = value * factor % divisor
        if value % multi == 0:
            yield value & 0xFFFF


part1_a = generator(a, factors['a'])
part1_b = generator(b, factors['b'])

part2_a = generator(a, factors['a'], 4)
part2_b = generator(b, factors['b'], 8)

first = sum(next(part1_a) == next(part1_b) for _ in range(40000000))
second = sum(next(part2_a) == next(part2_b) for _ in range(5000000))

print(first)
print(second)
