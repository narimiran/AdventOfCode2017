import tables, strutils

const instructions = readFile("./inputs/08.txt").splitLines()
var
  registers = initTable[string, int]()
  maximum: int
  biggest: int


proc change(reg, op: string, amount: int) =
  case op
  of "inc": registers[reg] += amount
  of "dec": registers[reg] -= amount

proc checkCondition(reg, op: string, value: int): bool =
  let regVal = registers[reg]
  case op
  of "<": return regVal < value
  of ">": return regVal > value
  of "<=": return regVal <= value
  of ">=": return regVal >= value
  of "==": return regVal == value
  of "!=": return regVal != value


var
  words: seq[string]
  register, instruction: string
  conditionRegister, conditionOperator: string
  amount, value: int


for line in instructions:
  words = line.split()
  register = words[0]
  instruction = words[1]
  amount = words[2].parseInt()
  conditionRegister = words[^3]
  conditionOperator = words[^2]
  value = words[^1].parseInt()
  if not registers.hasKey(register): registers[register] = 0
  if not registers.hasKey(conditionRegister): registers[conditionRegister] = 0

  if checkCondition(conditionRegister, conditionOperator, value):
    change(register, instruction, amount)
    if registers[register] > maximum: maximum = registers[register]

for v in registers.values:
  if v > biggest: biggest = v

echo biggest
echo maximum
