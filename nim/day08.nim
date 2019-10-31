import tables, strutils

const instructions = readFile("./inputs/08.txt").splitLines()

type Instruction = tuple
  reg, instr, condReg, condOp: string
  amount, value: int


func parseLine(w: seq[string]): Instruction =
  (w[0], w[1], w[^3], w[^2], w[2].parseInt, w[^1].parseInt)

func isConditionSatisfied(op: string, regVal, value: int): bool =
  case op
    of "<":  regVal < value
    of ">":  regVal > value
    of "<=": regVal <= value
    of ">=": regVal >= value
    of "==": regVal == value
    else:    regVal != value


var
  registers = initCountTable[string]()
  maximum: int

for line in instructions:
  let
    l = line.split().parseLine()
    regVal = registers.getOrDefault(l.condReg)

  if isConditionSatisfied(l.condOp, regVal, l.value):
    case l.instr
      of "inc":
        registers.inc(l.reg, l.amount)
      of "dec":
        registers.inc(l.reg, -l.amount)
    maximum = max(registers[l.reg], maximum)


echo registers.largest.val
echo maximum
