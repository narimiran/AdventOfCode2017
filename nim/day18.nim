import strutils, tables, deques

const instructions = readFile("./inputs/18.txt").splitLines
var
  x_reg = initTable[string, int]()
  y_reg = initTable[string, int]()
  x_i: int
  y_i: int
  x_queue = initDeque[int]()
  y_queue = initDeque[int]()
  sentCounter: int


proc interpret(r: Table[string, int], s: string): int =
  if s.isAlphaAscii: return r.getOrDefault(s)
  else: return parseInt s

proc solve(reg: var Table[string, int], i: var int, id = 'x', firstPart = false): int =
  result = 0
  while i < instructions.len:
    let
      c = split instructions[i]
      v = reg.interpret(c[^1])
      r = c[1]
    case c[0]
    of "set": reg[r] = v
    of "add": reg[r] = reg.getOrDefault(r) + v
    of "mul": reg[r] = reg.getOrDefault(r) * v
    of "mod": reg[r] = reg.getOrDefault(r) mod v
    of "jgz":
      if reg.interpret(r) > 0: i += v-1
    of "snd":
      if firstPart: result = v
      elif id == 'x': y_queue.addLast(v)
      else: inc sentCounter; x_queue.addLast(v)
    of "rcv":
      if firstPart:
        if v != 0: return result
      elif id == 'x' and x_queue.len > 0:
        reg[c[^1]] = x_queue.popFirst
      elif id == 'y' and y_queue.len > 0:
        reg[c[^1]] = y_queue.popFirst
      else:
        return i
    inc i


var
  firstRegister = initTable[string, int]()
  i = 0
echo solve(firstRegister, i, firstPart=true)


y_reg["p"] = 1
x_i = solve(x_reg, x_i, 'x')
y_i = solve(y_reg, y_i, 'y')
while x_queue.len > 0 or y_queue.len > 0:
  x_i = solve(x_reg, x_i, 'x')
  y_i = solve(y_reg, y_i, 'y')

echo sentCounter