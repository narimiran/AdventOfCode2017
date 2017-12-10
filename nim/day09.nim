const stream = readFile("./inputs/09.txt")

var
  garbageCleaned: int
  nestingLevel: int
  score: int
  i: int

while i < stream.len:
  case stream[i]
  of '<':
    inc i
    while stream[i] != '>':
      if stream[i] == '!': inc i
      else: inc garbageCleaned
      inc i
  of '{': inc nestingLevel
  of '}':
    score += nestingLevel
    dec nestingLevel
  else: discard
  inc i

echo score
echo garbageCleaned
