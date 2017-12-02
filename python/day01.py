with open('./inputs/01.txt') as f:
    instructions = f.readline()

def solve(numbers, second_part=False):
    size = len(numbers)
    jump = 1 if not second_part else size//2
    return sum(n for i, n in enumerate(numbers) if n == numbers[i-jump])

nums = list(map(int, instructions))
print(solve(nums))
print(solve(nums, second_part=True))
