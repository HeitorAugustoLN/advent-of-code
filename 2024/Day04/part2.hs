module Main where

main :: IO ()
main = do
  input <- readFile "input.txt"

  let grid = lines input
  let height = length grid
  let width = length (head grid)

  let inBounds y x = y >= 0 && y < height && x >= 0 && x < width
  let getDiagonalWords y x = do
        if not $ all (uncurry inBounds) [(y - 1, x - 1), (y - 1, x + 1), (y, x), (y + 1, x - 1), (y + 1, x + 1)]
          then []
          else
            let diag1 = [grid !! (y - 1) !! (x - 1), grid !! y !! x, grid !! (y + 1) !! (x + 1)]
                diag2 = [grid !! (y - 1) !! (x + 1), grid !! y !! x, grid !! (y + 1) !! (x - 1)]
             in ( [ (y, x)
                    | (diag1 == "MAS" && diag2 == "MAS")
                        || (diag1 == "MAS" && diag2 == "SAM")
                        || (diag1 == "SAM" && diag2 == "MAS")
                        || (diag1 == "SAM" && diag2 == "SAM")
                  ]
                )

  let matches =
        [ (y, x)
          | y <- [1 .. height - 2],
            x <- [1 .. width - 2],
            not $ null $ getDiagonalWords y x
        ]

  print $ length matches
