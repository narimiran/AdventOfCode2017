import strutils

const
  instructions = readFile("./inputs/16.txt").split(',')
  programs = "abcdefghijklmnop"

proc dance(dancers: string): string =
  result = dancers
  for instr in instructions:
    let rem = instr[1 .. instr.high]
    case instr[0]
    of 's':
      let rot = rem.parseInt
      result = result[^rot .. result.high] & result[0 ..< ^rot]
    of 'x':
      let
        x = rem.split('/')
        a = x[0].parseInt
        b = x[1].parseInt
        temp = result[a]
      result[a] = result[b]
      result[b] = temp
    of 'p':
      let
        a = result.find(rem[0])
        b = result.find(rem[^1])
      result[a] = rem[^1]
      result[b] = rem[0]
    else: discard

proc longDance(dancers: string, iterations = 1_000_000_000): string =
  var
    dancers = dancers
    seen = @[dancers]
  for i in 1 .. iterations:
    dancers = dancers.dance()
    if dancers in seen:
      return seen[iterations mod i]
    seen.add(dancers)


echo dance(programs)
echo longDance(programs)
