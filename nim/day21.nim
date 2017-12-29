import strutils, tables, sequtils

const
  instructions = readFile("./inputs/21.txt").splitLines
  start = ".#./..#/###"

type Grid = seq[seq[bool]]

var
  mappings = initTable[Grid, Grid]()
  seen = initTable[Grid, Grid]()


proc flip(s: var Grid) =
  swap(s[0], s[^1])

proc transpose(s: var Grid) =
  for i in 0 .. s.high:
    for j in i+1 .. s.high:
      swap(s[j][i], s[i][j])

iterator transform(s: var Grid): Grid =
  for _ in 1 .. 4:
    yield s; s.transpose
    yield s; s.flip

proc toBool(s:string): seq[bool] =
  result = newSeq[bool](s.len)
  for i, c in s:
    result[i] = c == '#'

for line in instructions:
  let
    divided = line.strip.split(" => ")
    dest = divided[1].split('/').map(toBool)
  var
    source = divided[0].split('/').map(toBool)
  for src in source.transform:
    mappings[src] = dest




proc getSquare(grid: Grid, i, j, by: int): Grid =
  result = newSeqWith(by, newSeq[bool](by))
  var row = 0
  for x in i ..< i+by:
    result[row] = grid[x][j ..< j+by]
    inc row


proc findNext(grid: Grid): Grid =
  let
    size = grid.len
    by = if size mod 2 == 0: 2 else: 3
    newSize = size * (by+1) div by
  result = newSeqWith(newSize, newSeq[bool](newSize))

  for i in countup(0, size-1, by):
    for j in countup(0, size-1, by):
      let
        square = grid.getSquare(i, j, by)
        enhanced = mappings[square]
      for x, row in enhanced:
        for y, c in row:
          result[(i*(by+1) div by) + x][(j*(by+1) div by) + y] = c


proc findNew9x9(grid: Grid): Grid =
  result = grid
  if grid notin seen:
    for _ in 1 .. 3:
      result = result.findNext
    seen[grid] = result
  return seen[grid]


proc pixelsOn(grid: Grid): int =
  for r in grid:
    for c in r:
      if c: inc result


proc expand3x(grid: Grid): Grid =
  let size = grid.len
  result = newSeqWith(3*size, newSeq[bool](3*size))
  for i in countup(0, size-1, 3):
    for j in countup(0, size-1, 3):
      let
        square = grid.getSquare(i, j, 3)
        sqSol = square.findNew9x9
      for x, row in sqSol:
        for y, c in row:
          result[3*i + x][3*j + y] = c


var grid = start.split("/").map(toBool)
for _ in 1 .. 5:
  grid = grid.findNext
echo grid.pixelsOn

grid = grid.findNext # 6th iteration -> 27x27 grid of independent 3x3's
for _ in 1 .. (18 - 6) div 3:
  grid = grid.expand3x
echo grid.pixelsOn
