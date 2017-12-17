from collections import deque

with open('./inputs/16.txt') as f:
    instructions = f.readline().split(',')


def dance(dancers):
    dancers = deque(dancers)
    for instr in instructions:
        if instr.startswith('s'):
            rot = int(instr[1:])
            dancers.rotate(rot)
        elif instr.startswith('x'):
            a, b = map(int, instr[1:].split('/'))
            dancers[a], dancers[b] = dancers[b], dancers[a]
        elif instr.startswith('p'):
            x, y = instr[1:].split('/')
            a = dancers.index(x)
            b = dancers.index(y)
            dancers[a], dancers[b] = y, x
    return ''.join(dancers)


def long_dance(dancers, iterations=1_000_000_000):
    seen = [dancers]
    for i in range(1, iterations):
        dancers = dance(dancers)
        if dancers == programs:
            return seen[iterations % i]
        seen.append(dancers)


programs = 'abcdefghijklmnop'
print(dance(programs))
print(long_dance(programs))
