import sequtils, strutils

const instructions = readFile("./inputs/13.txt").splitLines()

type
  Layer = tuple[depth, period: int]
  Firewall = seq[Layer]
var firewall: Firewall = @[]

for line in instructions:
  let
    numbers = line.split(": ").map(parseInt)
    period = 2 * (numbers[1] - 1)
  firewall.add((numbers[0], period))


proc isCaught(layer: Layer): bool =
  layer.depth mod layer.period == 0

proc calculateSeverity(): int =
  for layer in firewall:
    if layer.isCaught():
      result += layer.depth * (layer.period + 2) div 2

echo calculateSeverity()



proc allPass(layers: Firewall, delay: int): bool =
  all(layers) do (layer: Layer) -> bool:
    (layer.depth + delay) mod layer.period != 0

var delay = 0
while not allPass(firewall, delay):
  delay += 2 # only even, because of "1: 2" layer

echo delay
