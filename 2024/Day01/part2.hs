module Main where

import Data.List (group, sort)
import Data.Maybe (fromMaybe)
import System.IO

main :: IO ()
main = do
  content <- readFile "input.txt"

  let pairs = map (\line -> let [x, y] = map read $ words line in (x, y)) $ lines content
  let (leftList, rightList) = unzip pairs

  let rightCounts = map (\g -> (head g, length g)) . group . sort $ rightList

  let similarities = map (\x -> x * fromMaybe 0 (lookup x rightCounts)) leftList
  let totalSimilarity = sum similarities

  putStrLn $ "Similarity score: " ++ show totalSimilarity
