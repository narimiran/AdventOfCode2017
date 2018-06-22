import sequtils

const
  digits = readFile("./inputs/01.txt").mapIt(int(it) - int('0'))
  size = digits.len


func solve(jump: int): int =
  for i, n in digits:
    if n == digits[(i + jump) mod size]:
      result += n

echo solve(1)
echo solve(size div 2)
