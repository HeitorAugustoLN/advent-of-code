module Main where

import System.IO

main :: IO ()
main = do
  content <- readFile "input.txt"

  let reports = map (map read . words) $ lines content
  let safeReports =
        filter
          ( \xs ->
              let differences = zipWith (-) (tail xs) xs
                  isMonotonic = all (> 0) differences || all (< 0) differences
                  validDiffs = all (\d -> abs d >= 1 && abs d <= 3) differences
               in isMonotonic && validDiffs
          )
          reports
  let safeCount = length safeReports

  putStrLn $ "Number of safe reports: " ++ show safeCount
