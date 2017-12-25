import strutils, tables, math

const instructions = readFile("./inputs/23.txt").splitLines


proc solve(part: int): int =
  var
    reg = initTable[string, int]()
    i = 0
  reg["a"] = part - 1

  proc interpret(s: string): int =
    if s.isAlphaAscii: return reg.getOrDefault(s)
    else: return parseInt s

  while i < 11:
    let
      line = split instructions[i]
      v = interpret line[^1]
      r = line[1]
    case line[0]
    of "set": reg[r] = v
    of "sub": reg[r] -= v
    of "mul": reg[r] *= v
    of "jnz":
      if interpret(r) != 0:
        i += v
        continue
    inc i

  if part == 1:
    return (reg["b"] - reg["e"]) * (reg["b"] - reg["d"])
  else:
    var nonprimes = (reg["c"] - reg["b"]) div 34 + 1
    for b in countup(reg["b"]+17, reg["c"], 34):
      for d in countup(3, int(sqrt(float(b))), 2):
        if b mod d == 0:
          inc nonprimes
          break
    return nonprimes


echo solve 1
echo solve 2
