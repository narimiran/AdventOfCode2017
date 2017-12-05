import strutils, sets, future, algorithm

const passphrases = readFile("./inputs/04.txt").splitLines()

var
  first: int
  second: int

proc areOnlyDistinct(containter: seq[string]): bool =
  len(containter) == len(containter.toSet())

proc letterSort(word: string): string =
  let letters = lc[c | (c <- word), char]
  return sorted(letters, cmp).join()


for line in passphrases:
  let
    words = line.split()
    anagrams = lc[letterSort(word) | (word <- words), string]
  if words.areOnlyDistinct(): inc first
  if anagrams.areOnlyDistinct(): inc second

echo first
echo second
