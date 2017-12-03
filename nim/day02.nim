import strutils, sequtils

var spreadsheet: seq[seq[int]] = @[]
for line in readFile("./inputs/02.txt").splitlines():
  spreadsheet.add(line.split().map(parseInt))

var
  first: int
  second: int

for line in spreadsheet:
  first += max(line) - min(line)

  for a in line:
    for b in line:
      if a mod b == 0 and a != b:
        second += a div b

echo first
echo second
