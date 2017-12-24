import strutils, tables

const instructions = readFile("./inputs/22.txt").splitLines

type
  Point = tuple[x, y: int]
  Rotation = enum left, right, back


proc solve(part: int): int =
  var
    grid = initTable[Point, int]()
    position: Point = (instructions.len div 2, instructions[0].strip.len div 2)
    direction: Point = (-1, 0)
    infected: int

  proc `+=`(a: var Point, b: Point) =
    a = (a.x + b.x, a.y + b.y)

  proc turn(rot: Rotation) =
    let (x, y) = direction
    case rot
    of left:  direction = (-y,  x)
    of right: direction = ( y, -x)
    of back:  direction = (-x, -y)

  proc logic(status: int) =
    if part == 1:
      if status == 0:
        inc infected
        turn left
      else:
        turn right
    else:
      case status
      of 0: turn left
      of 1: inc infected
      of 2: turn right
      of 3: turn back
      else: discard

  for i, line in instructions:
    for j, mark in line.strip:
      grid[(i, j)] = if mark == '.': 0 else: part

  let bursts = if part == 1: 10_000 else: 10_000_000
  for _ in 1 .. bursts:
    let status = grid.getOrDefault(position)
    status.logic
    grid[position] = (status + 1) mod (2 * part)
    position += direction
  return infected


echo solve 1
echo solve 2
