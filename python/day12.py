from collections import deque

with open('./inputs/12.txt') as f:
    instructions = f.readlines()

graph = {}

for line in instructions:
    pipe, neighbours = line.split(' <-> ')
    pipe = int(pipe)
    neighbours = [int(n) for n in neighbours.split(', ')]
    graph[pipe] = neighbours


def bfs(starting_point):
    connections = set()
    que = deque([starting_point])
    while que:
        current = que.popleft()
        connections.add(current)
        for node in graph[current]:
            if node not in connections:
                que.append(node)
    return connections


islands = []
seen = set()

first_island = bfs(0)
print(len(first_island))


islands.append(first_island)
seen |= first_island

for pipe in graph:
    if pipe not in seen:
        pipe_island = bfs(pipe)
        islands.append(pipe_island)
        seen |= pipe_island

print(len(islands))
