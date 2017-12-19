# Advent of Code 2017

After solving [AoC 2015 in Nim](https://github.com/narimiran/advent_of_code_2015), and [AoC 2016 in Python](https://github.com/narimiran/advent_of_code_2016), for 2017 I'll try to solve [Advent of Code puzzles](http://adventofcode.com/2017/) in both [Nim](https://nim-lang.org/) and Python.

My aim is to provide clean and readable, yet idiomatic, solutions in both languages. If you have any comment/suggestion/advice, please let me know!

&nbsp;

Task | Python solution | Nim solution | Note
--- | --- | --- | ---
[Day 1: Inverse Captcha](http://adventofcode.com/2017/day/1) | [day01.py](python/day01.py) | [day01.nim](nim/day01.nim) | Taking advantage of Python's negative indices.
[Day 2: Corruption Checksum](http://adventofcode.com/2017/day/2) | [day02.py](python/day02.py) | [day02.nim](nim/day02.nim)
[Day 3: Spiral Memory](http://adventofcode.com/2017/day/3) | [day03.py](python/day03.py) | [day03.nim](nim/day03.nim) | Building a spiral with dict and iterators, in both versions.
[Day 4: High-Entropy Passphrases](http://adventofcode.com/2017/day/4) | [day04.py](python/day04.py) | [day04.nim](nim/day04.nim)
[Day 5: A Maze of Twisty Trampolines, All Alike](http://adventofcode.com/2017/day/5) | [day05.py](python/day05.py) | [day05.nim](nim/day05.nim) | Used `try-except` in Python for some nice speed improvement.
[Day 6: Memory Reallocation](http://adventofcode.com/2017/day/6) | [day06.py](python/day06.py) | [day06.nim](nim/day06.nim) | Python doesn't have `OrderedSet` (had to use `OrderedDict`).
[Day 7: Recursive Circus](http://adventofcode.com/2017/day/7) | [day07.py](python/day07.py) | [day07.nim](nim/day07.nim) | Python's `Counter.most_common()` is quite helpful/useful here.
[Day 8: I Heard You Like Registers](http://adventofcode.com/2017/day/8) | [day08.py](python/day08.py) | [day08.nim](nim/day08.nim)
[Day 9: Stream Processing](http://adventofcode.com/2017/day/9) | [day09.py](python/day09.py) | [day09.nim](nim/day09.nim)
[Day 10: Knot Hash](http://adventofcode.com/2017/day/10) | [day10.py](python/day10.py) | [day10.nim](nim/day10.nim) | Changed solutions to be reusable for Day 14. Python version uses `deque` with pop, rotate, and insert. Nim version is a more 'traditional' one. 
[Day 11: Hex Ed](http://adventofcode.com/2017/day/11) | [day11.py](python/day11.py) | [day11.nim](nim/day11.nim) | Python version uses cube coordinates, Nim version uses axial coordinates.
[Day 12: Digital Plumber](http://adventofcode.com/2017/day/12) | [day12.py](python/day12.py) | [day12.nim](nim/day12.nim) | BFS in Python, DFS in Nim.
[Day 13: Packet Scanners](http://adventofcode.com/2017/day/13) | [day13.py](python/day13.py) | [day13.nim](nim/day13.nim)
[Day 14: Disk Defragmentation](http://adventofcode.com/2017/day/14) | [day14.py](python/day14.py) | [day14.nim](nim/day14.nim)
[Day 15: Dueling Generators](http://adventofcode.com/2017/day/15) | [day15.py](python/day15.py) | [day15.nim](nim/day15.nim) | Python: generator `generator` generating generator's values.
[Day 16: Permutation Promenade](http://adventofcode.com/2017/day/16) | [day16.py](python/day16.py) | [day16.nim](nim/day16.nim)
[Day 17: Spinlock](http://adventofcode.com/2017/day/17) | [day17.py](python/day17.py) | [day17.nim](nim/day17.nim) | Brute force in Python, using `deque.rotate`. The expected version in Nim.
[Day 18: Duet](http://adventofcode.com/2017/day/18) | [day18.py](python/day18.py) | [day18.nim](nim/day18.nim)
