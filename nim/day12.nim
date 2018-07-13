import strutils, sequtils, tables

const instructions = readFile("./inputs/12.txt").splitLines()

func createGraph(): Table[uint16, seq[uint16]] =
  result = initTable[uint16, seq[uint16]]()
  for line in instructions:
    let
      nodes = line.split(" <-> ")
      pipe = nodes[0].parseUInt().uint16
    result[pipe] = nodes[1].split(", ").mapIt(it.parseUInt().uint16)

let graph = createGraph()


proc dfs(startingPoint: uint16): set[uint16] =
  var stack = @[startingPoint]
  while stack.len > 0:
    let current = stack.pop()
    result.incl(current)
    for node in graph[current]:
      if node notin result:
        stack.add(node)

func `+=`(a: var set[uint16], b: set[uint16]) = a = a + b


let firstIsland = dfs(0)
var
  groups: uint8
  seen: set[uint16]
seen += firstIsland
inc groups

for pipe in graph.keys:
  if pipe notin seen:
    seen += dfs(pipe)
    inc groups

echo firstIsland.card
echo groups

