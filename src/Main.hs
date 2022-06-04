{-# LANGUAGE TypeApplications #-}

module Main (main) where

import Text.Read (readMaybe)

main :: IO ()
main =
  case readMaybe @Int "incomplete case" of
    Nothing -> putStrLn "Nothing to see here."
