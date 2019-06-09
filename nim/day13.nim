import strutils, sets, tables, sequtils, math

proc makeFirewall(f: string): Table[int, HashSet[int]] =
  let instructions = readFile(f).splitLines()

  for line in instructions:
    let
      numbers = line.split(": ").map(parseInt)
      depth = numbers[0]
      height = numbers[1]
    if not result.hasKey(height):
      result[height] = initHashSet[int]()
    result[height].incl(depth)

const firewall = makeFirewall("./inputs/13.txt")


func isCaught(depth, height: int, delay = 0): bool =
  (depth + delay) mod (2 * (height - 1)) == 0

func calculateSeverity(): int =
  for height in firewall.keys:
    for depth in firewall[height]:
      if isCaught(depth, height):
        result += depth * height

func oneRemains(height: int, depths: HashSet[int]): bool =
  depths.card == height - 2


type
  Group = tuple[height: int, depths: HashSet[int]]
  Groups = seq[Group]
var
  calcGroup: Groups = @[]
  controlGroup: Groups = @[]

for h in firewall.keys:
  if oneRemains(h, firewall[h]):
    calcGroup.add((h, firewall[h]))
  else:
    controlGroup.add((h, firewall[h]))


func findAllowedDelay(height: int, depths: HashSet[int]): tuple[delay, period: int] =
  let period = 2 * (height - 1)
  var
    potential = initHashSet[int]()
    forbidden = initHashSet[int]()

  for i in countup(0, period-1, 2): potential.incl(i)
  for depth in depths: forbidden.incl(-depth mod period + period)

  var allowed = potential - forbidden
  result = (allowed.pop(), period)


func findDelayParams(walls: Groups): tuple[delay, step: int] =
  var
    delays: seq[int] = @[]
    periods: seq[int] = @[]
  for hd in walls:
    let (delay, period) = findAllowedDelay(hd.height, hd.depths)
    delays.add(delay)
    periods.add(period)

  let commonMulti = periods.foldl(lcm(a, b))
  var allowedDelays = initHashSet[int]()
  for i in 0 ..< commonMulti: allowedDelays.incl(i)

  for dp in zip(delays, periods):
    var s = initHashSet[int]()
    for i in countup(0, commonMulti-1, dp.b): s.incl(dp.a + i)
    allowedDelays = allowedDelays * s

  result = (allowedDelays.pop(), commonMulti)


func isCaught(hd: Group, delay: int): bool =
  for d in hd.depths:
    if isCaught(d, hd.height, delay):
      return true


var (delay, step) = calcGroup.findDelayParams()
while controlGroup.anyIt(it.isCaught(delay)):
  delay += step

echo calculateSeverity()
echo delay
