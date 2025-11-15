module Functionality where

import Data.Char

-- Structure
-- Each function takes three items
-- Previous stack, current item, future stack
-- Previous stack is initialised to []
-- Current item is initialised to 0
-- Future stack is initialised to [0..]

-- Define types
type Previous = [Int]
type Current = Int
type Future = [Int]
type ProgramState = (Previous, Current, Future)
type Buffer = [Char]

-- Increment stack
incr :: ProgramState -> ProgramState
incr (pv, it, ft) = (pv, it + 1, ft)

-- Decrement stack
decr :: ProgramState -> ProgramState
decr (pv, it, ft) = (pv, it - 1, ft)

-- Move pointer to next item on stack
movePointerNext :: ProgramState -> ProgramState
movePointerNext (pv, it, f: ft) = (it : pv, f, ft)

-- Move pointer to previous item on stack
movePointerPrev :: ProgramState -> ProgramState
movePointerPrev (p: pv, it, ft) = (pv, p, it : ft)

-- Output item on pointer as ASCII
outputItem :: ProgramState -> IO ()
outputItem st@(_, it, _) = do putChar (chr it)

-- Input item
inputChar :: ProgramState -> IO ProgramState
inputChar (pv, _, ft) = do
    ch <- getChar
    return (pv, ord ch, ft)

-- Incr by 26
incr26 :: ProgramState -> ProgramState
incr26 (pv, it, ft) = (pv, it + 26, ft)

-- Incr by 18
incr18 :: ProgramState -> ProgramState
incr18 (pv, it, ft) = (pv, it + 18, ft)

-- Incr by 26
incr15 :: ProgramState -> ProgramState
incr15 (pv, it, ft) = (pv, it + 15, ft)
