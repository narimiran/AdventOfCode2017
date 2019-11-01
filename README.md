# Advent of Code 2017

All my Advent of Code repos:

* [AoC 2015 in Nim](https://github.com/narimiran/advent_of_code_2015)
* [AoC 2016 in Python](https://github.com/narimiran/advent_of_code_2016)
* [AoC 2017 in Nim, Ocaml, Python](https://github.com/narimiran/AdventOfCode2017) (this repo)
* [AoC 2018 in Nim](https://github.com/narimiran/AdventOfCode2018)


&nbsp;


## Solutions

My aim is to provide clean and readable, yet idiomatic, solutions in all three languages.
If you have any comment/suggestion/advice, please let me know!

Originally, I've solved all tasks in Nim and Python as they were released.
Ocaml solutions were added in Novemeber 2019 as a preparation for AoC 2019 (these were my first steps in Ocaml).


Task                                                                                 | Nim solution               | Ocaml solution | Python solution             | Note
---                                                                                  | ---                        | ---            | ---                         | ---
[Day 1: Inverse Captcha](http://adventofcode.com/2017/day/1)                         | [day01.nim](nim/day01.nim) |                | [day01.py](python/day01.py) | Taking advantage of Python's negative indices.
[Day 2: Corruption Checksum](http://adventofcode.com/2017/day/2)                     | [day02.nim](nim/day02.nim) |                | [day02.py](python/day02.py) |
[Day 3: Spiral Memory](http://adventofcode.com/2017/day/3)                           | [day03.nim](nim/day03.nim) |                | [day03.py](python/day03.py) | Building a spiral with dict and iterators, in both versions.
[Day 4: High-Entropy Passphrases](http://adventofcode.com/2017/day/4)                | [day04.nim](nim/day04.nim) |                | [day04.py](python/day04.py) |
[Day 5: A Maze of Twisty Trampolines, All Alike](http://adventofcode.com/2017/day/5) | [day05.nim](nim/day05.nim) |                | [day05.py](python/day05.py) | Used `try-except` in Python for some nice speed improvement.
[Day 6: Memory Reallocation](http://adventofcode.com/2017/day/6)                     | [day06.nim](nim/day06.nim) |                | [day06.py](python/day06.py) | Python doesn't have `OrderedSet` (had to use `OrderedDict`).
[Day 7: Recursive Circus](http://adventofcode.com/2017/day/7)                        | [day07.nim](nim/day07.nim) |                | [day07.py](python/day07.py) | Python's `Counter.most_common()` is quite helpful/useful here.
[Day 8: I Heard You Like Registers](http://adventofcode.com/2017/day/8)              | [day08.nim](nim/day08.nim) |                | [day08.py](python/day08.py) |
[Day 9: Stream Processing](http://adventofcode.com/2017/day/9)                       | [day09.nim](nim/day09.nim) |                | [day09.py](python/day09.py) |
[Day 10: Knot Hash](http://adventofcode.com/2017/day/10)                             | [day10.nim](nim/day10.nim) |                | [day10.py](python/day10.py) | Changed solutions to be reusable for Day 14. Python version uses `deque` with pop, rotate, and insert. Nim version is a more 'traditional' one.
[Day 11: Hex Ed](http://adventofcode.com/2017/day/11)                                | [day11.nim](nim/day11.nim) |                | [day11.py](python/day11.py) | Python version uses cube coordinates, Nim version uses axial coordinates.
[Day 12: Digital Plumber](http://adventofcode.com/2017/day/12)                       | [day12.nim](nim/day12.nim) |                | [day12.py](python/day12.py) | BFS in Python, DFS in Nim.
[Day 13: Packet Scanners](http://adventofcode.com/2017/day/13)                       | [day13.nim](nim/day13.nim) |                | [day13.py](python/day13.py) | Both versions precalculate possible values of `delay` using [Chinese remainder theorem](https://en.wikipedia.org/wiki/Chinese_remainder_theorem) to gain a significant speedup.
[Day 14: Disk Defragmentation](http://adventofcode.com/2017/day/14)                  | [day14.nim](nim/day14.nim) |                | [day14.py](python/day14.py) |
[Day 15: Dueling Generators](http://adventofcode.com/2017/day/15)                    | [day15.nim](nim/day15.nim) |                | [day15.py](python/day15.py) | Python: generator `generator` generating generator's values. In Nim, using bit masking gives great speed boost.
[Day 16: Permutation Promenade](http://adventofcode.com/2017/day/16)                 | [day16.nim](nim/day16.nim) |                | [day16.py](python/day16.py) |
[Day 17: Spinlock](http://adventofcode.com/2017/day/17)                              | [day17.nim](nim/day17.nim) |                | [day17.py](python/day17.py) | Brute force in Python, using `deque.rotate`. The expected version in Nim, optimized.
[Day 18: Duet](http://adventofcode.com/2017/day/18)                                  | [day18.nim](nim/day18.nim) |                | [day18.py](python/day18.py) |
[Day 19: A Series of Tubes](http://adventofcode.com/2017/day/19)                     | [day19.nim](nim/day19.nim) |                | [day19.py](python/day19.py) | Both solutions use complex numbers, which are great for the rotations in 2D plane.
[Day 20: Particle Swarm](http://adventofcode.com/2017/day/20)                        | [day20.nim](nim/day20.nim) |                | [day20.py](python/day20.py) |
[Day 21: Fractal Art](http://adventofcode.com/2017/day/21)                           | [day21.nim](nim/day21.nim) |                | [day21.py](python/day21.py) | Both solutions are optimized for the second part. Python version uses `numpy` and expands the grid (3 steps at once), Nim version counts the number of times each pattern is present after 18 iterations.
[Day 22: Sporifica Virus](http://adventofcode.com/2017/day/22)                       | [day22.nim](nim/day22.nim) |                | [day22.py](python/day22.py) | Python version uses a dict and a complex plane, Nim version uses an array (faster than a table) of a regular 2D plane with `enum` for the rotating directions.
[Day 23: Coprocessor Conflagration](http://adventofcode.com/2017/day/23)             | [day23.nim](nim/day23.nim) |                | [day23.py](python/day23.py) |
[Day 24: Electromagnetic Moat](http://adventofcode.com/2017/day/24)                  | [day24.nim](nim/day24.nim) |                | [day24.py](python/day24.py) | BFS in Python. A recursive search in Nim, optimized.
[Day 25: The Halting Problem](http://adventofcode.com/2017/day/25)                   | [day25.nim](nim/day25.nim) |                | [day25.py](python/day25.py) | Python version uses (default)dict. Nim version uses arrays, which are much faster than tables.
**Total time**:                                                                      | 0.84 sec                   |                | 33.3 sec\*                  | \* without the brute-forced [day17.py](python/day17.py), and [day15.py](python/day15.py) was run in `pypy3`. For the detailed run times, see below.

&nbsp;



## Run times

* Nim version: 1.0.0
* Ocaml version: 4.08.1+flambda
* Python version: 3.7.4
* CPU: Intel i7-970 @ 3.20 GHz (Linux 4.19)


Times are in milliseconds, the reported results are the average of 20 runs.

day |  nim | python
--- | ---- | ------
 01 |    1 |     34
 02 |    1 |     29
 03 |    1 |     31
 04 |    5 |     39
 05 |  139 |   6183
 06 |    5 |     76
 07 |    5 |     55
 08 |    3 |     37
 09 |    1 |     43
 10 |    1 |     53
 11 |    2 |     48
 12 |    5 |     39
 13 |    9 |     42
 14 |   25 |   1032
 15 |  357 | 4986\*
 16 |   23 |    292
 17 |    2 |    0\*
 18 |    1 |    206
 19 |    1 |     47
 20 |   34 |   3477
 21 |    2 |     26
 22 |  112 |   6577
 23 |    2 |     36
 24 |   34 |   2634
 25 |   68 |   7292

\* pypy3 (CPython runs ~10x slower)
