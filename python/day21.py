import numpy as np


with open('./inputs/21.txt') as f:
    instructions = f.readlines()

mappings = {}
start = '.#./..#/###'

def translate_to_np(s):
    return np.array([[c == '#' for c in l]
                     for l in s.split('/')])

for line in instructions:
    k, v = map(translate_to_np, line.strip().split(' => '))
    for a in (k, np.fliplr(k)):
        for r in range(4):
            mappings[np.rot90(a, r).tobytes()] = v


def find_next(grid):
    size = len(grid)
    by = 2 if size % 2 == 0 else 3
    new_size = size * (by+1) // by
    new_grid = np.empty((new_size, new_size), dtype=bool)
    squares = range(0, size, by)
    new_squares = range(0, new_size, by+1)

    for i, ni in zip(squares, new_squares):
        for j, nj in zip(squares, new_squares):
            square = grid[i:i+by, j:j+by]
            enhanced = mappings[square.tobytes()]
            new_grid[ni:ni+by+1, nj:nj+by+1] = enhanced
    return new_grid


grid = translate_to_np(start)
for _ in range(5):
    grid = find_next(grid)
print(grid.sum())



seen = {}
def find_new_9x9(grid):
    gtb = grid.tobytes()
    if gtb not in seen:
        for _ in range(3):
            grid = find_next(grid)
        seen[gtb] = grid
    return seen[gtb]


grid = find_next(grid) # 6th iteration -> 27x27 grid of independent 3x3's
for _ in range((18 - 6) // 3):
    size = len(grid)
    solution = np.empty((3*size, 3*size), dtype=bool)
    for i in range(0, size, 3):
        for j in range(0, size, 3):
            solution[3*i:3*(i+3), 3*j:3*(j+3)] = find_new_9x9(grid[i:i+3, j:j+3])
    grid = solution
print(grid.sum())
