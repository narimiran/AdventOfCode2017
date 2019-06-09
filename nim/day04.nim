import strutils, sets, algorithm, sequtils

const passphrases = readFile("./inputs/04.txt").splitLines()

func areOnlyDistinct(containter: seq[string]): bool =
  len(containter) == len(containter.toHashSet)

func letterSort(word: string): string =
  sorted(word).join()

var
  first, second: int
  words, anagrams: seq[string]

for line in passphrases:
  words = line.split()
  anagrams = words.map(letterSort)
  if words.areOnlyDistinct: inc first
  if anagrams.areOnlyDistinct: inc second

echo first
echo second
