instructions = []
with open('./inputs/02.txt') as f:
    for line in f:
        instructions.append([int(i) for i in line.split()])

first = sum(max(line) - min(line) for line in instructions)

second = 0
for line in instructions:
    for a in line:
        for b in line:
            if a % b == 0 and a != b:
                second += a // b

print(first)
print(second)
