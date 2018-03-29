from collections import defaultdict
import re


with open('./inputs/20.txt') as f:
    instructions = f.readlines()

def manhattan(particle_accelerations):
    return sum(abs(r) for r in particle_accelerations)

pattern = re.compile(r'p=<(-*\d+,-*\d+,-*\d+)>, v=<(-*\d+,-*\d+,-*\d+)>, a=<(-*\d+,-*\d+,-*\d+)>')
particles = []
smallest_acceleration = 98765
closest_particle = None

for i, line in enumerate(instructions):
    particle = tuple(tuple(map(int, g.split(','))) for g in re.match(pattern, line).groups())
    manhattan_acceleration = manhattan(particle[-1])
    if manhattan_acceleration < smallest_acceleration:
        smallest_acceleration = manhattan_acceleration
        closest_particle = i
    particles.append(particle)

print(closest_particle)




def get_differences(x, y):
    diff = lambda r_x, r_y: (r_x[0] - r_y[0], r_x[1] - r_y[1], r_x[2] - r_y[2])
    p_x, v_x, a_x = x
    p_y, v_y, a_y = y

    p_diffs = diff(p_x, p_y)
    v_diffs = diff(v_x, v_y)
    a_diffs = diff(a_x, a_y)
    return p_diffs, v_diffs, a_diffs


def check_collision(ppp, vvv, aaa, t):
    return all(0.5*a*t*t + (v+0.5*a)*t + p == 0 for p, v, a in zip(ppp, vvv, aaa))


def find_collisions(x, y):
    ppp, vvv, aaa = get_differences(x, y)
    soonest_collision = 98765
    p, v, a = ppp[0], vvv[0], aaa[0]
    b = -v - 0.5 * a
    D = b*b - 2 * a * p
    if a == 0:
        if v != 0:
            t = -p/v
            if check_collision(ppp, vvv, aaa, t) and t < soonest_collision:
                soonest_collision = t
    elif D == 0:
        t = b/a
        if check_collision(ppp, vvv, aaa, t) and t < soonest_collision:
            soonest_collision = t
    else:
        for t in ((b - D**0.5)/a, (b + D**0.5)/a):
            if check_collision(ppp, vvv, aaa, t) and t < soonest_collision:
                soonest_collision = t
    return int(soonest_collision)


collisions = defaultdict(set)
for i, p1 in enumerate(particles):
    for j, p2 in enumerate(particles[i+1:], i+1):
        time = find_collisions(p1, p2)
        if time < 98765:
            collisions[time].add((i, j))

alive = set(range(len(particles)))
for time in sorted(collisions.keys()):
    now_colliding = set()
    for p1, p2 in collisions[time]:
        if p1 in alive and p2 in alive:
            now_colliding |= {p1, p2}
    alive -= now_colliding

print(len(alive))
