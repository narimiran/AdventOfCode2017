from collections import defaultdict

steps = 12667664
states = {
    'A': ((1,  1, 'B'), (0, -1, 'C')),
    'B': ((1, -1, 'A'), (1,  1, 'D')),
    'C': ((0, -1, 'B'), (0, -1, 'E')),
    'D': ((1,  1, 'A'), (0,  1, 'B')),
    'E': ((1, -1, 'F'), (1, -1, 'C')),
    'F': ((1,  1, 'D'), (1,  1, 'A')),
}
tape = defaultdict(int)
position = 0
state = 'A'

for _ in range(steps):
    value = tape[position]
    write, move, state = states[state][value]
    tape[position] = write
    position += move

print(sum(tape.values()))
