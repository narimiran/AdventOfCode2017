from collections import defaultdict, deque


with open('./inputs/18.txt') as f:
    instructions = f.readlines()

interpret = lambda val, reg: reg[val] if val.isalpha() else int(val)
sent_counter = 0


def solve(registers, which, i=0, first_part=False):
    played = 0
    while i < len(instructions):
        c = instructions[i].split()
        v = interpret(c[-1], registers)
        if c[0] == 'set':
            registers[c[1]] = v
        elif c[0] == 'add':
            registers[c[1]] += v
        elif c[0] == 'mul':
            registers[c[1]] *= v
        elif c[0] == 'mod':
            registers[c[1]] %= v
        elif c[0] == 'jgz':
            w = interpret(c[1], registers)
            if w > 0:
                i += v
                continue
        elif c[0] == 'snd':
            if first_part:
                played = v

            elif which == 'x':
                y.append(v)
            else:
                global sent_counter
                sent_counter += 1
                x.append(v)
        elif c[0] == 'rcv':
            if first_part:
                if v != 0:
                    return played

            elif which == 'x' and x:
                registers[c[-1]] = x.popleft()
            elif which == 'y' and y:
                registers[c[-1]] = y.popleft()
            else:
                return i
        i += 1


print(solve(defaultdict(int), 'x', first_part=True))



registers_x = defaultdict(int)
registers_y = defaultdict(int)
registers_y['p'] = 1

x = deque([])
y = deque([])

x_i = solve(registers_x, 'x')
y_i = solve(registers_y, 'y')
while x or y:
    x_i = solve(registers_x, 'x', x_i)
    y_i = solve(registers_y, 'y', y_i)

print(sent_counter)
