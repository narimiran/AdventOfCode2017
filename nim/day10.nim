import future, strutils, sequtils, algorithm

const
  inputString = readFile("./inputs/10.txt")
  size = 256
let
  intSizes = lc[parseInt(n) | (n <- inputString.split(',')), int]
  toAdd = @[17, 31, 73, 47, 23]
  asciiSizes = lc[ord(c) | (c <- inputString), int].concat(toAdd)
  numbers = lc[i | (i <- 0 ..< size), int]


proc knotHashing(circle, sizes: seq[int], secondPart = false): seq[int] =
  result = circle
  let iterations = if secondPart: 64 else: 1
  var
    pos: int
    skip: int
  for _ in 1 .. iterations:
    for groupSize in sizes:
      var knot: seq[int] = @[]
      for position in pos ..< pos+groupSize:
        knot.add(result[position mod size])
      knot.reverse()
      for i in 0 ..< len(knot):
        result[(pos+i) mod size] = knot[i]
      pos = (pos + groupSize + skip) mod size
      inc skip
  
let firstHash = knotHashing(numbers, intSizes)
echo(firstHash[0] * firstHash[1])



let secondHash = knotHashing(numbers, asciiSizes, secondPart=true)
const blockSize = 16
var dense: seq[int] = @[]

for bl in countup(0, size-1, blockSize):
  var hashed: int
  let group = secondHash[bl ..< bl+blockSize]
  for n in group:
    hashed = hashed.xor(n)
  dense.add(hashed)

var second = ""
for n in dense: second.add(toHex(n, 2).toLowerAscii())
echo second
