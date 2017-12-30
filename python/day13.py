from collections import defaultdict
from math import gcd
from functools import reduce


with open('./inputs/13.txt') as f:
    instructions = f.readlines()

firewall = defaultdict(set)

for line in instructions:
    depth, height = (int(n) for n in line.split(': '))
    firewall[height].add(depth)


def is_caught(depth, height, delay=0):
    return (depth + delay) % (2 * (height - 1)) == 0

def calculate_severity(fw):
    severity = 0
    for height, depths in fw.items():
        for depth in depths:
            if is_caught(depth, height):
                severity += depth * height
    return severity


first = calculate_severity(firewall)
print(first)




# walls which will have only one allowed delay in `find_allowed_delay`
one_remains = lambda h, ds: len(ds) == h - 2

calc_group = [w for w in firewall.items() if one_remains(*w)]
control_group = [w for w in firewall.items() if not one_remains(*w)]


def find_allowed_delay(height, depths):
    period = 2 * (height - 1)
    potential = set(range(0, period, 2)) # ony even, because of "1: 2" layer
    forbidden = {-depth % period for depth in depths}
    allowed_delay = (potential - forbidden).pop() # just one value in the set
    return allowed_delay, period


def find_delay_params(walls):
    potential_delays = {find_allowed_delay(h, ds) for h, ds in walls}
    lcm = lambda a, b: a * b // gcd(a, b)
    common_multi = reduce(lcm, (period for _, period in potential_delays))

    delays = set(range(common_multi))
    for delay, period in potential_delays:
        s = {delay + i*period for i in range(common_multi // period)}
        delays &= s
    return delays.pop(), common_multi


delay, step = find_delay_params(calc_group)
while any(is_caught(d, h, delay) for h, ds in control_group for d in ds):
    delay += step

print(delay)
