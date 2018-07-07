import strutils, tables, sequtils

const instructions = readFile("./inputs/21.txt").splitLines
type Grid = seq[seq[bool]]


func flip(s: var Grid) = swap(s[0], s[^1])

func transpose(s: var Grid) =
  for i in 0 .. s.high:
    for j in i+1 .. s.high:
      swap(s[j][i], s[i][j])

iterator transform(s: var Grid): Grid =
  for _ in 1 .. 4:
    yield s; s.transpose
    yield s; s.flip

func toBool(s:string): seq[bool] =
  result = newSeq[bool](s.len)
  for i, c in s:
    result[i] = c == '#'


func parseInput(): Table[Grid, Grid] =
  result = initTable[Grid, Grid]()
  var
    divided: seq[string]
    source, dest: seq[seq[bool]]
  for line in instructions:
    divided = line.strip.split(" => ")
    source = divided[0].split('/').map(toBool)
    dest = divided[1].split('/').map(toBool)
    for src in source.transform:
      result[src] = dest


const
  startingGrid = ".#./..#/###".split("/").map(toBool)
  mappings = parseInput()


func getSquare(grid: Grid, i, j, by: int): Grid =
  result = newSeqWith(by, newSeq[bool](by))
  var row = 0
  for x in i ..< i+by:
    result[row] = grid[x][j ..< j+by]
    inc row


func findNext(grid: Grid): Grid =
  let
    size = grid.len
    by = if size mod 2 == 0: 2 else: 3
    newSize = size * (by+1) div by
    squareSize = size div by
  var square, enhanced: Grid
  result = newSeqWith(newSize, newSeq[bool](newSize))

  for i in 0 ..< squareSize:
    for j in 0 ..< squareSize:
      square = grid.getSquare(i*by, j*by, by)
      enhanced = mappings[square]
      for x, row in enhanced:
        for y, c in row:
          result[i*(by+1) + x][j*(by+1) + y] = c


func forward3steps(pattern: Grid): CountTable[Grid] =
  result = initCountTable[Grid]()
  var
    pattern = pattern
    square: Grid
  for _ in 1 .. 3:
    pattern = pattern.findNext
  for r in 0 .. 2:
    for c in 0 .. 2:
      square = pattern.getSquare(3*r, 3*c, 3)
      result.inc(square)


func pixelsOn(grid: Grid): int =
  for r in grid:
    for c in r:
      if c: inc result


func fastCount(grid: Grid, steps: int): int =
  var
    blockCounts = initCountTable[Grid]()
    mappingCounts = initTable[Grid, CountTable[Grid]]()
  blockCounts[grid] = 1

  for step in 1 .. steps:
    var tempBlockCounts = initCountTable[Grid]()
    for pattern, count in blockCounts.pairs:
      if pattern notin mappingCounts:
        mappingCounts[pattern] = forward3steps(pattern)
      for enhPattern, enhCount in mappingCounts[pattern].pairs:
        tempBlockCounts.inc(enhPattern, count*enhCount)
    blockCounts = tempBlockCounts

  for pattern, count in blockCounts.pairs:
    result += pattern.pixelsOn * count


var first = startingGrid
for _ in 1 .. 5:
  first = first.findNext
echo first.pixelsOn

echo startingGrid.fastCount(18 div 3)
