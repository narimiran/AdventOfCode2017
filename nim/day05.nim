import sequtils, strutils

const originalInstructions = readFile("./inputs/05.txt").splitLines.map(parseInt)


proc stepByStep(originalInstructions: seq[int], secondPart = false): uint =
  var
    instructions = originalInstructions
    line: int
  while line < len(instructions):
    let jump = instructions[line]
    if secondPart and jump >= 3: instructions[line] -= 1
    else: instructions[line] += 1
    line += jump
    result += 1


let first = stepByStep(originalInstructions)
let second = stepByStep(originalInstructions, secondPart=true)

echo first
echo second
