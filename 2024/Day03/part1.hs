module Main where

import Text.Regex.PCRE

main :: IO ()
main = do
  content <- readFile "input.txt"

  let pattern = "mul\\((\\d{1,3}),(\\d{1,3})\\)"
  let matches = getAllTextMatches (content =~ pattern) :: [String]

  let total =
        sum $
          map
            ( \match ->
                let nums = match =~ "(\\d+)" :: [[String]]
                    x = read (head nums !! 1) :: Int
                    y = read (nums !! 1 !! 1) :: Int
                 in x * y
            )
            matches

  putStrLn $ "Sum of all multiplication results: " ++ show total
