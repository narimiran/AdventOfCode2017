import re, tables, strutils, sets, math

const instructions = readFile("./inputs/07.txt").splitLines()
let pattern = re"\w+"
var
  weights = initTable[string, int]()
  children = initTable[string, seq[string]]()
  allNodes = initHashSet[string]()
  allKids = initHashSet[string]()

for line in instructions:
  let
    words = line.findAll(pattern)
    name = words[0]
    weight = words[1].parseInt()
    kids = if len(words) > 2: words[2 .. ^1] else: @[]
  weights[name] = weight
  children[name] = kids

for node in children.keys():
  allNodes.incl(node)
  for kid in children[node]:
    allKids.incl(kid)

var root = ""
for r in (allNodes - allKids): root = r
echo root


func findCorrectWeight(weights: seq[int]): int =
  var counts = initCountTable[int]()
  for weight in weights: counts.inc(weight)
  return counts.largest.key


proc findOffspringsWeights(node: string): int =
  var kidsWeights: seq[int] = @[]
  for kid in children[node]:
    kidsWeights.add(findOffspringsWeights(kid))

  if len(kidsWeights.toHashSet) > 1:
    let correct = findCorrectWeight(kidsWeights)
    var wrong: int
    for weight in kidsWeights.toHashSet:
      if weight != correct: wrong = weight
    let
      difference = correct - wrong
      wrongNode = children[node][kidsWeights.find(wrong)]
      wrongWeight = weights[wrongNode]
    echo wrongWeight + difference
    return weights[node] + sum(kidsWeights) + difference

  return weights[node] + sum(kidsWeights)


discard root.findOffspringsWeights()
