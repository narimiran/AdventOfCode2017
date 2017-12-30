import strutils

const input = readFile("./inputs/05.txt").splitLines
type Instructions = array[input.len, int]
var instructions: Instructions
for i, line in input: instructions[i] = line.parseInt


proc stepByStep(originalInstructions: Instructions, secondPart = false): uint =
  var
    instructions = originalInstructions
    line: int
  while line < instructions.len:
    let jump = instructions[line]
    if secondPart and jump >= 3: dec instructions[line]
    else: inc instructions[line]
    line += jump
    inc result


let first = instructions.stepByStep()
let second = instructions.stepByStep(secondPart=true)

echo first
echo second
