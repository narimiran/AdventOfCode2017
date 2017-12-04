PUZZLE = 368078


def find_manhattan(number):
    spiral_corner = int(number ** 0.5)
    remaining_steps = number % spiral_corner**2
    side_length = spiral_corner + 1
    towards_middle = remaining_steps % (side_length // 2)
    return side_length - towards_middle


first = find_manhattan(PUZZLE)




grid = {(0, 0): 1}


def neighbours(point):
    x, y = point
    return [(x+1, y), (x-1, y), (x, y+1), (x, y-1),
            (x+1, y+1), (x-1, y-1), (x+1, y-1), (x-1, y+1)]


def set_value(point):
    grid[point] = sum(grid.get(neighbour, 0) for neighbour in neighbours(point))
    return grid[point]


def iterate_through_spiral(ring=0):
    while True:
        ring += 1
        for y in range(-ring + 1, ring): yield set_value((ring, y))
        for x in range(ring, -ring, -1): yield set_value((x, ring))
        for y in range(ring, -ring, -1): yield set_value((-ring, y))
        for x in range(-ring, ring + 1): yield set_value((x, -ring))


for value in iterate_through_spiral():
    if value > PUZZLE:
        second = value
        break

print(first)
print(second)
