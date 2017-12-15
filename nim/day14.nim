import sets, strutils
import day10


const instructions = "hwlqcszp"

type Coordinate = tuple[x, y: int]
var maze = initSet[Coordinate]()

for row in 0 .. 127:
  let
    word = instructions & "-" & $row
    hexHash = knotHashing(word)
  var binHash = ""
  for n in hexHash:
    binHash.add(toBin(parseHexInt($n), 4))
  for i, n in binHash:
    if n == '1':
      maze.incl((row, i))

echo maze.len


const deltas: array[4, Coordinate] = [(1, 0), (-1, 0), (0, 1), (0, -1)]

proc dfs(start: Coordinate) =
  var stack = @[start]
  maze.excl(start)
  while stack.len > 0:
    let coord = stack.pop()
    for delta in deltas:
      let candidate = (coord.x + delta.x, coord.y + delta.y)
      if candidate in maze:
        stack.add(candidate)
        maze.excl(candidate)


var regions: int
while maze.len > 0:
  for coord in maze: dfs(coord); break # Nim doesn't have HashSet.pop()
  inc regions

echo regions
