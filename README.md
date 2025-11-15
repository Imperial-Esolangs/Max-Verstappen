# Max-Verstappen
## Introduction
This is a Turing-complete esoteric programming language based on famous quotes/sayings from Formula 1. We take a simplistic approach and mirror the esoteric language “brainfuck”. 

The compiler for this language is written using Haskell. Haskell is a functional language which allows for paradigms such as functional programming, lambda calculus, and so on. Due to these features, this makes Haskell powerful when it comes to parsing expressions. This choice was made due to inspiration from lectures by Dr Nick Wu & Dr Jamie Willis (Imperial College London).

A final shoutout: thank you to my boy Not-TNB (https://github.com/Not-TNB) for introducing me to esolangs.

## Workings:
We use a simple stack model to perform the operations we want. We start with an infinitely deep stack and a pointer initialised to the top of the stack. The values in the stack can be incremented or decremented, and we can move left or right along the stack. We also implement a loop operation that runs when the cell is not empty. Furthermore, ASCII characters can be input or printed, stored internally as their associated numeric value.

## Semantics:
Each programme begins with “It’s lights out and away we go!” and ends with “Chequered flag”. Eight quotes are mapped to eight operations. You must separate each operation with a newline for the code to compile.

Items within a loop can be indented by spaces, as the compiler will remove all spaces when executing code. Furthermore, comments can be written using "//". However, a comment must take up an entire line

## Core Operations:
|         **Keyword**        |                              **Operation**                              |
|:--------------------------:|:-----------------------------------------------------------------------:|
| Simply lovely              | Increment the current cell by 1                                         |
| I am stupid                | Decrement the current cell by 1                                         |
| Box Box                    | Move pointer right (increment pointer)                                  |
| Gloves and steering wheel! | Move pointer left or decrement pointer (yes this needs the exclamation) |
| That’s a massive job       | Output current cell as ASCII character                                  |
| Copy that (Char)           | Pushes ASCII value of Char in brackets onto the stack                   |
| Multi-21                   | Loop start (while current cell != 0)                                    |
| Stay out!                  | Loop end (also needs the exclamation)                                   |

## Additional operations:
| **Keyword** |         **Operation**        |
|:-----------:|:----------------------------:|
| P1          | Increment current cell by 26 |
| P2          | Increment current cell by 18 |
| P3          | Increment current cell by 15 |

## Warnings!
This language is very fragile. If the pointer is moved within a Multi-21 clause, the Multi-21 will look at the newly-moved pointer rather than where the pointer was pointing on the stack when the clause was invoked.

## Example programme:
```
It's lights out and away we go!
Simply lovely
Simply lovely
Simply lovely
Simply lovely
Simply lovely
Multi-21
    Box Box
    P3
    Gloves and steering wheel!
    I am stupid
Stay out!
Box Box
That's a massive job
Chequered flag
```

The above program should (if I wrote it correctly) print ‘K’ The 5 ```Simply lovely``` statements increment the stack value 5 times. When I run the loop, it runs 5 times, incrementing the next item on the stack by 15 each time to reach the ASCII value of 75. Then this is printed.

## Dependencies:
You must have the following installed on your computer:
- GHC 2021
- Cabal
- ANSI Terminal library

To run, simply open a terminal and cd to your target directory. Then type ```cabal run max-verstappen -- filename.verstappen```, replacing filename.verstappen with the actual program you want to run.

Have fun! If you want to contribute feel free to fork this repo and make a pull request :)
