import strutils, complex

const
  instructions = readFile("./inputs/19.txt").splitLines
  leftTurn: Complex = (0.0, -1.0)
  rightTurn: Complex = (0.0, 1.0)

var
  pos: Complex = (instructions[0].find('|').toFloat, 0.0)
  direction: Complex = (0.0, 1.0)
  letters = ""
  steps = 0


proc getChar(pos: Complex): char =
  instructions[int(pos.im)][int(pos.re)]

proc change(direction: var Complex) =
  if getChar(pos + leftTurn * direction) != ' ': direction *= leftTurn
  else: direction *= rightTurn


var c = pos.getChar
while c != ' ':
  inc steps
  if c.isAlphaAscii: letters.add(c)
  elif c == '+': change direction
  pos += direction
  c = pos.getChar

echo letters
echo steps
