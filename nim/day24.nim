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

var visited: set[int8] = {}


proc calcScore(p: seq[int]) =
  if p.len == 0: return
  var
    used: set[int8] = {}
    score: int
    length = p.len
  for n in p:
    score += 2*n
    if (n in doubles) and (n.int8 notin used):
      score += 2*n
      inc length
      used.incl(n.int8)
  score -= p[^1]
  maxScore = max(maxScore, score)
  longestStrongest = max(longestStrongest, (length, score))


iterator allMatches(currentNode: int): tuple[conn, pos: int8] =
  for i, bridge in connections:
    let f = bridge.find(currentNode).int8
    if (f > -1) and (i.int8 notin visited):
      yield (i.int8, 1-f)


proc solve(path: var seq[int], currentNode = 0) =
  for match in currentNode.allMatches:
    let newConnection = connections[match.conn][match.pos]
    visited.incl match.conn

    path.add(newConnection)
    path.solve(newConnection)
    discard path.pop()

    visited.excl match.conn
  calcScore(path)


var path: seq[int] = @[]
path.solve()

echo maxScore
echo longestStrongest[1]
