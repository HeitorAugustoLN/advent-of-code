module Main where

import System.IO

main :: IO ()
main = do
  content <- readFile "input.txt"

  let reports = map (map read . words) $ lines content
  let safeCount = length $ filter checkReport reports

  putStrLn $ "Number of safe reports with Problem Dampener: " ++ show safeCount
  where
    checkReport xs =
      let isValid sequence =
            let differences = zipWith (-) (tail sequence) sequence
                isMonotonic = all (> 0) differences || all (< 0) differences
                validDiffs = all (\d -> abs d >= 1 && abs d <= 3) differences
             in isMonotonic && validDiffs

          removeOneAtTime sequence =
            [take i sequence ++ drop (i + 1) sequence | i <- [0 .. length sequence - 1]]
       in isValid xs || any isValid (removeOneAtTime xs)
