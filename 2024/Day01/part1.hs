module Main where

import Data.List (sort)
import System.IO

main :: IO ()
main = do
  content <- readFile "input.txt"

  let pairs = map (\line -> let [x, y] = map read $ words line in (x, y)) $ lines content
  let (leftList, rightList) = unzip pairs

  let sortedLeft = sort leftList
  let sortedRight = sort rightList

  let distances = zipWith (\x y -> abs (x - y)) sortedLeft sortedRight
  let totalDistance = sum distances

  putStrLn $ "Total distance: " ++ show totalDistance
