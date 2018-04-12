import strutils, deques


const rawInstructions = readFile("./inputs/18.txt").splitLines

type
  Instruction = tuple
    command: char
    switch: bool
    register, value: int
  Registers = array[26, int]

var
  first_reg, x_reg, y_reg: Registers
  first_i, x_i, y_i: int
  x_queue = initDeque[int]()
  y_queue = initDeque[int]()
  sentCounter: int
  instructions: array[41, Instruction]
  r, v: int

for i, line in rawInstructions:
  let c = line[1] # second letter of a command is unique
  r = ord(line[4]) - ord('a')
  var s: bool
  if line.len > 5:
    if line[6].isAlphaAscii:
      s = true
      v = ord(line[6]) - ord('a')
    else:
      v = parseInt(line[6 .. line.high])
  instructions[i] = (c, s, r, v)


proc solve(reg: var Registers, i: var int, id = 'x', firstPart = false): int =
  var
    c: char
    s: bool
    r, val, v: int
  while i < instructions.len:
    (c, s, r, val) = instructions[i]
    v = if s: reg[val] else: val
    case c
      of 'e': reg[r] = v
      of 'd': reg[r] += v
      of 'u': reg[r] *= v
      of 'o': reg[r] = reg[r] mod v
      of 'g':
        if i == 33 or reg[r] > 0:
          i += v; continue
      of 'n':
        if firstPart:
          result = reg[r]
        elif id == 'x':
          y_queue.addLast(reg[r])
        else:
          inc sentCounter
          x_queue.addLast(reg[r])
      of 'c':
        if firstPart:
          if reg[r] != 0:
            return result
        elif id == 'x' and x_queue.len > 0:
          reg[r] = x_queue.popFirst
        elif id == 'y' and y_queue.len > 0:
          reg[r] = y_queue.popFirst
        else:
          return i
      else: discard
    inc i


echo solve(first_reg, first_i, firstPart = true)


y_reg[ord('p') - ord('a')] = 1
x_i = solve(x_reg, x_i, 'x')
y_i = solve(y_reg, y_i, 'y')
while x_queue.len > 0 or y_queue.len > 0:
  x_i = solve(x_reg, x_i, 'x')
  y_i = solve(y_reg, y_i, 'y')

echo sentCounter
