with open('./inputs/19.txt') as f:
    instructions = f.readlines()

pos = instructions[0].find('|') + 0j
direction = 1j
letters = []
steps = 0


get_char = lambda pos: instructions[int(pos.imag)][int(pos.real)]

def change_direction(direction):
    candidate = direction * 1j
    return candidate if get_char(pos + candidate) != ' ' else direction * -1j


char = get_char(pos)
while char != ' ':
    steps += 1
    if char.isalpha():
        letters.append(char)
    elif char == '+':
        direction = change_direction(direction)
    pos += direction
    char = get_char(pos)

print(''.join(letters))
print(steps)
