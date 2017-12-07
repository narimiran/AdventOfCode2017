from collections import OrderedDict

with open('./inputs/06.txt') as f:
    banks = [int(block) for block in f.readline().split()]

size = len(banks)
seen = OrderedDict()

while tuple(banks) not in seen:
    seen[tuple(banks)] = "Python doesn't have OrderedSet"
    max_value = max(banks)
    max_index = banks.index(max_value)
    banks[max_index] = 0

    to_every, to_some = divmod(max_value, size)
    banks = [block+to_every for block in banks]
    for i in range(to_some):
        banks[(max_index + i+1) % size] += 1

loop_start = list(seen.keys()).index(tuple(banks))
print(len(seen))
print(len(seen) - loop_start)
