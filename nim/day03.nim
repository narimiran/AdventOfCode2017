import math, tables

const puzzle = 368078


proc findManhattan(number: int): int =
  let
    spiralCorner = int sqrt(float(number))
    remainingSteps = number mod spiralCorner^2
    sideLength = spiralCorner + 1
    towardsMiddle = remainingSteps mod (sideLength div 2)
  return sideLength - towardsMiddle


echo findManhattan(puzzle)




type Point = tuple
  x: int
  y: int

var grid: Table[Point, int] = {(0, 0): 1}.toTable()


proc neighbours(point: Point): array[8, Point] =
  let (x, y) = point
  return [(x+1, y), (x-1, y), (x, y+1), (x, y-1),
          (x+1, y+1), (x-1, y-1), (x+1, y-1), (x-1, y+1)]


proc setValue(point: Point): int =
  for neighbour in point.neighbours:
    result += grid.getOrDefault(neighbour)
  grid[point] = result


iterator iterateThroughSpiral(): int =
  var ring = 0
  while true:
    inc ring
    for y in -ring+1 .. ring: yield setValue((ring, y))
    for x in countdown(ring-1, -ring): yield setValue((x, ring))
    for y in countdown(ring-1, -ring): yield setValue((-ring, y))
    for x in -ring+1 .. ring: yield setValue((x, -ring))


for value in iterateThroughSpiral():
  if value > puzzle:
    echo value
    break
