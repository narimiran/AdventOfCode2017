import strutils

const instructions = readFile("./inputs/11.txt").split(",")

type Point = tuple
  p: int
  q: int


proc toAxial(direction: string): Point =
  case direction
  of "n": return (0, -1)
  of "nw": return (-1, 0)
  of "sw": return (-1, 1)
  of "s": return (0, 1)
  of "se": return (1, 0)
  of "ne": return (1, -1)

proc `+`(a, b: Point): Point = (a.p + b.p, a.q + b.q)
proc `+=`(a: var Point, b: Point) = a = a + b

proc distanceToOrigin(a: Point): int =
  max([abs(a.p), abs(a.q), abs(a.p + a.q)])

var
  position: Point = (0, 0)
  distances: seq[int] = @[]

for direction in instructions:
  position += direction.toAxial()
  distances.add(position.distanceToOrigin())

echo position.distanceToOrigin()
echo max(distances)
