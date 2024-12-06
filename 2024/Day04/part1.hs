module Main where

main :: IO ()
main = do
  input <- readFile "input.txt"
  let grid = lines input
  let height = length grid
  let width = length (head grid)

  let directions = [(dx, dy) | dx <- [-1 .. 1], dy <- [-1 .. 1], (dx, dy) /= (0, 0)]

  let inBounds y x = y >= 0 && y < height && x >= 0 && x < width

  let getWord y x (dx, dy) len =
        if all (\i -> inBounds (y + dy * i) (x + dx * i)) [0 .. len - 1]
          then Just [grid !! (y + dy * i) !! (x + dx * i) | i <- [0 .. len - 1]]
          else Nothing

  let matches =
        [ (y, x, dir)
          | y <- [0 .. height - 1],
            x <- [0 .. width - 1],
            dir <- directions,
            getWord y x dir 4 == Just "XMAS"
        ]

  -- Print result
  print $ length matches
