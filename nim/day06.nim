import strutils, sequtils, sets

var
  banks = readFile("./inputs/06.txt").split.map(parseInt)
  size = len(banks)
  seen = initOrderedSet[string]()

seen.incl(banks.join(" "))

while true:
  let
    maxValue = max(banks)
    maxIndex = banks.find(maxValue)

  banks[maxIndex] = 0
  for i in 1 .. maxValue: inc banks[(maxIndex + i) mod size]

  let banksHash = banks.join(" ")
  if banksHash notin seen: seen.incl(banksHash)
  else: break

let loopStart = toSeq(seen.items).find(banks.join(" "))

echo len(seen)
echo len(seen) - loopStart 
