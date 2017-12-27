import math

const
  steps = 12667664
         # (write, move, state (A=0 .. F=5))
  states = [[(1,  1, 1), (0, -1, 2)],
            [(1, -1, 0), (1,  1, 3)],
            [(0, -1, 1), (0, -1, 4)],
            [(1,  1, 0), (0,  1, 1)],
            [(1, -1, 5), (1, -1, 2)],
            [(1,  1, 3), (1,  1, 0)]
           ]
var
  tape: array[-6000 .. 60, int] # tweaked after tracking min & max position
  position: int
  state = 0

for _ in 1 .. steps:
  let (write, move, newState) = states[state][tape[position]]
  tape[position] = write
  position += move
  state = newState

echo tape.sum
