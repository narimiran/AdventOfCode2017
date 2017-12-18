from collections import deque


def spin(insertions):
    spinlock = deque([0])
    for i in range(1, insertions+1):
        spinlock.rotate(-puzzle)
        spinlock.append(i)
    return spinlock


puzzle = 394
first_spinlock = spin(2017)
second_spinlock = spin(50_000_000)

print(first_spinlock[0])
print(second_spinlock[second_spinlock.index(0) + 1])
