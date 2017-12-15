from day10 import knot_hashing


instructions = 'hwlqcszp'
maze = set()

for row in range(128):
    word = f'{instructions}-{row}'
    hex_hash = knot_hashing(word)
    bin_hash = f'{int(hex_hash, 16):0128b}'
    for i, n in enumerate(bin_hash):
        if n == '1':
            maze.add((row, i))

print(len(maze))



def dfs(start):
    stack = [start]
    while stack:
        (x, y) = stack.pop()
        for dx, dy in DELTAS:
            candidate = x+dx, y+dy
            if candidate in maze:
                stack.append(candidate)
                maze.remove(candidate)


DELTAS = ((1, 0), (-1, 0), (0, 1), (0, -1))
regions = 0

while maze:
    dfs(maze.pop())
    regions += 1

print(regions)
