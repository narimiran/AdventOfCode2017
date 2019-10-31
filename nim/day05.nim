import strutils

const instructions = readFile("./inputs/05.txt").splitLines.map(parseInt)


func stepByStep(originalInstructions: seq[int], secondPart = false): uint32 =
  var
    instructions = originalInstructions
    line, jump: int

  while line < instructions.len:
    jump = instructions[line]
    if secondPart and jump >= 3:
      dec instructions[line]
    else:
      inc instructions[line]
    line += jump
    inc result


echo instructions.stepByStep()
echo instructions.stepByStep(secondPart=true)
