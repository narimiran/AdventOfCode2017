from collections import deque
from functools import reduce
from operator import xor


with open('./inputs/10.txt') as f:
    input_string = f.readline()

int_sizes = [int(n) for n in input_string.split(',')]
ascii_sizes = [ord(c) for c in input_string] + [17, 31, 73, 47, 23]

SIZE = 256
numbers = range(SIZE)


def knot_hashing(circle, sizes, second_part=False):
    iterations = 64 if second_part else 1
    skip = 0
    for _ in range(iterations):
        for group_size in sizes:
            knot = [circle.popleft() for _ in range(group_size)]
            circle += reversed(knot)
            circle.rotate(-skip)
            skip += 1
    unwind = iterations * sum(sizes) + skip * (skip-1) // 2
    circle.rotate(unwind)
    return list(circle)


first_hash = knot_hashing(deque(numbers), int_sizes)
first = first_hash[0] * first_hash[1]
print(first)



second_hash = knot_hashing(deque(numbers), ascii_sizes, second_part=True)

BLOCK_SIZE = 16
block = lambda i: second_hash[i*BLOCK_SIZE : (i+1)*BLOCK_SIZE]

dense = [reduce(xor, block(i)) for i in range(SIZE // BLOCK_SIZE)]
second = ''.join(f'{n:02x}' for n in dense)
print(second)
