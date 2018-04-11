import strutils

type
  Point = tuple[x, y: int]
  Rotation = enum left, right, back

const
  instructions = readFile("./inputs/22.txt").splitLines
  startingPosition: Point = (instructions.len div 2, instructions[0].strip.len div 2)
  startingDirection: Point = (-1, 0)

var
  grid1: array[-20 .. 40, array[-50 .. 40, int]]      # manually tweaked
  grid2: array[-180 .. 220, array[-180 .. 220, int]]  # manually tweaked

for i, line in instructions:
  for j, mark in line.strip:
    if mark == '#':
      grid1[i][j] = 1
      grid2[i][j] = 2


template `+=`(a: var Point, b: Point) =
  a = (a.x + b.x, a.y + b.y)


proc turn(direction: var Point, rot: Rotation) =
  let (x, y) = direction
  case rot
    of left:  direction = (-y,  x)
    of right: direction = ( y, -x)
    of back:  direction = (-x, -y)


proc part1(): int =
  var
    direction = startingDirection
    position = startingPosition

  template visit(status: var int) =
    if status == 0:
      inc result
      direction.turn left
      status = 1
    else:
      direction.turn right
      status = 0

  for _ in 1 .. 10_000:
    visit grid1[position.x][position.y]
    position += direction


proc part2(): int =
  var
    direction = startingDirection
    position = startingPosition

  template visit(status: var int) =
    case status
      of 0: direction.turn left
      of 1: inc result
      of 2: direction.turn right
      of 3: direction.turn back; status = -1
      else: discard
    inc status

  for _ in 1 .. 10_000_000:
    visit grid2[position.x][position.y]
    position += direction


echo part1()
echo part2()
