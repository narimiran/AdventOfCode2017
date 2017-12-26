from collections import defaultdict, deque

with open('./inputs/24.txt') as f:
    instructions = f.readlines()

connections = defaultdict(set)

for line in instructions:
    a, b = map(int, line.split('/'))
    connections[a].add((a, b))
    connections[b].add((a, b))

start = ({(0, 0)}, 0, 0)
que = deque([start])

max_score = 0
longest_strongest = (0, 0)

while que:
    path, score, conn = que.popleft()
    if score > max_score:
        max_score = score
    if (len(path), score) > longest_strongest:
        longest_strongest = (len(path), score)
    for candidate in connections[conn]:
        if candidate not in path:
            new_connection = candidate[candidate.index(conn) - 1]
            new_score = score + sum(candidate)
            new_path = path | {candidate}
            que.append((new_path, new_score, new_connection))

print(max_score)
print(longest_strongest[-1])
