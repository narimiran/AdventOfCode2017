import sets, day10


type Coordinate = tuple[x, y: int]
const
  instructions = "hwlqcszp-"
  deltas: array[4, Coordinate] = [(1, 0), (-1, 0), (0, 1), (0, -1)]


func createMaze(): HashSet[Coordinate] =
  for row in 0 .. 127:
    let
      word = instructions & $row
      binHash = knotHashing(word, binOut = true)
    for i, n in binHash:
      if n == '1':
        result.incl((row, i))

var maze = createMaze()
echo maze.len


proc dfs(coord: Coordinate) =
  for delta in deltas:
    let candidate = (coord.x + delta.x, coord.y + delta.y)
    if candidate in maze:
      maze.excl(candidate)
      dfs(candidate)


var regions: int
while maze.len > 0:
  dfs(maze.pop())
  inc regions

echo regions
