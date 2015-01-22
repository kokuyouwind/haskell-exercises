module Src.Chapter4
    (
      tri_number
    , tetration
    , index
    , even_odd
    , insert
    , isort
    , part_num
    ) where

    -- (1.1)
    tri_number :: Int -> Int
    tri_number n = 0 {- Rewrite HERE! -}

    -- (1.2)
    tetration :: Integer -> Integer -> Integer
    tetration x n = 0 {- Rewrite HERE! -}

    -- (1.3)
    index :: Int -> [a] -> a
    index n (x:_) = x {- Rewrite HERE! -}

    -- (1.4)
    even_odd :: [Int] -> ([Int], [Int])
    even_odd [] = ([], []) {- Rewrite HERE! -}

    -- (2.1)
    insert :: Ord a => [a] -> a -> [a]
    insert [] y = [] {- Rewrite HERE! -}

    -- (2.2)
    isort :: Ord a => [a] -> [a]
    isort [] = [] {- Rewrite HERE! -}

    --- (3)
    part_num :: Int -> Int
    part_num n = 0 {- Rewrite HERE! -}
