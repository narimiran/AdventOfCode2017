import sugar, strutils, sequtils

const res = lc[i | (i <- 0 .. 255), int]


func knotLogic(sizes: seq[int], iterations = 64): seq[int] =
  result = res
  const size = 255
  var pos, skip, a, b: int

  for i in 1 .. iterations:
    for groupSize in sizes:
      for p in 0 ..< (groupSize div 2):
        a = (pos + p) and size
        b = (pos + groupSize-1 - p) and size
        swap(result[a], result[b])
      pos = (pos + groupSize + skip) and size
      inc skip


func knotHashing*(word: string, binOut = false): string =
  let
    asciiSizes = word.mapIt(ord it).concat(@[17, 31, 73, 47, 23])
    numbers = knotLogic(asciiSizes)
  for bl in 0 .. 15:
    var hashed: int
    for i in 0 .. 15:
      hashed = hashed.xor(numbers[16*bl + i])

    let hashOut = if binOut: hashed.toBin(8) else: hashed.toHex(2)
    result.add(hashOut)


when isMainModule:
  let
    inputString = readFile("./inputs/10.txt")
    intSizes = inputString.split(',').map(parseInt)
    firstHash = knotLogic(intSizes, 1)
    first = firstHash[0] * firstHash[1]
    second = knotHashing(inputString).toLowerAscii()

  echo first
  echo second
