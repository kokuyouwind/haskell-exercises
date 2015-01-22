module Answer.Chapter1
    (
     manlen
    , points
    , mancircle
    ) where

    -- (1)
    manlen :: (Int, Int) -> (Int, Int) -> Int
    manlen p1 p2 = abs(fst p1 - fst p2) + abs(snd p1 - snd p2)

    -- (2)
    points :: Int -> [(Int, Int)]
    points n = [(x,y) | x <- [-n .. n], y <- [-n .. n]]

    -- (3)
    mancircle :: Int -> [(Int, Int)]
    mancircle n = [p | p <- points n, manlen (0,0) p == n]
