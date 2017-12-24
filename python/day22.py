with open('./inputs/22.txt') as f:
    instructions = f.readlines()


def solve(part):
    def logic(status, part):
        nonlocal infected, direction
        if part == 1:
            if status == 0:
                infected += 1
            direction *= (1 - 2*status) * 1j
        else:
            if status == 1:
                infected += 1
            elif status == 2:
                direction *= -1j
            elif status == 3:
                direction *= -1
            else:
                direction *= 1j

    grid = {}
    position = (len(instructions)//2 + len(instructions[0].strip())//2 * 1j)
    direction = -1
    infected = 0
    for i, line in enumerate(instructions):
        for j, char in enumerate(line.strip()):
            grid[(i + j*1j)] = 0 if char == '.' else part

    bursts = 10_000 if part == 1 else 10_000_000
    for _ in range(bursts):
        status = grid.get(position, 0)
        logic(status, part)
        grid[position] = (status + 1) % (2 * part)
        position += direction
    return infected


print(solve(part=1))
print(solve(part=2))
