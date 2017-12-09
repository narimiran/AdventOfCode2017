from collections import defaultdict
from operator import lt, gt, eq, ne, le, ge


with open('./inputs/08.txt') as f:
    instructions = f.readlines()

registers = defaultdict(int)
operators = {
    '<': lt,
    '>': gt,
    '==': eq,
    '!=': ne,
    '<=': le,
    '>=': ge,
}
maximum = 0

for line in instructions:
    register, instruction, amount, _, cond_reg, operator, value = line.split()
    directon = 1 if instruction == 'inc' else -1
    if operators[operator](registers[cond_reg], int(value)):
        registers[register] += directon * int(amount)
        maximum = max(registers[register], maximum)

print(max(registers.values()))
print(maximum)
