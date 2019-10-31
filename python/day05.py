with open('./inputs/05.txt') as f:
    original_instructions = [int(line) for line in f.readlines()]


def step_by_step(instructions, second_part=False):
    line = 0
    steps = 0

    while True:
        try:
            # EAFP (https://docs.python.org/3/glossary.html#term-eafp)
            # a bit faster than LBYL (repeteately checking if inside of bounds)
            jump = instructions[line]
        except IndexError:
            return steps

        if second_part and jump >= 3:
            instructions[line] -= 1
        else:
            instructions[line] += 1
        line += jump
        steps += 1


first = step_by_step(original_instructions.copy())
second = step_by_step(original_instructions.copy(), second_part=True)

print(first)
print(second)
