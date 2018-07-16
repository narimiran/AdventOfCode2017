import strutils, sequtils, tables, math


const instructions = readFile("./inputs/20.txt").splitLines
type
  Coord = tuple[x, y, z: float]
  Particle = tuple[p, v, a: Coord]

func extractNumbers(s: string): Coord =
  let xyz = s[3 .. ^2].split(',').map(parseFloat)
  (xyz[0], xyz[1], xyz[2])

func parseLine(line: string): Particle =
  let pva = line.split(", ").map(extractNumbers)
  (pva[0], pva[1], pva[2])

func manhattan(accel: Coord): float =
  abs(accel.x) + abs(accel.y) + abs(accel.z)

var
  particles: array[instructions.len, Particle]
  smallestAcceleration = float.high
  closestParticle: int

for i, line in instructions:
  let
    particle = line.parseLine()
    ma = manhattan(particle.a)
  if ma < smallestAcceleration:
    smallestAcceleration = ma
    closestParticle = i
  particles[i] = particle

echo closestParticle




func `-`(c1, c2: Coord): Coord = (c1.x - c2.x, c1.y - c2.y, c1.z - c2.z)
func `-`(p1, p2: Particle): Particle = (p1.p - p2.p, p1.v - p2.v, p1.a - p2.a)

func collision(pp, vv, aa, time: float): bool =
    (2 * vv + aa * (1+time)) * time + 2 * pp == 0

func checkCollision(p, v, a: Coord, time: float): bool =
  collision(p.y, v.y, a.y, time) and collision(p.z, v.z, a.z, time)

func findCollisions(p1, p2: Particle): float =
  let
    (p, v, a) = p1 - p2
    b = - v.x - 0.5 * a.x
    D = b*b - 2 * a.x * p.x
  if a.x == 0:
    if v.x != 0:
      let time = -p.x / v.x
      if checkCollision(p, v, a, time):
        return time
  elif D == 0:
    let time = b / a.x
    if checkCollision(p, v, a, time):
      return time
  else:
    for time in [(b - D.sqrt) / a.x, (b + D.sqrt) / a.x]:
      if checkCollision(p, v, a, time):
        return time


var collisions = initTable[int, seq[tuple[i, j: int16]]]()

for i, p1 in particles:
  for j, p2 in particles[i+1 .. particles.high]:
    let time = findCollisions(p1, p2).int
    if time > 0:
      if not collisions.hasKey(time):
        collisions[time] = @[]
      collisions[time].add((i.int16, (i+j+1).int16))

var dead: set[int16]
for time in collisions.keys:
  var colliding: set[int16]
  for collision in collisions[time]:
    if collision.i notin dead and collision.j notin dead:
      colliding.incl(collision.i)
      colliding.incl(collision.j)
  dead = dead + colliding

echo instructions.len - dead.card
