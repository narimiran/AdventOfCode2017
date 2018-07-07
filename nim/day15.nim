const
  factorA = 16807
  factorB = 48271
  divisor = 2147483647 # 2^31 - 1


func findNext(value: var int, factor, mask: int) =
  while true:
    value *= factor
    while value >= divisor:
      value = (value and divisor) + value.shr 31
    if (value and mask) == 0: break

func solve(limit, multiA, multiB: int): int =
  var
    a = 699
    b = 124
  for _ in 1 .. limit:
    a.findNext factorA, multiA-1
    b.findNext factorB, multiB-1
    if ((a xor b) and 0xFFFF) == 0:
      inc result


echo solve(40_000_000, 1, 1)
echo solve(5_000_000, 4, 8)
