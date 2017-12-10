with open('./inputs/09.txt') as f:
    stream = f.readline()

garbage_cleaned = 0
nesting_level = 0
score = 0

i = 0
while i < len(stream):
    if stream[i] == '<':
        i += 1
        while stream[i] != '>':
            if stream[i] == '!':
                i += 1
            else:
                garbage_cleaned += 1
            i += 1
    elif stream[i] == '{':
        nesting_level += 1
    elif stream[i] == '}':
        score += nesting_level
        nesting_level -= 1
    i += 1

print(score)
print(garbage_cleaned)
