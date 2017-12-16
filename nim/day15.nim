const
  factorA = 16807
  factorB = 48271
  divisor = 2147483647


proc generate(value: var int, factor, multi: int): int =
  while true:
    value = value * factor mod divisor
    if value mod multi == 0:
      return value and 0xFFFF

var
  a = 699
  b = 124
  total = 0

for _ in 1 .. 40_000_000:
  if generate(a, factorA, 1) == generate(b, factorB, 1):
    inc total
echo total



a = 699
b = 124
total = 0

for _ in 1 .. 5_000_000:
  if generate(a, factorA, 4) == generate(b, factorB, 8):
    inc total
echo total
