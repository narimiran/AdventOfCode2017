with open('./inputs/11.txt') as f:
    instructions = f.readline().split(',')

to_cube = {
    'n':  (0, 1, -1),
    'nw': (-1, 1, 0),
    'sw': (-1, 0, 1),
    's':  (0, -1, 1),
    'se': (1, -1, 0),
    'ne': (1, 0, -1),
}
position = (0, 0, 0)


def move(a, b):
    b = to_cube[b]
    return (a[0]+b[0], a[1]+b[1], a[2]+b[2])

def distance_to_origin(a):
    return sum(map(abs, a)) // 2


distances = set()

for direction in instructions:
    position = move(position, direction)
    dist = distance_to_origin(position)
    distances.add(dist)

print(distance_to_origin(position))
print(max(distances))
