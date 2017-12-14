with open('./inputs/13.txt') as f:
    instructions = f.readlines()

firewall = {}

for line in instructions:
    depth, height = [int(n) for n in line.split(': ')]
    firewall[depth] = height


def is_caught(depth, height, delay=0):
    return (depth + delay) % (2 * (height - 1)) == 0

def calculate_severity(fw):
    severity = 0
    for depth, height in fw.items():
        if is_caught(depth, height):
            severity += depth * height
    return severity


first = calculate_severity(firewall)
print(first)



delay = 0
while any(is_caught(d, h, delay) for d, h in firewall.items()):
    delay += 2 # only even, because of "1: 2" layer

print(delay)
