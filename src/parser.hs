module Parser where

import Functionality
import Mappings

-- Define an AST for our language
data Instr where
    Start :: Instr
    Op :: String -> Instr
    Loop :: [Instr] -> Instr
    End :: Instr
    deriving Show

-- Parse lines to AST
parse :: [String] -> ([Instr], [String])
parse [] = ([], [])
parse ("It'slightsoutandawaywego!" : rest) = (Start : instrs, rem)
    where (instrs, rem) = parse rest
parse ("Chequeredflag" : rest) = ([End], rest)
parse ("Multi-21" : rest) =
    let (body, rest') = parseUntilLoopEnd rest
        (after, rest'') = parse rest'
    in (Loop body : after, rest'')
parse ("Stayout!" : _) =
    error "Your program DNFed because u don't know how to write a loop.\n \
    \ Congratulations you are now Lance Stroll"
parse (tok : rest)
    | tok `elem` opList =
         let (next, rest') = parse rest
         in (Op tok : next, rest')
    | otherwise =
         error "How you managed to unlock this error message is beyond me but\
         \ congrats. Send me your code please because I need to see this."

-- Parse a loop
parseUntilLoopEnd :: [String] -> ([Instr], [String])
parseUntilLoopEnd [] =
    error "Your program DNFed because u don't know how to write a loop.\n \
    \ Congratulations you are now Lance Stroll"
parseUntilLoopEnd ("Stayout!" : rest) =
    ([], rest)
parseUntilLoopEnd ("Multi-21" : rest) =
    let (inner, rest1) = parseUntilLoopEnd rest
        (next, rest2)  = parseUntilLoopEnd rest1
    in (Loop inner : next, rest2)
parseUntilLoopEnd (tok : rest)
    | tok `elem` opList =
        let (next, rest') = parseUntilLoopEnd rest
        in (Op tok : next, rest')
    | tok == "Chequeredflag" =
        error "Your program DNFed because you ended it before closing the loop.\
        \ \nYou are now Lance Stroll"
    | otherwise =
        error "Wow, congrats. You probably reached this error message because\
        \ you gave it a lights out command midway through a loop. If this isn't\
        \ the case, please send me your program."

