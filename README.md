# Advent of Code 2017

All my Advent of Code repos:

* [AoC 2015 in Nim, Python](https://github.com/narimiran/advent_of_code_2015)
* [AoC 2016 in Python, Clojure (+ visualizations)](https://github.com/narimiran/advent_of_code_2016)
* [AoC 2017 in Nim, OCaml, Python](https://github.com/narimiran/AdventOfCode2017) (this repo)
* [AoC 2018 in Nim, Python, Racket](https://github.com/narimiran/AdventOfCode2018)
* [AoC 2019 in OCaml, Python](https://github.com/narimiran/AdventOfCode2019)
* [AoC 2020 in Nim, one liner-y Python, Racket](https://github.com/narimiran/AdventOfCode2020)
* [AoC 2021 in Python, Racket](https://github.com/narimiran/AdventOfCode2021)
* [AoC 2022 in Python, Clojure](https://github.com/narimiran/AdventOfCode2022)
* [AoC 2023 in Clojure](https://github.com/narimiran/AdventOfCode2023)
* [AoC 2024 in Clojure (Clerk notebooks)](https://github.com/narimiran/aoc2024)

&nbsp;


## Solutions

My aim is to provide clean and readable, yet idiomatic, solutions in all three languages.
If you have any comment/suggestion/advice, please let me know!

Originally, I've solved all tasks in Nim and Python as they were released.
OCaml solutions were added in November 2019 as a preparation for AoC 2019 (these were my first steps in OCaml).


Task                                                                                 | Nim solution               | OCaml solution             | Python solution             | Note
---                                                                                  | ---                        | ---                        | ---                         | ---
[Day 1: Inverse Captcha](http://adventofcode.com/2017/day/1)                         | [day01.nim](nim/day01.nim) | [day01.ml](ocaml/day01.ml) | [day01.py](python/day01.py) | Taking advantage of Python's negative indices.
[Day 2: Corruption Checksum](http://adventofcode.com/2017/day/2)                     | [day02.nim](nim/day02.nim) | [day02.ml](ocaml/day02.ml) | [day02.py](python/day02.py) |
[Day 3: Spiral Memory](http://adventofcode.com/2017/day/3)                           | [day03.nim](nim/day03.nim) | [day03.ml](ocaml/day03.ml) | [day03.py](python/day03.py) | Building a spiral with table/map/dict in all three versions; using iterators in Nim and Python.
[Day 4: High-Entropy Passphrases](http://adventofcode.com/2017/day/4)                | [day04.nim](nim/day04.nim) | [day04.ml](ocaml/day04.ml) | [day04.py](python/day04.py) |
[Day 5: A Maze of Twisty Trampolines, All Alike](http://adventofcode.com/2017/day/5) | [day05.nim](nim/day05.nim) | [day05.ml](ocaml/day05.ml) | [day05.py](python/day05.py) | Used `try-except` in Python for some nice speed improvement.
[Day 6: Memory Reallocation](http://adventofcode.com/2017/day/6)                     | [day06.nim](nim/day06.nim) | [day06.ml](ocaml/day06.ml) | [day06.py](python/day06.py) | Python doesn't have `OrderedSet` (had to use `OrderedDict`).
[Day 7: Recursive Circus](http://adventofcode.com/2017/day/7)                        | [day07.nim](nim/day07.nim) | [day07.ml](ocaml/day07.ml) | [day07.py](python/day07.py) | Python's `Counter.most_common()` is quite helpful/useful here.
[Day 8: I Heard You Like Registers](http://adventofcode.com/2017/day/8)              | [day08.nim](nim/day08.nim) | [day08.ml](ocaml/day08.ml) | [day08.py](python/day08.py) |
[Day 9: Stream Processing](http://adventofcode.com/2017/day/9)                       | [day09.nim](nim/day09.nim) | [day09.ml](ocaml/day09.ml) | [day09.py](python/day09.py) |
[Day 10: Knot Hash](http://adventofcode.com/2017/day/10)                             | [day10.nim](nim/day10.nim) | [day10.ml](ocaml/day10.ml) | [day10.py](python/day10.py) | Changed solutions to be reusable for Day 14. Python version uses `deque` with pop, rotate, and insert. Nim version is a more 'traditional' one.
[Day 11: Hex Ed](http://adventofcode.com/2017/day/11)                                | [day11.nim](nim/day11.nim) | [day11.ml](ocaml/day11.ml) | [day11.py](python/day11.py) | Python version uses cube coordinates, Nim and OCaml versions use axial coordinates.
[Day 12: Digital Plumber](http://adventofcode.com/2017/day/12)                       | [day12.nim](nim/day12.nim) | [day12.ml](ocaml/day12.ml) | [day12.py](python/day12.py) | BFS in Python, DFS in Nim and OCaml.
[Day 13: Packet Scanners](http://adventofcode.com/2017/day/13)                       | [day13.nim](nim/day13.nim) | [day13.ml](ocaml/day13.ml) | [day13.py](python/day13.py) | All three versions precalculate possible values of `delay` using [Chinese remainder theorem](https://en.wikipedia.org/wiki/Chinese_remainder_theorem) to gain a significant speedup.
[Day 14: Disk Defragmentation](http://adventofcode.com/2017/day/14)                  | [day14.nim](nim/day14.nim) | [day14.ml](ocaml/day14.ml) | [day14.py](python/day14.py) |
[Day 15: Dueling Generators](http://adventofcode.com/2017/day/15)                    | [day15.nim](nim/day15.nim) | [day15.ml](ocaml/day15.ml) | [day15.py](python/day15.py) | Python: generator `generator` generating generator's values. In Nim, using bit masking gives great speed boost.
[Day 16: Permutation Promenade](http://adventofcode.com/2017/day/16)                 | [day16.nim](nim/day16.nim) | [day16.ml](ocaml/day16.ml) | [day16.py](python/day16.py) |
[Day 17: Spinlock](http://adventofcode.com/2017/day/17)                              | [day17.nim](nim/day17.nim) | [day17.ml](ocaml/day17.ml) | [day17.py](python/day17.py) | Brute force in Python, using `deque.rotate`. The expected version in Nim, optimized.
[Day 18: Duet](http://adventofcode.com/2017/day/18)                                  | [day18.nim](nim/day18.nim) | [day18.ml](ocaml/day18.ml) | [day18.py](python/day18.py) |
[Day 19: A Series of Tubes](http://adventofcode.com/2017/day/19)                     | [day19.nim](nim/day19.nim) | [day19.ml](ocaml/day19.ml) | [day19.py](python/day19.py) | All three solutions use complex numbers, which are great for the rotations in 2D plane.
[Day 20: Particle Swarm](http://adventofcode.com/2017/day/20)                        | [day20.nim](nim/day20.nim) | [day20.ml](ocaml/day20.ml) | [day20.py](python/day20.py) |
[Day 21: Fractal Art](http://adventofcode.com/2017/day/21)                           | [day21.nim](nim/day21.nim) | [day21.ml](ocaml/day21.ml) | [day21.py](python/day21.py) | Unoptimized solution in OCaml. Nim and Python solutions are optimized for the second part. Python version uses `numpy` and expands the grid (3 steps at once), Nim version counts the number of times each pattern is present after 18 iterations.
[Day 22: Sporifica Virus](http://adventofcode.com/2017/day/22)                       | [day22.nim](nim/day22.nim) | [day22.ml](ocaml/day22.ml) | [day22.py](python/day22.py) | OCaml: sum types and pattern matching is the name of the game. Python version uses a dict and a complex plane, Nim version uses an array (faster than a table) of a regular 2D plane with `enum` for the rotating directions.
[Day 23: Coprocessor Conflagration](http://adventofcode.com/2017/day/23)             | [day23.nim](nim/day23.nim) | [day23.ml](ocaml/day23.ml) | [day23.py](python/day23.py) |
[Day 24: Electromagnetic Moat](http://adventofcode.com/2017/day/24)                  | [day24.nim](nim/day24.nim) | [day24.ml](ocaml/day24.ml) | [day24.py](python/day24.py) | BFS in Python. A recursive search in Nim and OCaml, optimized.
[Day 25: The Halting Problem](http://adventofcode.com/2017/day/25)                   | [day25.nim](nim/day25.nim) | [day25.ml](ocaml/day25.ml) | [day25.py](python/day25.py) | Python version uses (default)dict. Nim version uses arrays, which are much faster than tables.
**Total time**:                                                                      | 0.49 sec                   | 1.01 sec\*                 | 16.1 sec\*                  | \* OCaml: unoptimized [day21.ml](ocaml/day21.ml). Python: without the brute-forced [day17.py](python/day17.py), and [day15.py](python/day15.py) was run in `pypy3`. For the detailed run times, see below.

&nbsp;



## Run times

* Nim version: 1.6.6
* OCaml version: 4.13.1
* Python version: 3.8.2
* CPU: AMD Ryzen 3700x @ 3.6 GHz (Linux 5.15)


Times are in milliseconds, the reported results are the average of 20 runs.

day |  nim | ocaml | python |
---:| ----:| -----:| ------:|
 01 |  0.3 |   0.8 |   13.3 |
 02 |  0.5 |   0.8 |   13.2 |
 03 |  0.4 |   0.7 |   13.6 |
 04 |  2.3 |   2.4 |   15.7 |
 05 | 69.0 |  63.8 | 2732.1 |
 06 |  2.4 |   3.6 |   32.6 |
 07 |  2.4 |   3.9 |   20.9 |
 08 |  1.2 |   1.5 |   14.5 |
 09 |  0.4 |   1.9 |   17.2 |
 10 |  0.5 |   1.4 |   24.7 |
 11 |  0.6 |   1.3 |   19.5 |
 12 |  1.8 |   2.3 |   16.7 |
 13 |  1.4 |  17.4 |   21.5 |
 14 |  8.8 |  32.3 |  566.2 |
 15 |195.4 | 383.2 | 2083\* |
 16 |  6.8 |  71.0 |  143.5 |
 17 |  0.9 |   4.8 |    -\* |
 18 |  0.7 |   4.6 |   88.8 |
 19 |  0.8 |   1.2 |   21.4 |
 20 |  9.2 |  18.2 | 1622.5 |
 21 |  0.5 | 145.0 |  197.1 |
 22 | 50.4 | 139.3 | 3555.9 |
 23 |  0.5 |   1.0 |   15.1 |
 24 | 10.8 |  52.1 | 1242.2 |
 25 | 48.8 |  52.3 | 3649.1 |


OCaml Day21 was not optimized.  
Python Day15 was run with `pypy3`, Python Day17 was brute-forced.
