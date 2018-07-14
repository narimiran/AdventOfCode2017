import strutils

const instructions = readFile("./inputs/11.txt").split(",")
type Point = tuple[p: int, q: int]


func toAxial(direction: string): Point =
  case direction
    of "n":  ( 0, -1)
    of "nw": (-1,  0)
    of "sw": (-1,  1)
    of "s":  ( 0,  1)
    of "se": ( 1,  0)
    else:    ( 1, -1)

func `+`(a, b: Point): Point = (a.p + b.p, a.q + b.q)
func `+=`(a: var Point, b: Point) = a = a + b
func distanceToOrigin(a: Point): int = max([abs(a.p), abs(a.q), abs(a.p + a.q)])


var
  position: Point
  distances: seq[int] = @[]

for direction in instructions:
  position += direction.toAxial()
  distances.add(position.distanceToOrigin())

echo position.distanceToOrigin()
echo max(distances)
