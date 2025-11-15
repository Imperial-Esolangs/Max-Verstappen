module Execution where

import Parser
import Functionality
import Mappings

-- Run parsed program
runProgram :: [Instr] -> ProgramState -> IO ProgramState
runProgram [] st = return st
runProgram (instr : rest) st@(pv, it, fv) = case instr of

    -- Program start or end
    Start -> do
        putStrLn "It's lights out and away we go!"
        runProgram rest initialState

    
    End -> do
        putStrLn "\nChequered flag. Well done mate!"
        return st

    -- IO Operations
    Op "That'samassivejob" -> do
        outputItem st
        runProgram rest st

    Op "Copythat" -> do
        st' <- inputChar st
        runProgram rest st'

    -- Other operations
    Op tok -> do
        let st'@(pv', it', fv') = parseOp tok st
        runProgram rest st'

    -- Loop
    Loop body ->
        if it == 0
           then runProgram rest st
        else do
            st' <- runProgram body st
            runProgram (instr:rest) st'

-- Tie everything together into a clean function which executes String
execute :: String -> IO ()
execute src = do
    let lnes = getLines src
    let (ast, _) = parse lnes
    _ <- runProgram ast initialState
    return ()
