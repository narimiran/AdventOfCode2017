import strutils, sequtils, tables, sets

const
  instructions = readFile("./inputs/12.txt").splitLines()
  start = 0
var
  graph = initTable[int, seq[int]]()
  seen = initSet[int]()
  groups: int

for line in instructions:
  let
    nodes = line.split(" <-> ")
    pipe = nodes[0].parseInt()
    neighbours = nodes[1].split(", ").map(parseInt)
  graph[pipe] = neighbours


proc dfs(startingPoint: int): HashSet[int] =
  result = initSet[int]()
  var stack = @[startingPoint]
  while stack.len > 0:
    let current = stack.pop()
    result.incl(current)
    for node in graph[current]:
      if node notin result:
        stack.add(node)

proc `+=`(a: var HashSet, b: HashSet) = a = a + b


let firstIsland = dfs(start)
echo card(firstIsland)

seen += firstIsland
inc groups

for pipe in graph.keys:
  if pipe notin seen:
    seen += dfs(pipe)
    inc groups

echo groups
