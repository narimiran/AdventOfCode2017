var numbers: seq[int] = @[]
for i in readFile("./inputs/01.txt"):
  numbers.add(int(i) - int('0'))

proc solve(numbers: seq[int], secondPart=false): int =
  let
    size = len(numbers)
    jump = if secondPart: size div 2 else: 1
  for i, n in numbers:
    if n == numbers[(i + jump) mod size]:
      result += n
      
echo solve(numbers)
echo solve(numbers, secondPart=true)
