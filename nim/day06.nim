import strutils, sequtils, sets

var
  banks = readFile("./inputs/06.txt").split.map(parseInt)
  seen = initOrderedSet[seq[int]]()
  maxValue, maxIndex: int

seen.incl(banks)

while true:
  maxValue = max(banks)
  maxIndex = banks.find(maxValue)

  banks[maxIndex] = 0
  for i in 1 .. maxValue:
    inc banks[(maxIndex + i) and 15]

  if banks notin seen: seen.incl(banks)
  else: break

let loopStart = toSeq(seen.items).find(banks)

echo len(seen)
echo len(seen) - loopStart
