proc readDigits(f: string): seq[int] =
  for i in readFile(f):
    result.add(int(i) - int('0'))

const
  digits = readDigits("./inputs/01.txt")
  size = digits.len


func solve(jump: int): int =
  for i, n in digits:
    if n == digits[(i + jump) mod size]:
      result += n

echo solve(1)
echo solve(size div 2)
