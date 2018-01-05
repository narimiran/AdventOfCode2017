import strutils, sequtils, math

const instructions = readFile("./inputs/24.txt").splitLines
var
  connections = newSeq[array[2, int]]()
  maxScore: int
  longestStrongest = (0, 0)
  doubles = newSeq[int]()

for i, line in instructions:
  let pins = line.split('/').map(parseInt)
  if pins[0] != pins[1]: connections.add([pins[0], pins[1]])
  else: doubles.add(pins[0])

var visited = newSeq[bool](connections.len)


proc calcScore(p: seq[int]) =
  if p.len == 0: return
  var
    path = p
    last = path[^1]
  for n in path.deduplicate:
    if n in doubles: path.add(n)
  let
    score = 2 * sum(path) - last
    lenSc = (path.len, score)
  maxScore = max(maxScore, score)
  longestStrongest = max(longestStrongest, lenSc)


proc solve(currentNode: int, path: seq[int]) =
  for i, bridge in connections:
    if not visited[i]:
      let f = bridge.find(currentNode)
      if f > -1:
        let
          newConnection = bridge[1 - f]
          newPath = path.concat(@[new_connection])
        visited[i] = true
        solve(newConnection, newPath)
        visited[i] = false
  calcScore(path)


solve(0, @[])

echo maxScore
echo longestStrongest[1]
