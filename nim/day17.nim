const puzzle = 394


proc spin(insertions = 2017): int =
  var
    spinlock = @[0]
    position: int
  for i in 1 .. insertions:
    position = (position + puzzle) mod i + 1
    spinlock.insert(i, position)
  return spinlock[position+1]

proc fakeSpin(insertions = 50_000_000): int =
  var position: int
  for i in 1 .. insertions:
    position = (position + puzzle) mod i + 1
    if position == 1:
      result = i


echo spin()
echo fakeSpin()
