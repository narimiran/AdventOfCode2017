import strutils, sequtils, tables, math, sets

const instructions = readFile("./inputs/20.txt").splitLines
type
  Coord = tuple[x, y, z: int]
  Particle = tuple[p, v, a: Coord]

proc extractNumbers(s: string): Coord =
  let xyz = s[3 .. ^2].split(',').map(parseInt)
  result = (xyz[0], xyz[1], xyz[2])

proc manhattan(accel: Coord): int = abs(accel.x) + abs(accel.y) + abs(accel.z)
var
  particles: seq[Particle] = @[]
  smallestAcceleration = int.high
  closestParticle: int

for i, line in instructions:
  let
    pva = line.split(", ")
    p = pva[0].extractNumbers
    v = pva[1].extractNumbers
    a = pva[2].extractNumbers
    ma = manhattan(a)
  if ma < smallestAcceleration:
    smallestAcceleration = ma
    closestParticle = i
  particles.add((p, v, a))

echo closestParticle




proc `-`(c1, c2: Coord): Coord = (c1.x - c2.x, c1.y - c2.y, c1.z - c2.z)
proc `-`(p1, p2: Particle): Particle = (p1.p - p2.p, p1.v - p2.v, p1.a - p2.a)

proc checkCollision(p, v, a: Coord, time: float): bool =
  proc collision(pp, vv, aa: int): bool =
    0.5*float(aa)*time^2 + (float(vv) + 0.5*float(aa))*time + float(pp) == 0
  return collision(p.y, v.y, a.y) and collision(p.z, v.z, a.z)


proc findCollisions(p1, p2: Particle): seq[int] =
  result = @[]
  var times: seq[float] = @[]
  let
    (p, v, a) = p1 - p2
    px = float p.x
    vx = float v.x
    ax = float a.x
    b = vx + ax / 2
    D = b^2 - 2*ax*px
  if ax == 0:
    if vx != 0:
      times.add(-px/vx)
  elif D == 0:
    times.add(-b/ax)
  else:
    times.add((-b - D.sqrt) / ax)
    times.add((-b + D.sqrt) / ax)
  for time in times:
    if checkCollision(p, v, a, time):
      result.add(int(time))


var collisions = initTable[int, seq[tuple[i, j: int]]]()

for i, p1 in particles:
  for j, p2 in particles[i+1 .. particles.high]:
    for time in findCollisions(p1, p2):
      if not collisions.hasKey(time):
        collisions[time] = @[]
      collisions[time].add((i, i+j+1))

var dead = initSet[int]()
for time in collisions.keys:
  var colliding = initSet[int]()
  for collision in collisions[time]:
    if collision.i notin dead and collision.j notin dead:
      colliding.incl(collision.i)
      colliding.incl(collision.j)
  dead = dead + colliding

echo instructions.len - dead.len
