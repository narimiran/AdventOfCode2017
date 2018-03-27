import sets, strutils
import day10


const instructions = "hwlqcszp-"

type Coordinate = tuple[x, y: int]
var
  maze = initSet[Coordinate]()
  binHash: string

proc createMaze(maze: var HashSet) =
  for row in 0 .. 127:
    let word = instructions & $row
    binHash = knotHashing(word, binOut = true)
    for i, n in binHash:
      if n == '1':
        maze.incl((row, i))

createMaze(maze)
echo maze.len


const deltas: array[4, Coordinate] = [(1, 0), (-1, 0), (0, 1), (0, -1)]

proc dfs(coord: Coordinate) =
  if coord notin maze: return
  maze.excl(coord)
  for delta in deltas:
    let candidate = (coord.x + delta.x, coord.y + delta.y)
    dfs(candidate)


var regions: int
while maze.len > 0:
  for coord in maze: dfs(coord); break # Nim doesn't have HashSet.pop()
  inc regions

echo regions
