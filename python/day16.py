from collections import deque


with open('./inputs/16.txt') as f:
    instructions = f.readline().split(',')


def clean_up(instructions):
    result = []
    for instr in instructions:
        first = instr[0]
        if first == 's':
            result.append((first, int(instr[1:])))
        elif first == 'x':
            a, b = map(int, instr[1:].split('/'))
            result.append((first, a, b))
        else:
            result.append((first, instr[1], instr[-1]))
    return result


def dance(dancers):
    dancers = deque(dancers)
    for first, *rest in cleaned:
        if first == 's':
            dancers.rotate(rest[0])
        elif first == 'x':
            a, b = rest
            dancers[a], dancers[b] = dancers[b], dancers[a]
        elif first == 'p':
            x, y = rest
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
cleaned = clean_up(instructions)

print(dance(programs))
print(long_dance(programs))
