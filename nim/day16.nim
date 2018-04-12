import strutils, sequtils, algorithm


const
  instructions = readFile("./inputs/16.txt").split(',')
  iterations = 1_000_000_000
  programs = "abcdefghijklmnop"


type Parsed = object
  first, pa, pb: char
  second, xa, xb: int


proc parse(instruction: string): Parsed =
  let
    first = instruction[0]
    rest = instruction[1 .. instruction.high]
  var x: seq[int]

  case first
    of 's':
      result = Parsed(first: first, second: rest.parseInt)
    of 'x':
      x = rest.split('/').map(parseInt)
      result = Parsed(first: first, xa: x[0], xb: x[1])
    of 'p':
      result = Parsed(first: first, pa: rest[0], pb: rest[^1])
    else: discard


proc cleanUp(instructions: seq[string]): seq[Parsed] =
  result = @[]
  for instruction in instructions:
    result.add(parse(instruction))


let cleaned = instructions.cleanUp()


proc dance(dancers: string): string =
  result = dancers
  var a, b: int
  for element in cleaned:
    case element.first
    of 's':
      discard result.rotateLeft(-element.second)
    of 'x':
      swap(result[element.xa], result[element.xb])
    of 'p':
      a = result.find(element.pa)
      b = result.find(element.pb)
      result[a] = element.pb
      result[b] = element.pa
    else: discard


proc longDance(dancers: string): string =
  var
    dancers = dancers
    seen = @[dancers]
  for i in 1 .. iterations:
    dancers = dancers.dance()
    if dancers in seen:
      return seen[iterations mod i]
    seen.add(dancers)


echo programs.dance()
echo programs.longDance()
