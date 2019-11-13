import strutils, intsets, tables, sequtils, math

proc makeFirewall(f: string): Table[int, IntSet] =
  let instructions = readFile(f).splitLines()

  for line in instructions:
    let
      numbers = line.split(": ").map(parseInt)
      depth = numbers[0]
      height = numbers[1]
    if not result.hasKey(height):
      result[height] = initIntSet()
    result[height].incl(depth)

let firewall = makeFirewall("./inputs/13.txt")


func isCaught(depth, height: int, delay = 0): bool =
  (depth + delay) mod (2 * (height - 1)) == 0

func calculateSeverity(firewall: Table[int, IntSet]): int =
  for height in firewall.keys:
    for depth in firewall[height]:
      if isCaught(depth, height):
        result += depth * height

func oneRemains(height: int, depths: IntSet): bool =
  depths.card == height - 2


type
  Group = tuple[height: int, depths: IntSet]
  Groups = seq[Group]
var
  calcGroup: Groups = @[]
  controlGroup: Groups = @[]

for h in firewall.keys:
  if oneRemains(h, firewall[h]):
    calcGroup.add((h, firewall[h]))
  else:
    controlGroup.add((h, firewall[h]))

func pymod(a, b: int): int =
  let m = -a mod b
  if m == 0: 0 else: m+b

func findAllowedDelay(height: int, depths: IntSet): tuple[delay, period: int] =
  let period = 2 * (height - 1)
  var
    potential = initIntSet()
    forbidden = initIntSet()

  for i in countup(0, period-1, 2): potential.incl(i)
  for depth in depths: forbidden.incl(pymod(depth, period))

  var allowed = potential - forbidden
  var e: int # poor man's pop
  for i in allowed: e = i; break
  result = (e, period)


func findDelayParams(walls: Groups): tuple[delay, step: int] =
  var
    delays: seq[int] = @[]
    periods: seq[int] = @[]
  for hd in walls:
    let (delay, period) = findAllowedDelay(hd.height, hd.depths)
    delays.add(delay)
    periods.add(period)

  let commonMulti = periods.foldl(lcm(a, b))
  var allowedDelays = initIntSet()
  for i in 0 ..< commonMulti: allowedDelays.incl(i)

  for (d, p) in zip(delays, periods):
    var s = initIntSet()
    for i in countup(0, commonMulti-1, p): s.incl(d + i)
    allowedDelays = allowedDelays * s

  var e: int # poor man's pop
  for i in allowedDelays: e = i; break
  result = (e, commonMulti)


func isCaught(hd: Group, delay: int): bool =
  for d in hd.depths:
    if isCaught(d, hd.height, delay):
      return true


var (delay, step) = calcGroup.findDelayParams()
while controlGroup.anyIt(it.isCaught(delay)):
  delay += step

echo firewall.calculateSeverity()
echo delay
