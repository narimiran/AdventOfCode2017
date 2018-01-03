import strutils, tables

const instructions = readFile("./inputs/22.txt").splitLines

type
  Point = tuple[x, y: int]
  Rotation = enum left, right, back


proc solve(part: int): int =
  var
    grid: array[-200 .. 250, array[-200 .. 250, int]] # manually tweaked
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
      if mark == '#':
        grid[i][j] = part

  let bursts = if part == 1: 10_000 else: 10_000_000
  for _ in 1 .. bursts:
    let status = grid[position.x][position.y]
    status.logic
    grid[position.x][position.y] = (status + 1) mod (2 * part)
    position += direction
  return infected


echo solve 1
echo solve 2
