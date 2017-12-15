import future, strutils, sequtils, algorithm


proc knotLogic(sizes: seq[int], iterations = 64): seq[int] =
  const size = 256
  result = lc[i | (i <- 0 ..< size), int]
  var
    pos: int
    skip: int
  for i in 1 .. iterations:
    for groupSize in sizes:
      var knot: seq[int] = @[]
      for position in pos ..< pos+groupSize:
        knot.add(result[position mod size])
      knot.reverse()
      for i in 0 ..< len(knot):
        result[(pos+i) mod size] = knot[i]
      pos = (pos + groupSize + skip) mod size
      inc skip


proc knotHashing*(word: string): string =
  result = ""
  const
    size = 256
    blockSize = 16
    toAdd = @[17, 31, 73, 47, 23]
  let
    asciiSizes = lc[ord(c) | (c <- word), int].concat(toAdd)
    numbers = knotLogic(asciiSizes)
  for bl in countup(0, size-1, blockSize):
    var hashed: int
    let group = numbers[bl ..< bl+blockSize]
    for n in group:
      hashed = hashed.xor(n)
    result.add(hashed.toHex(2).toLowerAscii())

when isMainModule:
  let
    inputString = readFile("./inputs/10.txt")
    intSizes = lc[parseInt(n) | (n <- inputString.split(',')), int]
    firstHash = knotLogic(intSizes, 1)
    first = firstHash[0] * firstHash[1]
    second = knotHashing(inputString)

  echo first
  echo second
