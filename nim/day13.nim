import strutils, sets, tables, sequtils, math

const instructions = readFile("./inputs/13.txt").splitLines()

var firewall = initTable[int, HashSet[int]]()

for line in instructions:
  let
    numbers = line.split(": ").map(parseInt)
    depth = numbers[0]
    height = numbers[1]
  if not firewall.hasKey(height):
    firewall[height] = initSet[int]()
  firewall[height].incl(depth)


proc isCaught(depth, height: int, delay = 0): bool =
  (depth + delay) mod (2 * (height - 1)) == 0


proc calculateSeverity(): int =
  for height in firewall.keys:
    for depth in firewall[height]:
      if isCaught(depth, height):
        result += depth * height

echo calculateSeverity()



type
  Group = tuple[height: int, depths: HashSet[int]]
  Groups = seq[Group]
var
  calcGroup: Groups = @[]
  controlGroup: Groups = @[]


proc oneRemains(height: int, depths: HashSet[int]): bool =
  depths.card == height - 2

for h in firewall.keys:
  if oneRemains(h, firewall[h]):
    calcGroup.add((h, firewall[h]))
  else:
    controlGroup.add((h, firewall[h]))


proc findAllowedDelay(height: int, depths: HashSet[int]): tuple[delay, period: int] =
  let period = 2 * (height - 1)
  var
    potential = initSet[int]()
    forbidden = initSet[int]()

  for i in countup(0, period-1, 2): potential.incl(i)
  for depth in depths: forbidden.incl(-depth mod period + period)

  let allowed = potential - forbidden
  for d in allowed: result = (d, period); break


proc findDelayParams(walls: Groups): tuple[delay, step: int] =
  var
    delays: seq[int] = @[]
    periods: seq[int] = @[]
  for hd in walls:
    let (delay, period) = findAllowedDelay(hd.height, hd.depths)
    delays.add(delay)
    periods.add(period)

  let commonMulti = periods.foldl(lcm(a, b))
  var allowedDelays = initSet[int]()
  for i in 0 ..< commonMulti: allowedDelays.incl(i)

  for dp in zip(delays, periods):
    var s = initSet[int]()
    for i in countup(0, commonMulti-1, dp.b): s.incl(dp.a + i)
    allowedDelays = allowedDelays * s

  for d in allowedDelays: result = (d, commonMulti); break


var (delay, step) = findDelayParams(calcGroup)


proc isCaught(hd: Group, delay: int): bool =
  for d in hd.depths:
    if isCaught(d, hd.height, delay):
      return true

while controlGroup.anyIt(it.isCaught(delay)):
  delay += step

echo delay
