module Main where

import Text.Regex.PCRE

main :: IO ()
main = do
  content <- readFile "input.txt"

  let tokens = getAllTextMatches (content =~ "(do\\(\\)|don't\\(\\)|mul\\(\\d{1,3},\\d{1,3}\\))") :: [String]
  let (_, total) = foldl processToken (True, 0) tokens

  putStrLn $ "Sum of enabled multiplication results: " ++ show total
  where
    processToken :: (Bool, Int) -> String -> (Bool, Int)
    processToken (enabled, sum) token =
      case token of
        "do()" -> (True, sum)
        "don't()" -> (False, sum)
        mul
          | "mul(" `isPrefixOf` mul ->
              if enabled
                then (enabled, sum + calculateMul mul)
                else (enabled, sum)
        _ -> (enabled, sum)

    calculateMul :: String -> Int
    calculateMul mulStr =
      let nums = mulStr =~ "(\\d+)" :: [[String]]
          x = read (head nums !! 1) :: Int
          y = read (nums !! 1 !! 1) :: Int
       in x * y

    isPrefixOf :: String -> String -> Bool
    isPrefixOf [] _ = True
    isPrefixOf _ [] = False
    isPrefixOf (x : xs) (y : ys) = x == y && isPrefixOf xs ys
