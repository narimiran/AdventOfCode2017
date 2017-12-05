with open('./inputs/04.txt') as f:
    passphrases = f.readlines()

first = 0
second = 0

are_only_distinct = lambda x: len(x) == len(set(x))

for line in passphrases:
    words = line.split()
    first += are_only_distinct(words)
    anagrams = [''.join(sorted(word)) for word in words]
    second += are_only_distinct(anagrams)

print(first)
print(second)
