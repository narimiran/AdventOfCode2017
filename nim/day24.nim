import strutils, sequtils

const
  instructions = readFile("./inputs/24.txt").splitLines
  size = instructions.len
var
  connections: array[size, array[2, int]]
  visited: array[size, bool]
  maxScore: int
  longestStrongest = (0, 0)

for i, line in instructions:
  let pins = line.split('/').map(parseInt)
  connections[i] = [pins[0], pins[1]]


proc solve(current, score, lenght: int) =
  for i, candidate in connections:
    if not visited[i]:
      if current in candidate:
        let new_connection = candidate[1 - candidate.find(current)]
        visited[i] = true
        solve(new_connection, score+candidate[0]+candidate[1], lenght+1)
        visited[i] = false
  if score > maxScore:
    maxScore = score
  if (lenght, score) > longestStrongest:
    longestStrongest = (lenght, score)


solve(0, 0, 0)

echo maxScore
echo longestStrongest[1]
