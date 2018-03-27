import future, strutils, sequtils, algorithm


const res = lc[i | (i <- 0 .. 255), int]

proc knotLogic(sizes: seq[int], iterations = 64): seq[int] =
  result = res
  const size = 255
  var
    pos: int
    skip: int
    a, b, tmp: int
  for i in 1 .. iterations:
    for groupSize in sizes:
      for p in 0 ..< (groupSize div 2):
        a = (pos + p) and size
        b = (pos + groupSize-1 - p) and size
        tmp = result[b]
        result[b] = result[a]
        result[a] = tmp
      pos = (pos + groupSize + skip) and size
      inc skip


proc knotHashing*(word: string, binOut = false): string =
  result = ""
  const toAdd = @[17, 31, 73, 47, 23]
  let
    asciiSizes = lc[ord(c) | (c <- word), int].concat(toAdd)
    numbers = knotLogic(asciiSizes)
  for bl in 0 .. 15:
    var hashed: int
    for i in 0 .. 15:
      hashed = hashed.xor(numbers[16*bl + i])
    if binOut:
      result.add(hashed.toBin(8))
    else:
      result.add(hashed.toHex(2))


when isMainModule:
  let
    inputString = readFile("./inputs/10.txt")
    intSizes = lc[parseInt(n) | (n <- inputString.split(',')), int]
    firstHash = knotLogic(intSizes, 1)
    first = firstHash[0] * firstHash[1]
    second = knotHashing(inputString).toLowerAscii()

  echo first
  echo second
