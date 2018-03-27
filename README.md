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
[Day 13: Packet Scanners](http://adventofcode.com/2017/day/13) | [day13.py](python/day13.py) | [day13.nim](nim/day13.nim) | Python version precalculates possible values of `delay` using [Chinese remainder theorem](https://en.wikipedia.org/wiki/Chinese_remainder_theorem) to gain ~70x speedup.
[Day 14: Disk Defragmentation](http://adventofcode.com/2017/day/14) | [day14.py](python/day14.py) | [day14.nim](nim/day14.nim)
[Day 15: Dueling Generators](http://adventofcode.com/2017/day/15) | [day15.py](python/day15.py) | [day15.nim](nim/day15.nim) | Python: generator `generator` generating generator's values. In Nim, using bit masking gives great speed boost.
[Day 16: Permutation Promenade](http://adventofcode.com/2017/day/16) | [day16.py](python/day16.py) | [day16.nim](nim/day16.nim)
[Day 17: Spinlock](http://adventofcode.com/2017/day/17) | [day17.py](python/day17.py) | [day17.nim](nim/day17.nim) | Brute force in Python, using `deque.rotate`. The expected version in Nim, optimized.
[Day 18: Duet](http://adventofcode.com/2017/day/18) | [day18.py](python/day18.py) | [day18.nim](nim/day18.nim)
[Day 19: A Series of Tubes](http://adventofcode.com/2017/day/19) | [day19.py](python/day19.py) | [day19.nim](nim/day19.nim) | Both solutions use complex numbers, which are great for the rotations in 2D plane.
[Day 20: Particle Swarm](http://adventofcode.com/2017/day/20) | [day20.py](python/day20.py) | [day20.nim](nim/day20.nim) 
[Day 21: Fractal Art](http://adventofcode.com/2017/day/21) | [day21.py](python/day21.py) | [day21.nim](nim/day21.nim) | Both solutions are optimized for the second part. Python version uses `numpy`.
[Day 22: Sporifica Virus](http://adventofcode.com/2017/day/22) | [day22.py](python/day22.py) | [day22.nim](nim/day22.nim) | Python version uses a dict and a complex plane, Nim version uses an array (faster than a table) of a regular 2D plane with `enum` for the rotating directions.
[Day 23: Coprocessor Conflagration](http://adventofcode.com/2017/day/23) | [day23.py](python/day23.py) | [day23.nim](nim/day23.nim)
[Day 24: Electromagnetic Moat](http://adventofcode.com/2017/day/24) | [day24.py](python/day24.py) | [day24.nim](nim/day24.nim) | BFS in Python. A recursive search in Nim, optimized.
[Day 25: The Halting Problem](http://adventofcode.com/2017/day/25) | [day25.py](python/day25.py) | [day25.nim](nim/day25.nim) | Python version uses (default)dict. Nim version uses arrays, which are much faster than tables.
**Total time**: | 35.6 sec* | 1.8 sec | * without the brute-forced [day17.py](python/day17.py), and [day15.py](python/day15.py) was run in `pypy3`. For the detailed run times, see below.

&nbsp;

## Run times

Python version: 3.6.4  
Nim version: 0.18.0  
CPU: Intel i7-970 @ 3.20 GHz (Linux 4.9.87)

Day | Python | Nim
--- | --- | ---
1 | 0:00.06 | 0:00.00
2 | 0:00.08 | 0:00.00
3 | 0:00.03 | 0:00.00
4 | 0:00.06 | 0:00.00
5 | 0:06.48 | 0:00.08
6 | 0:00.12 | 0:00.02
7 | 0:00.08 | 0:00.00
8 | 0:00.03 | 0:00.00
9 | 0:00.06 | 0:00.00
10 | 0:00.09 | 0:00.00
11 | 0:00.05 | 0:00.00
12 | 0:00.06 | 0:00.01
13 | 0:00.08 | 0:00.11
14 | 0:01.21 | 0:00.02
15 | 0:04.89** | 0:00.38
16 | 0:00.68 | 0:00.13
17 | - | 0:00.00
18 | 0:00.23 | 0:00.06
19 | 0:00.08 | 0:00.00
20 | 0:04.35 | 0:00.18
21 | 0:00.97 | 0:00.17
22 | 0:06.87 | 0:00.22
23 | 0:00.07 | 0:00.00
24 | 0:02.71 | 0:00.14
25 | 0:07.05 | 0:00.10
** pypy3 (CPython runs ~10x slower)
