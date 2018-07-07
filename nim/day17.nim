const puzzle = 394


func spin(insertions = 2017): int =
  var
    spinlock = @[0]
    position: int
  for i in 1 .. insertions:
    position = (position + puzzle) mod i + 1
    spinlock.insert(i, position)
  return spinlock[position+1]

func fakeSpin(insertions = 50_000_000): int =
  var
    position: int
    skip: int
    length = 1
  while length < insertions:
    position = (position + puzzle) mod length + 1
    if position == 1:
      result = length
    skip = (length - position) div puzzle
    position += skip * (puzzle + 1)
    length += skip + 1


echo spin()
echo fakeSpin()
