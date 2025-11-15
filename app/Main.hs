module Main where

import Functionality
import Mappings
import Parser
import Execution
import System.Environment (getArgs)
import System.Console.ANSI
import System.IO (hSetBuffering, stdout, stdin, BufferMode(NoBuffering))

-- Execute program passed to cabal via arguments
main :: IO ()
main = do
    disableBuffering
    clearScreen -- Clear screen for readability
    (filename: args) <- getArgs -- Get filename
    contents <- readFile filename -- Read file
    execute contents -- Execute file

{-|
When ran via `cabal run`, Haskell will "buffer" the input and output streams
for performance. This is annoying, since it means that some printing can happen
out-of-order -- the strings are only written when a newline is entered!

There are a few ways of getting around this, like using `hFlush stdout` after
each print. However, in this case, it is simplest to just disable the buffering
altogether. This function *must* be called at the start of your `main` function.
-}
disableBuffering :: IO ()
disableBuffering = do
  hSetBuffering stdout NoBuffering
  hSetBuffering stdin NoBuffering
