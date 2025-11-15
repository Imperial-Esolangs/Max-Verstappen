module Mappings where

import Functionality
import Data.List

-- Initialisations
initialState :: ProgramState
initialState = ([], 0, repeat 0)

validCommands :: [String]
validCommands = ["Simplylovely","Iamstupid","BoxBox","Glovesandsteeringwheel!",
    "That'samassivejob","Copythat","Multi-21","Stayout!","P1","P2","P3",
    "It'slightsoutandawaywego!","Chequeredflag"]

opList :: [String]
opList = ["Simplylovely","Iamstupid","BoxBox","Glovesandsteeringwheel!", 
    "P1","P2","P3", "That'samassivejob", "Copythat"]

-- Get lines from program
getLines :: String -> [String]
getLines pgm = 
    [verifyLine line| line <- lines [chr | chr <- pgm, chr /= ' '], 
        line /= "" && not ("//" `isPrefixOf` line)]

makeErrorMessage :: String -> String
makeErrorMessage lne = "Your program DNFed due to the following line:\n" ++ lne

runtimeErrorMessage :: String
runtimeErrorMessage = "Your program DNFed because there was no previous\
    \ stack item. "

-- Verify that line exists
verifyLine :: String -> String
verifyLine lne
    | lne `elem` validCommands = lne
    | otherwise                = error (makeErrorMessage lne)

parseOp :: String -> ProgramState -> ProgramState
parseOp "Simplylovely" = incr
parseOp "Iamstupid" = decr
parseOp "P1" = incr26
parseOp "P2" = incr18
parseOp "P3" = incr15
parseOp "BoxBox" = movePointerNext
parseOp "Glovesandsteeringwheel!" = \st@(pv, _, _) ->
    if null pv then
        error runtimeErrorMessage
    else movePointerPrev st


